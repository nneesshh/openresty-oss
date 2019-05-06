-- any to string
local ats = require "utils.serpent".block

package.cpath = package.cpath .. ";./?.dll;./clibs/?.dll"
local mongo = require("mongo")
local client = mongo.Client("mongodb://192.168.209.129:27017")

-- Collection
local dbName = "zjhdb"
local collName = "user_info"
local collection = client:get_collection(dbName, collName)
assert(collection:get_name() == collName)
assert(mongo.type(collection:get_read_prefs()) == "mongo.ReadPrefs")

-- cursor:next()
local cursor = collection:find({}, {sort = {ticketid = -1}})
assert(cursor:more())
assert(mongo.type(cursor:next()) == "mongo.BSON") -- #1
assert(mongo.type(cursor:next()) == "mongo.BSON") -- #2
assert(mongo.type(cursor:next()) == "mongo.BSON") -- #3

for other in cursor:iterator() do
    print(other.user_name, other.ticketid)
end

assert(not cursor:more())
collectgarbage()

local function nextSeqId(seqName)
    local query = {_id = seqName}
    local update = {
        update = {
            ["$inc"] = {
                seq = 1
            }
        }
    }
    local collection = client:get_collection(dbName, "sequenceid_generator")
    local r, err = collection:find_and_modify(query, update)
    local val = r and r:find("seq")
    return val, err
end

local seqId = nextSeqId("user_info")
print("seqId=" .. seqId)

local new_object_id = mongo.ObjectId
local id1, err1 = new_object_id()
local id2, err2 = new_object_id(tostring(id1))
print(id1, id2)

print("test over")
