-- any to string
local ats = require "utils.serpent".block

local mongol = require("resty.mongol")
local json = require("cjson")
local conn = mongol:new()
conn:set_timeout(100000)

local ok, err = conn:connect("192.168.209.129", 27017)
if not ok then
    ngx.say("connect failed" .. err)
end

local db = conn:new_db_handle("zjhdb")
-- assert(db:auth("", ""))
local col = db:get_col("user_info")
local cursor = col:find({})

local function json_decode(str)
    local json_value = nil
    pcall(
        function(str)
            json_value = json.decode(str)
        end,
        str
    )
    return json_value
end

--
for index, item in cursor:pairs() do
    --print(ats(item))
end

local function nextSeqId(seqName)
    local options = {
        query = {
            _id = seqName
        },
        update = {
            ["$inc"] = {
                seq = 1
            }
        }
    }
    local col = db:get_col("sequenceid_generator")
    local val, err = col:find_and_modify(options)
    return val, err
end

local seqId = nextSeqId("user_info")
local bson1 = {
    _id = seqId,
    user_name = "13551900088",
    imei = "imei13551900088"
}

--[[ continue_on_error, safe]]
--[[local ok, err = col:insert({bson1}, nil, true)
if err then
    print(err)
end]]
