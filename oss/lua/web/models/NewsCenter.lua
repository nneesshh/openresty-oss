local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local oss_options = require(cwd .. "GameDbUrls").getOptions()
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "game_news",
}

function _M.create(newstype, content, createby, createtime)
    -- insertFlags: continueOnError, noValidate
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    col:insert({
      newstype = newstype,
      content = content,
      createby = createby,
      createtime = createtime,
    })
    h:release()
end

function _M.update(obj)
    -- updateFlags: upsert, multi, noValidate
    local data = {}
    local h = model:new(oss_options)

    local query = {
        _id = obj._id
    }
    local update = {
        ["$set"] = {
          content = obj.content,
          createby = obj.createby,
          createtime = obj.createtime,
        }
    }

    local flags = {
        multi = false
    }

    local col = h:getCol(_M.colName)
    local r, err = col:update(query, update, flags)
    h:release()
    return r, err
end

function _M.deleteById(id)
    -- removeFlags: single
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    
    local query = {
        _id = model.newObid(id)
    }

    local flags = {
        single = true
    }

    local r, err = col:remove(query, flags)
    h:release()
    return r, err
end

function _M.get(id)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({_id = model.newObid(id)})
    h:release()
    return model.getBsonVal(r)
end

function _M.getAllByType(newstype)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    --
    local r = {}
    local cursor = col:find({
        newstype = newstype
    }, {sort = {_id = -1}})
    for row in cursor:iterator() do
        local row_ = model.obidSafe(row)
        tbl_insert(r, row_)
    end
    h:release()
    return r
end

return _M