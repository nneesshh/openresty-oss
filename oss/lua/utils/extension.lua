-- extend
local math = math
local io = io
local table = table
local string = string

-- local
local pcall, require, os, tonumber, tostring, pairs, ipairs = pcall, require, os, tonumber, tostring, pairs, ipairs
local tbl_insert = table.insert
local tbl_remove = table.remove
local str_len = string.len
local str_byte = string.byte
local str_sub = string.sub
local str_gsub = string.gsub
local str_find = string.find

--
local function __safe_number(value)
    return tonumber(value) or 0
end

---
--- math
---
function math.newrandomseed()
    local ok, socket = pcall(function() return require("socket") end)
    if ok then
        math.randomseed(socket.gettime() * 1000)
    else
        math.randomseed(os.time())
    end
    math.random()
    math.random()
    math.random()
    math.random()
end

function math.round(value)
    value = __safe_number(value)
    return math.floor(value + 0.5)
end

local pi_div_180 = math.pi / 180
function math.angle2radian(angle)
    return angle * pi_div_180
end

local pi_mul_180 = math.pi * 180
function math.radian2angle(radian)
    return radian / pi_mul_180
end

---
--- io
---
function io.exists(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end

function io.readfile(path)
    local file = io.open(path, "r")
    if file then
        local content = file:read("*a")
        io.close(file)
        return content
    end
    return nil
end

function io.writefile(path, content, mode)
    mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then
            return false
        end
        io.close(file)
        return true
    else
        return false
    end
end

function io.pathinfo(path)
    local pos = str_len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = str_byte(path, pos)
        if b == 46 then -- 46 = char "."
            extpos = pos
        elseif b == 47 then -- 47 = char "/"
            break
        end
        pos = pos - 1
    end

    local dirname = str_sub(path, 1, pos)
    local filename = str_sub(path, pos + 1)
    extpos = extpos - pos
    local basename = str_sub(filename, 1, extpos - 1)
    local extname = str_sub(filename, extpos)
    return {
        dirname = dirname,
        filename = filename,
        basename = basename,
        extname = extname
    }
end

function io.filesize(path)
    local size = false
    local file = io.open(path, "r")
    if file then
        local current = file:seek()
        size = file:seek("end")
        file:seek("set", current)
        io.close(file)
    end
    return size
end

---
--- table
---
function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function table.keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

function table.values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

function table.merge(dst, src)
    for k, v in pairs(src) do
        dst[k] = v
    end
end

function table.indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then
            return i
        end
    end
    return false
end

function table.keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then
            return k
        end
    end
    return nil
end

function table.removebyvalue(array, value, removeall)
    local c, i, max = 0, 1, #array
    while i <= max do
        if array[i] == value then
            tbl_remove(array, i)
            c = c + 1
            i = i - 1
            max = max - 1
            if not removeall then
                break
            end
        end
        i = i + 1
    end
    return c
end

function table.map(t, fn)
    for k, v in pairs(t) do
        t[k] = fn(v, k)
    end
end

function table.walk(t, fn)
    for k, v in pairs(t) do
        fn(v, k)
    end
end

function table.foreach(t, fn)
    for i, v in ipairs(t) do
        fn(v, i)
    end
end

function table.find(t, fn)
    for k, v in pairs(t) do
        if fn(v, k) then
            return k, v
        end
    end
end

function table.ifind(t, fn)
    for i, v in ipairs(t) do
        if fn(v, i) then
            return i, v
        end
    end
end

function table.findarray(t, fn)
    local g = {}
    for k, v in pairs(t) do
        if fn(v, k) then
            tbl_insert(g, v)
        end
    end
    return g
end

function table.findhash(t, fn)
    local g = {}
    for k, v in pairs(t) do
        if fn(v, k) then
            g[k] = v
        end
    end
    return g
end

function table.ifindarray(t, fn)
    local g = {}
    for i, v in ipairs(t) do
        if fn(v, i) then
            tbl_insert(g, v)
        end
    end
    return g
end

function table.maparray(t, fn)
    local g = {}
    for k, v in pairs(t) do
        local _t = fn(v, k)
        tbl_insert(g, _t)
    end
    return g
end

function table.maphash(t, fn)
    local g = {}
    for k, v in pairs(t) do
        g[k] = fn(v, k)
    end
    return g
end

function table.mapfind(t, fn)
    for k, v in pairs(t) do
        local _t = fn(v, k)
        if _t then
            return _t
        end
    end
end

function table.imapfind(t, fn)
    for i, v in ipairs(t) do
        local _t = fn(v, i)
        if _t then
            return _t
        end
    end
end

function table.imaparray(t, fn)
    local g = {}
    for i, v in ipairs(t) do
        local _t = fn(v, i)
        tbl_insert(g, _t)
    end
    return g
end

function table.filter(t, fn)
    for k, v in pairs(t) do
        if not fn(v, k) then
            t[k] = nil
        end
    end
end

function table.unique(t, bArray)
    local check = {}
    local n = {}
    local idx = 1
    for k, v in pairs(t) do
        if not check[v] then
            if bArray then
                n[idx] = v
                idx = idx + 1
            else
                n[k] = v
            end
            check[v] = true
        end
    end
    return n
end

---
--- string
---
string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set['"'] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = str_gsub(input, k, v)
    end
    return input
end

function string.restorehtmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = str_gsub(input, v, k)
    end
    return input
end

function string.nl2br(input)
    return str_gsub(input, "\n", "<br />")
end

function string.text2html(input)
    input = str_gsub(input, "\t", "    ")
    input = string.htmlspecialchars(input)
    input = str_gsub(input, " ", "&nbsp;")
    input = string.nl2br(input)
    return input
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == "") then
        return false
    end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function()
        return str_find(input, delimiter, pos, true)
    end do
        tbl_insert(arr, str_sub(input, pos, st - 1))
        pos = sp + 1
    end
    tbl_insert(arr, str_sub(input, pos))
    return arr
end

function string.ltrim(input)
    return str_gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
    return str_gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
    input = str_gsub(input, "^[ \t\n\r]+", "")
    return str_gsub(input, "[ \t\n\r]+$", "")
end

function string.ucfirst(input)
    return string.upper(str_sub(input, 1, 1)) .. str_sub(input, 2)
end

function string.urlencode(input)
    -- convert line endings
    input = str_gsub(tostring(input), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    input = str_gsub(input, "([^%w%.%- ])", function(ch) return "%" .. string.format("%02X", str_byte(ch)) end)
    -- convert spaces to "+" symbols
    return str_gsub(input, " ", "+")
end

function string.urldecode(input)
    input = str_gsub(input, "+", " ")
    input =
        str_gsub(
        input,
        "%%(%x%x)",
        function(h)
            return string.char(__safe_number(h, 16))
        end
    )
    input = str_gsub(input, "\r\n", "\n")
    return input
end

function string.utf8len(input)
    local len = str_len(input)
    local left = len
    local cnt = 0
    local arr = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = str_byte(input, -left)
        local i = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

function string.formatnumberthousands(num)
    local formatted = tostring(__safe_number(num))
    local k
    while true do
        formatted, k = str_gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then
            break
        end
    end
    return formatted
end
