local tostring = tostring

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local default_options = require("db.default_mongodb_options")
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "userroles"
}

function _M.create()
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)

    h:release()
end

function _M.get(id)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({_id = model.newObid(id)})
    h:release()
    return model.bsonObidSafe(r)
end

function _M.getByUserId(userId)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({UserId = userId})
    h:release()
    return model.bsonObidSafe(r)
end

return _M
