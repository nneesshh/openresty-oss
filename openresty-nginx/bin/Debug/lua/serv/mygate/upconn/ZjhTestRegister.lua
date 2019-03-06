local tostring, pairs, ipairs = tostring, pairs, ipairs

local _M = {
    upconnMap = {},
    --
    nextConnId = 1,
    running = false
}

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local pdir = (...):gsub("%.[^%.]+%.[^%.]+$", "") .. "."
local cfg_game_zjh = require(pdir .. "config.game_zjh")
local msg_dispatcher = require(cwd .."ZjhMsgDispatcher")
local robot_cls = require(cwd .. "ZjhTestRobot")

local uptcpd = require("serv.network.uptcp")
--local packet_cls = require("serv.network.outer_packet")
--local packet_cls = require("serv.network.inner_packet")
local packet_cls = require("serv.network.zjh_packet")

--
function _M.onUpconnAdd(upconn)
    local token = {
        id = upconn.id,
        upconn = upconn,
        released = false
    }
    _M.upconnMap[token.id] = token
    return token
end

--
function _M.onUpconnRemove(upconn)
    local token = _M.upconnMap[upconn.id]
    if token then
        token.release = true
        _M.upconnMap[token.id] = nil
    end
end

--
function _M.createUpconn()
    --
    local nextConnId = _M.nextConnId
    _M.nextConnId = _M.nextConnId + 1

    local upconn = uptcpd:new(nextConnId)
    _M.onUpconnAdd(upconn)
    return upconn
end

--
function _M.destroyUpconn(s)

end

--
function _M.check()
    for k, v in pairs(_M.upconnMap) do
        print("Forward: check connid -- ", tostring(k))
    end
end

--
function _M.start()
    local TEST_NUM_MAX = #cfg_game_zjh.robots
    --local TEST_NUM_MAX = 1

    --
    if not _M.running then
        --
        robot_cls.doRegisterMsgCallbacks()

        local connected_cb = function(self)
            print("connected_cb, connid=", tostring(self.id))

            self.user = self.user or {}
            self.user.robot = robot_cls:new(self)
            self.user.robot.cfg = self.opts.robot
            self.user.robot:register()
        end

        local disconnected_cb = function(self)
            print("disconnected_cb, connid=", tostring(self.id))
        end

        local got_packet_cb = function(self, pkt)
            msg_dispatcher.dispatch(self, pkt.sessionid, pkt.msgid, pkt.data)
        end

        --
        for _1, server in ipairs(cfg_game_zjh.servers) do
            if server.enable then
                local num = 0
                for _2, robot in ipairs(cfg_game_zjh.robots) do
                    local upconn = _M.createUpconn()
                    local opts = {
                        server = server,
                        robot = robot,
                        packet_cls = packet_cls,
                        connected_cb = connected_cb,
                        disconnected_cb = disconnected_cb,
                        got_packet_cb = got_packet_cb
                    }

                    --
                    upconn:run(opts)

                    --
                    num = num + 1
                    if num >= TEST_NUM_MAX then
                        break
                    end
                end
            end
        end

        --
        _M.running = true
    end
end

return _M