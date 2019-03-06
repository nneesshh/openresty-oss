local tbl_insert = table.insert
local tostring, pairs, ipairs = tostring, pairs, ipairs
local randseed, rand = math.randomseed, math.random

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

function _M.onRegister(conn, sessionid, msgid, data)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        -- save sessionId
        robot.sessionId = sessionid
        robot.rooms = {}

        local po = conn:get_packet_obj()
        po:reader_reset()
        
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()
        resp.version = po:read_string()
        resp.host = po:read_string()
        resp.onlineCount = po:read_int32()
        resp.roomCount = po:read_byte()

        -- room info
        for i=1, resp.roomCount do
            local info = {}
            info.roomId = po:read_int32()
            info.lowerLimit = po:read_int32()
            info.upperLimit = po:read_int32()
            info.baseCoin = po:read_int32()
            info.userCount = po:read_int32()
            tbl_insert(robot.rooms, info)
        end

        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
            -- user info
            robot.userinfo = robot.userinfo or {}
            robot.userinfo.userTicketId = po:read_int32()
            robot.userinfo.userName = po:read_string()
            robot.userinfo.nickName = po:read_string()
            robot.userinfo.avatar = po:read_string()
            robot.userinfo.gender = po:read_int32()
            robot.userinfo.balance = po:read_byte()

            --
            conn.user.robot.state = ROBOT_STATE_LOBBOY

            --
            print("register ok,  -- robot=" .. tostring(robot.userinfo.userTicketId) .. ", " .. robot.userinfo.userName)

        else
            --
            print("register -- errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
         end
    else
        print("got_packet_cb, connid=", tostring(conn.id))
    end
end

function _M.onLogin(conn, sessionid, msgid, data)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        -- save sessionId
        robot.sessionId = sessionid
        robot.rooms = {}

        local po = conn:get_packet_obj()
        po:reader_reset()
        
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()
        resp.version = po:read_string()
        resp.host = po:read_string()
        resp.onlineCount = po:read_int32()
        resp.roomCount = po:read_byte()

        -- room info
        for i=1, resp.roomCount do
            local info = {}
            info.roomId = po:read_int32()
            info.lowerLimit = po:read_int32()
            info.upperLimit = po:read_int32()
            info.baseCoin = po:read_int32()
            info.userCount = po:read_int32()
            tbl_insert(robot.rooms, info)
        end

        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
            -- user info
            robot.userinfo = robot.userinfo or {}
            robot.userinfo.userTicketId = po:read_int32()
            robot.userinfo.userName = po:read_string()
            robot.userinfo.nickName = po:read_string()
            robot.userinfo.avatar = po:read_string()
            robot.userinfo.gender = po:read_int32()
            robot.userinfo.balance = po:read_byte()

            --
            robot.state = ROBOT_STATE_LOBBOY

            --
            robot:sendEnterRoom()

        else
            --
            print("login failed -- errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
        end
    else
        print("got_packet_cb, connid=", tostring(conn.id))
    end
end

function _M.onEnterRoom(conn, sessionid, msgid, data)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        po:reader_reset()

        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()

        local tabInfo = {}
        tabInfo.id = po:read_int32()
        tabInfo.stabus = po:read_byte()
        tabInfo.bankerSeat = po:read_byte()
        tabInfo.currentSeat = po:read_byte()
        tabInfo.betTotal = po:read_int32()
        tabInfo.round = po:read_byte()
        tabInfo.playerCount = po:read_int32()

        robot.tabInfo = tabInfo

        tabInfo.players = {}
        for i=1, robot.tabInfo.playerCount do
            local player = {}

            player.userTicketId = po:read_int32()
            player.nickName = po:read_string()
            player.avatar = po:read_string()
            player.gender = po:read_byte()
            player.balance = po:read_int64()
            player.status = po:read_byte()
            player.seat = po:read_byte()
            player.bet = po:read_int32()

            tbl_insert(tabInfo.players, player)
        end

        --
        robot.tabInfo = tabInfo

        --
        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
            -- user info
            robot.userinfo = robot.userinfo or {}
            robot.userinfo.userTicketId = po:read_int32()
            robot.userinfo.userName = po:read_string()
            robot.userinfo.nickName = po:read_string()
            robot.userinfo.avatar = po:read_string()
            robot.userinfo.gender = po:read_int32()
            robot.userinfo.balance = po:read_byte()

            --
            conn.user.robot.state = ROBOT_STATE_LOBBOY

            --
            print("register ok,  -- robot=" .. tostring(robot.userinfo.userTicketId) .. ", " .. robot.userinfo.userName)

        else
            --
            print("register -- errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
         end
    else
        print("got_packet_cb, connid=", tostring(conn.id))
    end
end

----
function _M.sendBadMsg(self)
    self.upconn:send_raw("\0\0\0\1")
end

function _M.sendRegister(self)
    local cfg_robot = self.cfg
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_string(cfg_robot.username) -- userName
    po:write_string(cfg_robot.pwd) -- pwd
    po:write_string(cfg_robot.nick) -- nickName
    po:write_string(tostring(cfg_robot.phone)) -- phoneNumber
    po:write_string(cfg_robot.imei) -- imei
    po:write_string(cfg_robot.imsi) -- imsi

    po:write_string(cfg_robot.email) -- email
    po:write_string(cfg_robot.addr) -- addr
    po:write_string(cfg_robot.avatar) -- avatar
    po:write_byte(cfg_robot.gender) -- gender

    po:write_int64(cfg_robot.balance) -- balance
    po:write_int32(cfg_robot.state) -- state

    po:write_string(cfg_robot.channel) -- channel
    po:write_string(cfg_robot.subChannel) -- subChannel

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_REGISTER_REQ) 
end

function _M.sendLogin(self)
    local cfg_robot = self.cfg
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int32(0) -- userTicketId
    --po:write_string(cfg_robot.username) -- userName
    po:write_string(tostring(cfg_robot.phone)) -- phoneNumber as userName
    po:write_string(cfg_robot.pwd) -- pwd
    po:write_string(cfg_robot.imei) -- imei
    po:write_string(cfg_robot.imsi) -- imsi
    po:write_string(cfg_robot.channel) -- channel
    po:write_string(cfg_robot.subChannel) -- subChannel

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_LOGIN_REQ) 
end

function _M.sendLoginAsGuest(self)
    local cfg_robot = self.cfg
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int32(0) -- userTicketId
    po:write_string("") -- userName
    po:write_string("") -- pwd
    po:write_string(cfg_robot.imei) -- imei
    po:write_string(cfg_robot.imsi) -- imsi
    po:write_string(cfg_robot.channel) -- channel
    po:write_string(cfg_robot.subChannel) -- subChannel

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_LOGIN_REQ) 
end

function _M.sendEnterRoom(self)
    -- select room
    local roomNum = #self.rooms
    local selected = rand(1, roomNum)
    local room = self.rooms[selected]
    local roomId = room.roomId

    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int32(self.sessionId) -- sessionId
    po:write_int32(roomId) -- roomId

    self.reqRoomId = roomId

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_ENTER_ROOM_REQ)
end

function _M.register(self)
    print("register now")

    self:sendRegister()
end

function _M.start(self)
    print("born now")

    --self:sendLoginAsGuest()
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
