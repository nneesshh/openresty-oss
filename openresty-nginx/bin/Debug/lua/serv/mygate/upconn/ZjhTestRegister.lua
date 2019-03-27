local tbl_insert = table.insert
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
local robot_cls = require(cwd .. "ZjhRobot")
local zjh_defs = require(cwd .. "ZjhDefs")

local uptcpd = require("network.uptcp")
--local packet_cls = require("network.outer_packet")
--local packet_cls = require("network.inner_packet")
local packet_cls = require("network.zjh_packet")

local function _readUserInfo(po)
    local info = {}
    info.userTicketId = po:read_int32()
    info.userName = po:read_string()
    info.nickName = po:read_string()
    info.avatar = po:read_string()
    info.gender = po:read_byte()
    info.balance = po:read_int64()
    return info
end

local function _readRoomInfo(po)
    local info = {}
    info.roomId = po:read_int32()
    info.lowerLimit = po:read_int32()
    info.upperLimit = po:read_int32()
    info.baseCoin = po:read_int32()
    info.userCount = po:read_int32()
    return info
end

function _M.onRegister(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
        -- save sessionId
    local robot = conn.user.robot
    if robot then
        -- save sessionId
        robot.sessionId = sessionid
        robot.rooms = {}
 
        local po = conn:get_packet_obj()
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()
        resp.version = po:read_string()
        resp.host = po:read_string()
        resp.onlineCount = po:read_int32()
        resp.roomCount = po:read_byte()

        -- room info
        for i=1, resp.roomCount do
            local info = _readRoomInfo(po)
            tbl_insert(robot.rooms, info)
        end

        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
            -- user info
            robot.userInfo = _readUserInfo(po)

            --
            robot.state = 1

            --
            print("register ok -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

        elseif robot.userinfo then
            --
            print("register failed -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
        else
            --
            print("register failed -- errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
        end
    else
        print("[onRegister()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

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
        _M.doRegisterMsgCallbacks()

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

function _M.doRegisterMsgCallbacks()
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_REGISTER_RESP, _M.onRegister)
end

return _M