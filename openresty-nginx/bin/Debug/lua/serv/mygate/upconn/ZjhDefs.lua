local ErrorCode = {
    ERR_SUCCESS = 0x00, --
    ERR_UNKNOWN = 0x01, --
    ERR_USERNAME_INVALID = 0x02, --
    ERR_USER_NOT_FOUND = 0x03, --
    ERR_WRONG_PASSWORD = 0x04, --
    ERR_ACCOUNT_RESTRICTION = 0x05, --
    ERR_OUT_OF_LIMIT = 0x06, --
    ERR_NO_FREE_TABLE = 0x07 --
}

local MsgId = {
    -- //大厅协议
    MSGID_HEART_BEAT_REQ = 0x1001, --		//心跳
    MSGID_HEART_BEAT_RESP = 0x1002, --		//心跳
    MSGID_LOGIN_REQ = 0x1003, --		//登录请求
    MSGID_LOGIN_RESP = 0x1004, --		//登录回应
    MSGID_REGISTER_REQ = 0x1005, --		//登录请求
    MSGID_REGISTER_RESP = 0x1006, --		//登录回应
    MSGID_ENTER_ROOM_REQ = 0x1007, --		//进入房间请求
    MSGID_ENTER_ROOM_RESP = 0x1008, --		//进入房间回应
    MSGID_LEAVE_ROOM_REQ = 0x1009, --		//离开房间请求
    MSGID_LEAVE_ROOM_RESP = 0x100A, --		//离开房间回应
    MSGID_CHANGE_TABLE_REQ = 0x100B, --		//换桌请求
    MSGID_CHANGE_TABLE_RESP = 0x100C, --		//换桌回应
    -- zjh //游戏协议
    MSGID_READY_REQ = 0x2001, --		//准备请求
    MSGID_CHANGE_TABLE = 0X2002, --		//换桌
    MSGID_ANTE_UP_REQ = 0x2003, --		//押注
    MSGID_SHOW_CARD_REQ = 0x2004, --		//看牌
    MSGID_COMPARE_CARD_REQ = 0x2005, --		//比牌
    MSGID_GIVE_UP_REQ = 0x2006, --		//弃牌
    MSGID_USER_STATUS_NOTIFY = 0x2021, --		//用户状态改变通知
    MSGID_GAME_START_NOTIFY = 0x2022, --		//游戏开始通知
    MSGID_GAME_OVER_NOTIFY = 0x2023, --		//游戏结束通知
    MSGID_SIT_DOWN_NOTIFY = 0x2024, --		//坐下通知
    MSGID_READY_NOTIFY = 0x2025, --		//准备通知
    MSGID_ANTE_UP_NOTIFY = 0x2026, --		//押注通知
    MSGID_SHOW_CARD_NOTIFY = 0x2027, --		//看牌
    MSGID_COMPARE_CARD_NOTIFY = 0x2028, --		//比牌
    MSGID_GIVE_UP_NOTIFY = 0x2029, --		//弃牌
    MSGID_LOGIN_BY_OTHER_DEVICE_NOTIFY = 0x202A, --		//其他用户登录
    MSGID_CLOSE_CONNECTION = 0x03, --		//
    MSGID_CREATE_HANDLER = 0x04, --		//
    MSGID_CLOSE_HANDLER = 0x05 --		//
}

return {
    ErrorCode = ErrorCode,
    MsgId = MsgId
}
