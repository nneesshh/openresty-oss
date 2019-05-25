local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local default_options = require("db.default_mongodb_options")
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "menus"
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

function _M.getByCode(code)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({Code = code})
    h:release()
    return model.bsonObidSafe(r)
end

function _M.getAll(ntype)
    ntype = ntype or 0
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    --
    local cursor = col:find({Type = ntype, Hide = 0}, {sort = {SeqNo = 1}})
    local r = {}
    for row in cursor:iterator() do
        tbl_insert(r, row)
    end
    h:release()
    return r
end

return _M
