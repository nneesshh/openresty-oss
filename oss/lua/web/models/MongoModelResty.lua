local mongol = require("resty.mongol")
local obid = require("resty.mongol.object_id")
local new_object_id = obid.new
local bit = require("bit")
local bnot, band, bor, bxor = bit.bnot, bit.band, bit.bor, bit.bxor
local lshift, rshift, arshift, rol = bit.lshift, bit.rshift, bit.arshift, bit.rol
local bit_tohex = bit.tohex
local setmetatable = setmetatable

local _M = {}

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

function _M.newObid(str12OrNil)
	return new_object_id(str12OrNil)
end

--
local mt = {__index = _M}

--
function _M.new(self, opts)
    local conn = mongol:new()
    conn:set_timeout(opts.timeout)

    local ok, err = conn:connect(opts.host, opts.port)
    if not ok then
        print("[MongoModel.new()] connect failed" .. err)
    end

    local db = conn:new_db_handle(opts.database)

    return setmetatable(
        {
            opts = opts,
            conn = conn,
            db = db
        },
        mt
    )
end

--
function _M.release(self)
    self.conn:set_keepalive(self.opts.max_idle_timeout, self.opts.pool_size)
end

function _M.getCol(self, colName)
    return self.db:get_col(colName)
end

-- return: val, err
function _M.nextSeqId(self, seqName)
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
    local col = self.db:get_col("sequenceid_generator")
    return col:find_and_modify(options)
end

return _M