local _M = {
    callbacks = {}
}

function _M.registerCb(msgid, cb)
    _M.callbacks[msgid] = cb
end

function _M.dispatch(conn, sessionid, msgid, data, ...)
    local cb = _M.callbacks[msgid]
    if cb then
        cb(conn, sessionid, msgid, data, ...)
    else
        print("[ZjhMsgDispatcher] !!! unknown message !!! -- " .. tostring(msgid))
    end
end

return _M
