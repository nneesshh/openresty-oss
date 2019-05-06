local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local default_options = require("db.default_mongodb_options")
local db_options = require("db.mongodb_options")
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "gamedburls"
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
    return model.getBsonVal(r)
end

function _M.getByCode(code)
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({Code = code})
    h:release()
    return model.getBsonVal(r)
end

function _M.getAll(ntype) 
    ntype = ntype or 0
    local h = model:new(default_options)
    local col = h:getCol(_M.colName)
    --
    local r = {}
    local cursor = col:find({Type = ntype})
    for row in cursor:iterator() do
        tbl_insert(r, row)
    end
    h:release()
    return r
end

function _M.getOptions()
  -- load options from db if not cached yet
  if not _M._game_db_options then
    local objList = _M.getAll()
    if #objList >= 1 then
      local obj = objList[1]
      _M._game_db_options = db_options.new(obj.Url)
    end
  end
  return _M._game_db_options
end

return _M