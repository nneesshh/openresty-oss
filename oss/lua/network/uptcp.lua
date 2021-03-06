local _M = {
    _VERSION = "1.0.0.1",
    _DESCRIPTION = "wrapper of tcp upstream"
}

local tbl_insert = table.insert
local setmetatable, getmetatable = setmetatable, getmetatable
local tostring, pairs, ipairs = tostring, pairs, ipairs
local str_sub = string.sub

local ngx_worker = ngx.worker
local ngx_timer = ngx.timer
local ngx_thread = ngx.thread
local ngx_say = ngx.say
local ngx_sleep = ngx.sleep

local ngx_tcp = ngx.socket.tcp
local ngx_semaphore = require("ngx.semaphore")

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local client_helper = require(cwd .. "client_helper")

-- constant
local STATE_IDLE = 0
local STATE_CONNECTED = 1
local STATE_CLEANUP = 2
local STATE_CLOSED = 3

--
local mt = {__index = _M}

function _M.new(self, id)
    return setmetatable(
        {
            --
            id = id,
            --
            upstream = false,
            state = STATE_IDLE,
            --
            sema_send = false,
            sema_send_packet_queue = false,
            --
            enable_reconnect = true,
            reconnect_delay_seconds = 10.001
        },
        mt
    )
end

--
function _M.get_packet_obj(self)
    if self.packet_obj and self.upstream then
        return self.packet_obj
    end
end

--
function _M.send_raw(self, data)
    local s = self.upstream
    return s:send(data)
end

--
function _M.send_packet(self, ...)
    local packet_obj = self.packet_obj
    local sock = self.upstream
    return packet_obj:send_packet(sock, ...)
end

--
function _M.post_to_sema(self, msg)
    local meta = getmetatable(msg)
    local msgname = tfl(meta._descriptor.full_name)
    local msgdata = msg:SerializeToString()
    local to_send = {msgname, msgdata}

    tbl_insert(self.sema_send_packet_queue, to_send)
    return self.sema_send:post(1)
end

--
function _M.cleanup(self) 
    local sock = self.upstream
    if not sock then
        return nil, "not initialized"
    end
    sock:close()
    self.upstream = false
    self.state = STATE_CLEANUP
end        

--
function _M.close(self)
    self:cleanup()
    self.state = STATE_CLOSED
end

--
function _M.reconnect(self, opts, last_error)
    -- try reconnect
    if self.state ~= STATE_CLOSED and self.enable_reconnect and self.reconnect_delay_seconds > 0 then
        --
        print(tostring(last_error))
        -- sleep before reconnect
        print("connid=" .. tostring(self.id) .. ", reconnect after(s): " .. tostring(self.reconnect_delay_seconds))
        ngx_sleep(self.reconnect_delay_seconds)
        return self:connect(opts)
    else
        return nil, last_error
    end
end

--
local function _connect(self, workerid)
    -- new sock
    local sock, err1 = ngx_tcp()
    if not sock then
        return nil, "no socket -- workerid: " ..
            tostring(workerid) ..
                ", connid:" ..
                    tostring(self.id) ..
                        ", configid: " ..
                            tostring(self.opts.server.id) ..
                                ", cname: " ..
                                    self.opts.server.name ..
                                        ", host: " .. self.opts.server.host .. ", port: " .. tostring(self.opts.server.port)
    end

    --30s, 1s, 30s
    sock:settimeouts(30000, 1000, 30000) -- timeout for connect/send/receive

    local ok, err2
    local host = self.opts.server.host
    if host then
        local port = self.opts.server.port or 8860

        ok, err2 = sock:connect(host, port)
    else
        local path = self.opts.server.path
        if not path then
            return nil, 'neither "host" nor "path" options are specified'
        end

        ok, err2 = sock:connect("unix:" .. path)
    end

    --
    if ok then
        --
        return sock, true
    else
        local errstr =
            "connect failed(" ..
            err2 ..
                ") -- workerid: " ..
                    tostring(workerid) ..
                        ", connid: " ..
                            tostring(self.id) ..
                                ", configid: " ..
                                    tostring(self.opts.server.id) ..
                                        ", cname: " ..
                                            self.opts.server.name ..
                                                ", host: " ..
                                                    self.opts.server.host .. ", port: " .. tostring(self.opts.server.port)
        return nil, errstr
    end
end

--
function _M.connect(self, opts)
    --
    local workerid = ngx_worker.id()

    -- opts
    self.opts = opts

    --
    local sock, errstr = _connect(self, workerid)
    if sock then
        --
        self.upstream = sock
        self.state = STATE_CONNECTED

        -- packet obj
        self.packet_obj = opts.packet_cls.new()

        --
        if opts.connected_cb then
            opts.connected_cb(self)
        end
        return true
    end

    -- try reconnect
    return self:reconnect(opts, errstr)
end

--
function _M.read_packet(self)
    if self.opts and self.packet_obj and self.upstream then
        -- read packet loop
        local pkt, err, err_
        while true do
            pkt, err, err_ = self.packet_obj:read(self.upstream)
            if pkt then
                if self.opts.got_packet_cb then
                    -- packet dispatcher
                    self.opts.got_packet_cb(self, pkt)
                end
                return pkt, true
            elseif err ~= "timeout" then
                --
                if self.opts.disconnected_cb then
                    self.opts.disconnected_cb(self)
                end

                -- cleanup
                self:cleanup()
                return nil, "read_packet: failed, connid=" .. tostring(self.id) .. ", " .. err .. " -- " .. err_
            end
        end
    end
    return nil, "read_packet: not connected yet!!!"
end

--
function _M.init_sema(self)
    -- create sema
    self.sema_send = ngx_semaphore.new()
    self.sema_send_packet_queue = {}

    local function _sema_send_handler()
        --
        while self.state ~= STATE_CLOSED do
            local ok, err = self.sema_send:wait(10.0) -- wait for 10s
            if not ok then
                if err ~= "timeout" then
                    print("sema_send_handler: failed to wait on sema -- " .. err)
                    break
                end
            else
                local packet_obj = self.packet_obj
                local s = self.upstream

                for _, v in ipairs(self.sema_send_packet_queue) do
                    packet_obj:write(s, v[1], v[2], 0)
                end
                self.sema_send_packet_queue = {}
            end
        end
    end

    --
    return ngx_thread.spawn(_sema_send_handler)
end

--
function _M.run(self, opts, workerid)
    local function _run_handler()
        local ok, err
        local pkt, pkterr

        --
        self:init_sema()

        -- connect first time
        
        ok, err = self:connect(opts)

        -- run loop
        while ok do
            -- read packet loop
            while true do
                pkt, pkterr = self:read_packet()
                if not pkt then
                    break
                end
            end

            -- reconnect
            ok, err = self:reconnect(opts, pkterr)
        end

        --
        print("uptcp run over -- id=", self.id, err)
    end
    return ngx_thread.spawn(_run_handler)
end

return _M
