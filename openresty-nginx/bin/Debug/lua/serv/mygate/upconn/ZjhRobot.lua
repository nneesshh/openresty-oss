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

local ZJH_S_IDLE = 0
local ZJH_S_SIT = 1
local ZJH_S_READY = 2
local ZJH_S_PLAYING = 3
local ZJH_S_WAITING = 4
local ZJH_S_GIVEUP = 5
local ZJH_S_LOST = 6

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

local function _readTableInfo(po)
    local info = {}
    info.tableId = po:read_int32()
    info.status = po:read_byte()  
    info.round = po:read_byte()
    info.baseBet = po:read_int32()    
    info.jackpot = po:read_int32()
    info.bankerSeat = po:read_byte()
    info.currentSeat = po:read_byte()
    info.playCount = po:read_int32()
    info.playerSeat = {}
    for i=1, info.playCount do
        local seat = po:read_byte()
        tbl_insert(info.playerSeat, seat)
    end
    return info
end

local function _readSeatPlayerInfo(po)
    local info = {}
    info.userTicketId = po:read_int32()
    info.nickName = po:read_string()
    info.avatar = po:read_string()
    info.gender = po:read_byte()
    info.balance = po:read_int64()
    info.status = po:read_byte()
    info.seat = po:read_byte()
    info.bet = po:read_int32()
    return info
end

local function _readPlayerAnteUp(po)
    local info = {}
    info.playerSeat = po:read_byte()
    info.playerBet = po:read_int32()
    info.playerBalance = po:read_int64()
    --
    info.round = po:read_byte()
    info.baseBet = po:read_int32()    
    info.jackpot = po:read_int32()
    info.currentSeat = po:read_byte()

    info.isLastBet = po:read_byte()
    info.lastBetWin = po:read_byte()
    return info
end

local function _readPlayerShowCard(po)
    local info = {}
    info.playerSeat = po:read_byte()
    info.cards = po:read_int32()
    return info
end

local function _readPlayerCompareCard(po)
    local info = {}
    info.playerSeat = po:read_byte()
    info.playerBet = po:read_int32()
    info.playerBalance = po:read_int64()
    --
    info.acceptorSeat = po:read_byte()
    info.loserSeat = po:read_byte()
    --
    info.round = po:read_byte()
    info.baseBet = po:read_int32()    
    info.jackpot = po:read_int32()
    info.currentSeat = po:read_byte()
    return info
end

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

