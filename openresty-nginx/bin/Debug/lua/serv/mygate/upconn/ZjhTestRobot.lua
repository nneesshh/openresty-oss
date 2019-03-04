local tbl_insert = table.insert
local tostring, pairs, ipairs = tostring, pairs, ipairs

local _M = {}

local mt = {__index = _M}

local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local zjh_defs = require(cwd .. "ZjhDefs")
local msg_dispatcher = require(cwd .."ZjhMsgDispatcher")

-- ENUM GAMETYPE
local GAMETYPE_ZJH = 1

-- ENUM ROBOTSTATE
local ROBOT_STATE_OFFLINE = 0
local ROBOT_STATE_LOBBOY = 1
local ROBOT_STATE_GAME = 2

function _M.new(self, upconn)
    return setmetatable(
        {
            upconn = upconn,
            gametype = ROBOT_STATE_OFFLINE,
            state = 0
        },
        mt
    )
end

function _M.onLogin(conn, sessionid, msgid, data)
    local resp = {}
    conn.user = conn.user or {}
    if conn.user.robot then
        local po = conn:get_packet_obj()
        po:reader_reset()
        
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()
        resp.version = po:read_string()
        resp.host = po:read_string()
        resp.onlineCount = po:read_int32()
        resp.roomCount = po:read_byte()
        resp.room = {}

        -- room info
        for i=1, resp.roomCount do
            local info = {}
            info.roomId = po:read_int32()
            info.lowerLimit = po:read_int32()
            info.upperLimit = po:read_int32()
            info.baseCoin = po:read_int32()
            info.userCount = po:read_int32()
            tbl_insert(resp.room, info)
        end

        -- user info
        resp.userTicketId = po:read_int32()
        resp.userName = po:read_string()
        resp.nickName = po:read_string()
        resp.avatar = po:read_string()
        resp.gender = po:read_int32()
        resp.balance = po:read_byte()

        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then

        elseif resp.errorCode == zjh_defs.ErrorCode.ERR_USER_NOT_FOUND then
            --
            self:doRegister()
            --
            conn.user.robot.state = ROBOT_STATE_OFFLINE

        end
    else
        print("got_packet_cb, connid=", tostring(conn.id))
    end
end

function _M.sendBadMsg(self)
    self.upconn:send_raw("\0\0\0\1")
end

function _M.sendLogin(self, cfg_robot)
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int32(cfg_robot.userid) -- userTicketId
    po:write_string(cfg_robot.username) -- userName
    po:write_string(cfg_robot.pwd) -- pwd
    po:write_string(cfg_robot.imei) -- imei
    po:write_string(cfg_robot.imsi) -- imsi
    po:write_string(cfg_robot.channel) -- channel
    po:write_string(cfg_robot.subChannel) -- subChannel

    -- 222 is just a faked sessionid for test
    self.upconn:send_packet(222, zjh_defs.MsgId.MSGID_LOGIN_REQ) 
end

function _M.sendEnterRoom(self)
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int32(0) -- userTicketId
    po:write_string("") -- userName
    po:write_string("a123123") -- pwd
    po:write_string("1234567890") -- imei
    po:write_string("xxxyyyzzzz") -- imsi
    po:write_string("channel") -- channel
    po:write_string("subChannel") -- subChannel

    -- 222 is just a faked sessionid for test
    self.upconn:send_packet(222, zjh_defs.MsgId.MSGID_LOGIN_REQ) 
end

function _M.start(self)
    print("born now")
    self:sendLogin()
end

function _M.finish(self)
    print("die now")
end

function _M.doRegisterMsgCallbacks()
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_REGISTER_RESP, _M.onRegister)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_LOGIN_RESP, _M.onLogin)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_ENTER_ROOM_RESP, _M.onEnterRoom)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_LEAVE_ROOM_RESP, _M.onLeaveRoom)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_CHANGE_TABLE_RESP, _M.onChangeTable)

end

return _M
