local ffi = require "ffi"

local sizeof = ffi.sizeof
local offsetof = ffi.offsetof
local C = ffi.C

local tbl_insert = table.insert
local str_sub = string.sub
local tonumber = tonumber

local PER_FRAME_PAGE_SIZE_MAX = 4096

ffi.cdef [[

#pragma pack(1)

typedef struct
{
	char			key[8];
	unsigned int	size;
	unsigned int	sessionId;
	unsigned short	msgId;
	unsigned char	version;
	char			reserve[1];
} MSG_HEADER;

#pragma pack()

typedef struct memory_stream_s
{
	size_t  capacity;
	char   *buf;
    char   *cursor_r;
    char   *cursor_w;
} memory_stream_t;

memory_stream_t * create_memory_stream(size_t capacity);
void              destroy_memory_stream(memory_stream_t *stream);

void              memory_stream_reset(memory_stream_t *stream);
void              memory_stream_rewind(memory_stream_t *stream);
void              memory_stream_skip(memory_stream_t *stream, int len);
void              memory_stream_skip_all(memory_stream_t *stream);
int               memory_stream_get_used_size(memory_stream_t *stream);
int               memory_stream_get_free_size(memory_stream_t *stream);
bool              memory_stream_ensure_free_size(memory_stream_t *stream, int size);

int8_t            memory_stream_read_byte(memory_stream_t *stream);
int16_t           memory_stream_read_int16(memory_stream_t *stream);
int32_t           memory_stream_read_int32(memory_stream_t *stream);
int64_t           memory_stream_read_int64(memory_stream_t *stream);
const char *      memory_stream_read_string(memory_stream_t *stream, int16_t *outlen);

void              memory_stream_write_byte(memory_stream_t *stream, int8_t d);
void              memory_stream_write_int16(memory_stream_t *stream, int16_t d2);
void              memory_stream_write_int32(memory_stream_t *stream, int32_t d4);
void              memory_stream_write_int64(memory_stream_t *stream, int64_t d8);
void              memory_stream_write_string(memory_stream_t *stream, const char *str, int16_t len);

]]

local frame_leading_t = ffi.typeof("MSG_HEADER")
local SIZE_OF_FRAME_PAGE_LEADING = sizeof(frame_leading_t, 0)
local ffilib_lcu = ffi.load(ffi.os == "Windows" and "./clibs/lcu.dll" or "lcu")

----
local _P = {}

