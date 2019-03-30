local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local oss_options = require(cwd .. "GameDbUrls").getOptions()
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "user_info"
}

function _M.create()
    local h = model:new(oss_options)

    h:release()
end

function _M.get(id)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({_id = model.newObid(id)})
    h:release()
    return model.getBsonVal(r)
end

function _M.getAll()
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    --
    local r = {}
    local cursor = col:find({})
    for row in cursor:iterator() do
        tbl_insert(r, row)
    end
    h:release()
    return r
end

function _M.getUserInfoByTicketId(userTicketId)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({ticketid = userTicketId})
    h:release()
    return model.getBsonVal(r)
end

function _M.getUserInfo(userName)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({user_name = userName})
    h:release()
    return model.getBsonVal(r)
end

function _M.getUserState(userId)
    local data = {}
    local h = model:new(oss_options)
    local col = h:getCol("user_state")
    local r = col:find_one({user_name = userId})
    h:release()
    return model.getBsonVal(r)
end

function _M.getChargeLog(userId, beginTime, endTime)
local data = {}
local h = model:new(oss_options)
local col = h:getCol("user_charge")
local r = col:find('{"user_name" : userId, { "charge_time" : { "$lt" = beginTime } } }')
h:release()
return model.getBsonVal(r)
end

return _M