function _M.onRegister(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
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
            robot.state = ROBOT_STATE_OFFLINE

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

function _M.onLogin(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
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
            robot.state = ROBOT_STATE_LOBBOY

            -- recover flag
            resp.isGaming = po:read_byte()
            if 0 == resp.isGaming  then
                -- enter room
                robot:sendEnterRoom()
            else
                -- table info
                robot.tabInfo = _readTableInfo(po)

                -- seat player info
                local players = {}
                local playCount = po:read_int32()
                for i=1, playCount do
                    -- seat player info
                    local player = _readSeatPlayerInfo(po)
                    players[player.seat] = player
                end
                robot.seatPlayerInfo = players
            
                --
                robot.state = ROBOT_STATE_GAME

                -- check turn
                local turnSeat = robot.tabInfo.currentSeat
                local turnPlayer = robot.seatPlayerInfo[turnSeat]
                if robot.userInfo.userTicketId == turnPlayer.userTicketId then
                    -- self is in turn, do bet
                    print("login and is in game, continue anteup -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

                    --
                    robot:sendPlayerAnteUp()
                else

                end
            end
        else
            --
            print("login failed -- errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
        end
    else
        print("[onLogin()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

function _M.onEnterRoom(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()

        --
        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
            -- table info
            robot.tabInfo = _readTableInfo(po)

            -- seat player info
            local players = {}
            local playCount = po:read_int32()
            for i=1, playCount do
                -- seat player info
                local player = _readSeatPlayerInfo(po)
                players[player.seat] = player
            end
            robot.seatPlayerInfo = players
           
            --
            robot.state = ROBOT_STATE_GAME

            --
            print("enter room ok -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)
        else
            --
            print("enter room failed -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. ", errcode=" .. tostring(resp.errorCode) .. ", " .. resp.errorMsg)
            -- enter room again
            robot:sendEnterRoom()
         end
    else
        print("[onEnterRoom()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

function _M.onLeaveRoom(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()

        --
        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
        end
    else
        print("[onLeaveRoom()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

function _M.onChangeTable(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()

        --
        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
        end
    else
        print("[onChangeTable()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

----------------------------------------------------------------
--- notify
----------------------------------------------------------------
function _M.onGameStart(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        local baseCoin = po:read_int32()
        local tabInfo = _readTableInfo(po)

        -- 
        print("game start -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

        -- base bet
        robot.userInfo.balance = robot.userInfo.balance - tabInfo.baseBet

        local bankerSeat = tabInfo.bankerSeat
        local banker = robot.seatPlayerInfo[bankerSeat]
        if robot.userInfo.userTicketId == banker.userTicketId then
            -- self is banker, do ante up
            print("game start, do bet -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

            --
            robot:sendPlayerAnteUp()
        else

        end
    else
        print("[onGameStart()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onGameOver(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        resp.errorCode = po:read_int32()
        resp.errorMsg = po:read_string()

        --
        if resp.errorCode == zjh_defs.ErrorCode.ERR_SUCCESS then
        end
    else
        print("[onGameOver()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerSitDown(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        local player = _readSeatPlayerInfo(po)

        --
        robot.seatPlayerInfo = robot.seatPlayerInfo or {}
        robot.seatPlayerInfo[player.seat] = player

        --
        print("player sit down -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)
    
        --
        if robot.userInfo.userTicketId == player.userTicketId then
            -- it is self sit down confirm
            robot.playerSeat = player.seat

            robot:sendPlayerReady()
        end
    else
        print("[onPlayerSitDown()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerReady(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        local seat_pos = po:read_byte()

        local players = robot.seatPlayerInfo or {}
        local player = players[seat_pos] or {}
        player.status = ZJH_S_READY

        if robot.userInfo.userTicketId == player.userTicketId then
            -- it is self ready
        else

        end

        --
        print("player ready -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

    else
        print("[onPlayerReady()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerAnteUp(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        local anteUpInfo = _readPlayerAnteUp(po)
        robot.round = anteUpInfo.round

        if robot.playerSeat == anteUpInfo.playerSeat then
            -- it is self confirm
            robot.userInfo.balance = anteUpInfo.playerBalance
        end

        -- check turn
        local turnSeat = anteUpInfo.currentSeat
        local turnPlayer = robot.seatPlayerInfo[turnSeat]
        if robot.userInfo.userTicketId == turnPlayer.userTicketId then
            -- self is in turn, do bet
            print("game start, do bet -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

            --
            robot:sendPlayerAnteUp()
        else

        end

        --
        print("player ante up -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)
       
    else
        print("[onPlayerAnteUp()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerShowCard(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        resp.seat = po:read_byte()
        resp.cards = po:read_string()

        --
        print("player show card -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

    else
        print("[onPlayerShowCard()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerCompareCard(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()
        local compareCardInfo = _readPlayerCompareCard(po)
        robot.round = compareCardInfo.round

        --
        print("player compare card -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

    else
        print("[onPlayerCompareCard()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

-- notify
function _M.onPlayerGiveUp(conn, sessionid, msgid)
    local resp = {}
    conn.user = conn.user or {}
    
    local robot = conn.user.robot
    if robot then
        local po = conn:get_packet_obj()

        --
        print("player give up -- robot=" .. tostring(robot.userInfo.userTicketId) .. ", " .. robot.userInfo.userName)

    else
        print("[onPlayerGiveUp()], connid=" .. ", " .. tostring(conn.id).. ", " .. tostring(sessionid).. ", " .. tostring(msgid))
    end
end

----------------------------------------------------------------
--- send
----------------------------------------------------------------
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

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_ENTER_ROOM_REQ)

    -- save room info
    self.roomInfo = self.roomInfo or {}
    self.roomInfo.reqRoomId = roomId
end

function _M.sendPlayerReady(self)
    
    local po = self.upconn:get_packet_obj()
    po:writer_reset()
    po:write_int64(123456789012) -- test token

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_READY_REQ)

    --
    print("sendPlayerReady -- robot=" .. tostring(self.userInfo.userTicketId))
end

function _M.sendPlayerAnteUp(self)
    local round = robot.round or 1

    local po = self.upconn:get_packet_obj()
    po:writer_reset()

    local multiple = 1
    if round % 3 == 0 then
        multiple = multiple + 1
    end
    po:write_int32(multiple)

    -- 222 is just a faked sessionid for test
    local sessionId = self.sessionId or 222
    self.upconn:send_packet(sessionId, zjh_defs.MsgId.MSGID_ANTE_UP_REQ)

    --
    print("sendPlayerAnteUp -- robot=" .. tostring(self.userInfo.userTicketId))
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

    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_GAME_START_NOTIFY, _M.onGameStart)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_GAME_OVER_NOTIFY, _M.onGameOver)

    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_SIT_DOWN_NOTIFY, _M.onPlayerSitDown)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_READY_NOTIFY, _M.onPlayerReady)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_ANTE_UP_NOTIFY, _M.onPlayerAnteUp)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_SHOW_CARD_NOTIFY, _M.onPlayerShowCard)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_COMPARE_CARD_NOTIFY, _M.onPlayerCompareCard)
    msg_dispatcher.registerCb(zjh_defs.MsgId.MSGID_GIVE_UP_NOTIFY, _M.onPlayerGiveUp)
end

return _M