--
function _P:read(s)
    -- frame leading
    local fldata, flerr = s:receive(SIZE_OF_FRAME_PAGE_LEADING)
    if not fldata then
        return nil, flerr, "failed to read frame leading"
    end

    -- parse header
    ffi.copy(self.frm_l_r, fldata, #fldata)

    while true do
        --
        local remain_data_size = self.frm_l_r.size

        -- packet body
        local bodydata, bdderr = s:receive(remain_data_size)
        if not bodydata then
            return nil, bdderr, "failed to read packet data"
        end

        local bodydata_size = #bodydata
        if bodydata_size > PER_FRAME_PAGE_SIZE_MAX then
            return nil, "bodydata_size overflow"
        end

        -- packet info
        self.pkt_r.sessionid = self.frm_l_r.sessionId
        self.pkt_r.msgid = self.frm_l_r.msgId
        self.pkt_r.msgsize = bodydata_size

        -- write body to stream
        ffilib_lcu.memory_stream_reset(self.pkt_r_stream)
        ffilib_lcu.memory_stream_write_raw(self.pkt_r_stream, bodydata, self.pkt_r.msgsize)

        break
    end

    return self.pkt_r
end

--
function _P:write(s, sessionid, msgid, msgdata)
    local sent = 0
    local remain_size = #msgdata
    local send_size_max
    local send_size
    local pkt_w

    -- first page
    send_size_max = PER_FRAME_PAGE_SIZE_MAX - SIZE_OF_FRAME_PAGE_LEADING

    pkt_w = {}
    send_size = (remain_size <= send_size_max) and remain_size or send_size_max
    remain_size = remain_size - send_size

    -- check overflow
    if remain_size > 0 then
        error("packet size overflow!!!")
    else
        -- frame leading init
        self.frm_l_w.size = send_size
        self.frm_l_w.sessionId = sessionid
        self.frm_l_w.msgId = msgid
        self.frm_l_w.version = 234
        self.frm_l_w.reserve = "a"

        -- header
        tbl_insert(pkt_w, ffi.string(self.frm_l_w, SIZE_OF_FRAME_PAGE_LEADING))

        -- body
        tbl_insert(pkt_w, str_sub(msgdata, 1, send_size))

        s:send(pkt_w)
        sent = sent + SIZE_OF_FRAME_PAGE_LEADING + send_size
    end

    return sent
end

-- packet type 3: zjh packet
_P.new = function()
    -- reader stream
    local function _reader_stream_rewind(self)
        return ffilib_lcu.memory_stream_rewind(self.pkt_r_stream)
    end

    local function _reader_stream_skip(self, len)
        return ffilib_lcu.memory_stream_skip(self.pkt_r_stream, len)
    end

    local function _reader_stream_get_used_size(self)
        return ffilib_lcu.memory_stream_get_used_size(self.pkt_r_stream)
    end

    local function _reader_stream_get_free_size(self)
        return ffilib_lcu.memory_stream_get_free_size(self.pkt_r_stream)
    end

    local function _reader_stream_read_byte(self)
        return ffilib_lcu.memory_stream_read_byte(self.pkt_r_stream)
    end

    local function _reader_stream_read_int16(self)
        return ffilib_lcu.memory_stream_read_int16(self.pkt_r_stream)
    end

    local function _reader_stream_read_int32(self)
        return ffilib_lcu.memory_stream_read_int32(self.pkt_r_stream)
    end

    local function _reader_stream_read_int64(self)
        return tonumber(ffilib_lcu.memory_stream_read_int64(self.pkt_r_stream))
    end

    local function _reader_stream_read_string(self)
        local stream_buffer = ffilib_lcu.memory_stream_read_string(self.pkt_r_stream, self.pkt_r_stream_string_len)
        return ffi.string(stream_buffer, self.pkt_r_stream_string_len[0])
    end

    -- writer stream
    local function _writer_stream_reset(self)
        return ffilib_lcu.memory_stream_reset(self.pkt_w_stream)
    end

    local function _writer_stream_get_used_size(self)
        return ffilib_lcu.memory_stream_get_used_size(self.pkt_w_stream)
    end

    local function _writer_stream_get_free_size(self)
        return ffilib_lcu.memory_stream_get_free_size(self.pkt_w_stream)
    end

    local function _writer_stream_write_byte(self, d1)
        return ffilib_lcu.memory_stream_write_byte(self.pkt_w_stream, d1)
    end

    local function _writer_stream_write_int16(self, d2)
        return ffilib_lcu.memory_stream_write_int16(self.pkt_w_stream, d2)
    end

    local function _writer_stream_write_int32(self, d4)
        return ffilib_lcu.memory_stream_write_int32(self.pkt_w_stream, d4)
    end

    local function _writer_stream_write_int64(self, d8)
        return ffilib_lcu.memory_stream_write_int64(self.pkt_w_stream, ffi.new("int64_t", d8))
    end

    local function _writer_stream_write_string(self, str)
        return ffilib_lcu.memory_stream_write_string(self.pkt_w_stream, str, #str)
    end

    local function _send_packet(self, sock, sessionid, msgid)
        local buflen = ffilib_lcu.memory_stream_get_used_size(self.pkt_w_stream)
        local msgdata = ffi.string(self.pkt_w_stream.buf, buflen)
        return self:write(sock, sessionid, msgid, msgdata)
    end

    --
    local function __create_stream(self)
        return ffilib_lcu.create_memory_stream(PER_FRAME_PAGE_SIZE_MAX * 2)
    end

    local self = {
        -- read
        frm_l_r = frame_leading_t(),
        pkt_r_stream = __create_stream(),
        pkt_r_stream_string_len = ffi.new("int16_t[1]", 0),
        pkt_r = {
            sessionid = 0,
            msgid = 0,
            msgsize = 0
        },

        --
        reader_skip = _reader_stream_skip,
        reader_get_used_size = _reader_stream_get_used_size,
        reader_get_free_size = _reader_stream_get_free_size,
        read_byte = _reader_stream_read_byte,
        read_int16 = _reader_stream_read_int16,
        read_int32 = _reader_stream_read_int32,
        read_int64 = _reader_stream_read_int64,
        read_string = _reader_stream_read_string,
        -- write
        frm_l_w = frame_leading_t(),
        pkt_w_stream = __create_stream(),
        --
        writer_reset = _writer_stream_reset,
        writer_get_used_size = _writer_stream_get_used_size,
        writer_get_free_size = _writer_stream_get_free_size,
        write_byte = _writer_stream_write_byte,
        write_int16 = _writer_stream_write_int16,
        write_int32 = _writer_stream_write_int32,
        write_int64 = _writer_stream_write_int64,
        write_string = _writer_stream_write_string,
        --
        send_packet = _send_packet
    }

    return setmetatable(
        self,
        {
            __index = _P
        }
    )
end

return _P
