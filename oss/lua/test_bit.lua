--[[
    Supported functions:
        bit.tobit,
        bit.tohex,
        bit.bnot,
        bit.band,
        bit.bor,
        bit.bxor,
        bit.lshift,
        bit.rshift,
        bit.arshift,
        bit.rol,
        bit.ror,
        bit.bswap
]]
local bit = require("bit")
local bnot, band, bor, bxor = bit.bnot, bit.band, bit.bor, bit.bxor
local lshift, rshift, arshift, rol = bit.lshift, bit.rshift, bit.arshift, bit.rol
local bit_tohex = bit.tohex
local bit_tobit = bit.tobit -- This function is usually not needed

local function bin2hex(s)
    s =
        string.gsub(
        s,
        "(.)",
        function(x)
            return string.format("%02X ", string.byte(x))
        end
    )
    return s
end

local h2b = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15
}

local function hex2bin(hexstr)
    local s =
        string.gsub(
        hexstr,
        "(.)(.)%s",
        function(h, l)
            return string.char(h2b[h] * 16 + h2b[l])
        end
    )
    return s
end

function printx(x)
    print("0x" .. bit_tohex(x))
end

function printbin(x)
    print("bin..." .. hex2bin(bit_tohex(x)))
end

print(lshift(1, 0)) -- > 1
print(lshift(1, 8)) -- > 256
print(lshift(1, 40)) -- > 256
print(rshift(256, 8)) -- > 1
print(rshift(-256, 8)) -- > 16777215
print(arshift(256, 8)) -- > 1
print(arshift(-256, 8)) -- > -1
printx(lshift(0x87654321, 12)) -- > 0x54321000
printx(rshift(0x87654321, 12)) -- > 0x00087654
printx(arshift(0x87654321, 12)) -- > 0xfff87654

print("\n22222222222222222222")
local fl = bit_tobit(string.byte("z") * 256 + string.byte("z"))
print(fl)
printx(fl)

local fl2 = rshift(fl, 2)
print(fl2)
printx(fl2)

print("\n33333333333333333333333")
local b3 = band(fl, 0x3FFF)
print(b3)
printx(b3)
printbin(b3)

print("\n444444444444444444444444444444444444444444")
local TICKETID_MIN = 1000001
local TICKETID_MAX = 9999999 
local function encryptTicketId7(id)
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

for i=10, 40 do
    print(i, encryptTicketId7(i))
end

print("\nover")