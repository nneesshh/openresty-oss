local tostring = tostring
local tbl_insert = table.insert

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local oss_options = require(cwd .. "GameDbUrls").getOptions()
local model = require(cwd .. "MongoModel")

local _M = {
    colName = "game_announcement",
}

function _M.create(deadlinetime, intervalSeconds, content, createtime)
    local h = model:new(oss_options)
    local announcementid = h:nextSeqId(_M.colName)

    -- insertFlags: continueOnError, noValidate
    local col = h:getCol(_M.colName)
    col:insert({
      announcementid = announcementid,
      interval_seconds = intervalSeconds,
      content = content,
      createtime = model.dateToMongoDateTime(createtime),
      deadlinetime = model.dateToMongoDateTime(deadlinetime),
    })
    h:release()
end

function _M.get(announcementid)
    local h = model:new(oss_options)
    local col = h:getCol(_M.colName)
    local r = col:find_one({announcementid = announcementid})
    h:release()
    return model.getBsonVal(r)
end

function _M.getLatest()
  local h = model:new(oss_options)
  local col = h:getCol(_M.colName)
  --
  local r = {}
  local cursor = col:find({}, {sort = {announcementid = -1}, limit = 1})
  for row in cursor:iterator() do
      local row_ = model.obidSafe(row)
      tbl_insert(r, row_)
  end
  h:release()
  return r
end

return _M