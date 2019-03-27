--
local pa = require "utils.serpent".block

local mongol = require("resty.mongol")
local json = require("cjson")
local conn = mongol:new()
conn:set_timeout(10000)

local ok, err = conn:connect("127.0.0.1", 27017)
local db = conn:new_db_handle("zjhdb")
-- assert(db:auth("", ""))
local coll = db:get_col("user_info")
local cursor = coll:find({})

function json_decode(str)
    local json_value = nil
    pcall(function(str) json_value = json.decode(str) end, str)
    return json_value
end

--
for index, item in cursor:pairs() do
    pa(item)
end

function nextSeqId(seqName)
    local query = {
        _id = seqName
    }

    local update = {
        ["$inc"] = {
            seq = 1
        }
    }

    local coll = db:get_col("sequenceid_generator")
    local cursor = coll:find(
        query,
        update)

    return 10001
end
    
local seqId = nextSeqId("user_info")
local bson1 = {
    _id = seqId,
    user_name = "13551900088",
    imei = "imei13551900088"
}

local ok, err = coll:insert({bson1}, 0, 0)
if err then
    print(err)
end