local mongo = require("mongo")
local new_object_id = mongo.ObjectId
local new_object_id_from_data = mongo.ObjectIdFromData
local bit = require("bit")
local bnot, band, bor, bxor = bit.bnot, bit.band, bit.bor, bit.bxor
local lshift, rshift, arshift, rol = bit.lshift, bit.rshift, bit.arshift, bit.rol
local bit_tohex = bit.tohex
local setmetatable, type, assert = setmetatable, type, assert
local tostring = tostring
local tbl_insert, tbl_remove = table.insert, table.remove

local date = require("date")
local os_time = os.time

local _M = {
    poolMap = {}
}

local TICKETID_MIN = 1000001
local TICKETID_MAX = 9999999

function _M.encryptTicketId7(id)
    local sid
    sid = band(id, 0xffff0000)
    sid = sid + lshift(band(id, 0x0000000f), 12)
    sid = sid + rshift(band(id, 0x0000f000), 12)
    sid = sid + lshift(band(id, 0x000000f0), 4)
    sid = sid + rshift(band(id, 0x00000f00), 4)
    sid = bxor(sid, 113579)
    sid = sid + TICKETID_MIN
    assert(sid >= TICKETID_MIN and sid < TICKETID_MAX)
    return sid
end

function _M.newObid(str24OrNil)
    return new_object_id(str24OrNil)
end

function _M.newObidFromData(str12OrNil)
    return new_object_id_from_data(str12OrNil)
end

-- a is lua date
function _M.dateToTm(a)
    -- return time_t(tm)
    local yy, mm, dd = a:getdate()
    print("******** yy=" .. yy .. ", mm=" .. mm  .. ", dd=" .. dd)
    local h, m, s, t = a:gettime()
    print("******** h=" .. h .. ", m=" .. m .. ", s=" .. s .. ", t=" .. t)
    local tm = os_time({year=yy, month=mm, day=dd, hour=h, min=m, sec=s})
    --return date.diff(d, date.epoch()):spanseconds()
    print("******* tm=" .. tostring(tm))
    return tm
end

-- tm is time_t
function _M.tmToMongoDateTime(tm)
    return mongo.DateTime(tm)
end

-- d is lua date
function _M.dateToMongoDateTime(d)
    local tm = _M.dateToTm(d)
    return _M.tmToMongoDateTime(tm)
end

-- tm is time_t
function _M.dateFromTm(tm)
    return date(tm)
end

function _M.obidSafe(bval)
    -- convert obid to string for session json serialize
    if bval then
        if type(bval._id) == "userdata" then
            bval._obid = bval._id:data()
            bval._id= tostring(bval._id)
        end
    end
    return bval
end

function _M.getBsonVal(bsonObj)
    return bsonObj and bsonObj:value()
end

function _M.bsonObidSafe(bsonObj)
    local bval = _M.getBsonVal(bsonObj)
    return _M.obidSafe(bval)
end

--
local mt = {__index = _M}

--
function _M.new(self, opts)
    local conn
    local pool = _M.poolMap[opts.pool]
    if pool and #pool > 0 then
        conn = pool[#pool]
        tbl_remove(pool)
    else
        conn = mongo.Client("mongodb://" .. opts.host .. ":" .. tostring(opts.port))
    end

    local dbName = opts.database
    local db = conn:get_database(dbName)

    return setmetatable(
        {
            opts = opts,
            conn = conn,
            dbName = dbName,
            db = db
        },
        mt
    )
end

--
function _M.release(self)
    local opts = self.opts
    if opts then
        local pool = _M.poolMap[opts.pool] or {}
        if #pool < opts.pool_size then
            --
            tbl_insert(pool, self.conn)
            --
            _M.poolMap[opts.pool] = pool
        end
    end
end

function _M.getCol(self, colName)
    return self.conn:get_collection(self.dbName, colName)
end

-- return: val, err
function _M.nextSeqId(self, seqName)
    local query = {_id = seqName}
    local update = {
        update = {
            ["$inc"] = {
                seq = 1
            }
        }
    }
    local collection = self.conn:get_collection(self.dbName, "sequenceid_generator")
    local r, err = collection:find_and_modify(query, update)
    local val = r and r:find("seq")
    return val, err
end

return _M
