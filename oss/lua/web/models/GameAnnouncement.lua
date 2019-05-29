local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local oss_options = require(cwd .. "GameDbUrls").getOptions()
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "game_announcement",
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

function _M.create(deadlineTime, playInterval, content)
  local subid = _M._subid + 1
  local data = {}
  local res, d1, d2 = db.query(oss_options, "CALL __oss_create_game_mail(?,?,?,?,?,?,?,?,?)", subid, mailtype, subject, content, attachment, createtime, burntime, mailto_level, ignore_rule)
  if res then
    local n = #res
    if n >= 2 then
      for i, row in ipairs(res[1]) do  
        table.insert(data, row)
      end
    end
    
    --
    _M._subid = subid
  end
  return data

  local data = {}
  local res, d1, d2 = db.query(oss_options, "CALL __oss_create_game_announcement(?,?,?)", deadlineTime, playInterval, content)
  if res then
    local n = #res
    if n >= 2 then
      for i, row in ipairs(res[1]) do  
        table.insert(data, row)
      end
    end
  end
  return data
end

function _M.get(id) 
  return _M._db_entity:find(id)
end

function _M.getAll() 
  return _M._db_entity:select("WHERE 1=1 ORDER BY id DESC", { fields = "*" })
end

return _M