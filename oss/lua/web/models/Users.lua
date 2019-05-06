local tostring = tostring

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local default_options = require("db.default_mongodb_options")
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "users"
}

function _M.create()
    local h = model:new(default_options)

    h:release()
end

function _M.get(id)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({_id = model.newObid(id)})
    h:release()
    return model.getBsonValSafe(r)
end

function _M.getByName(name)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({UserName = name})
    h:release()
    return model.getBsonValSafe(r)
end

return _M
