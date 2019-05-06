local _M = {
  _VERSION = "1.0.0.1",
  _DESCRIPTION = "options for mongodb..."
}

-- Localize
local cwd = (...):gsub("%.[^%.]+$", "") .. "."
local split = require("utils.split")

function _M.new(settings)
  if type(settings) == "string" then
    --[[
      mongodb_url = 'Server=192.168.209.129;Port=27017;Database=my_umb_web'
    ]]
    local mongodb_url = settings
    local parsed = {}

    for param in split.each(mongodb_url, "%s*;%s*") do
      local k, v = split.first(param, "%s*=%s*")
      parsed[k] = v
    end

    local host = parsed.Server or "127.0.0.1"
    local port = parsed.Port or 27017
    local database = assert(parsed.Database, "`database` missing from config for resty_mongol")
    local timeout = parsed.Timeout or 100000
    local max_idle_timeout = parsed.MaxIdleTimeout or 100000
    local pool_size = parsed.PoolSize or 100

    local options = {
      host = host,
      port = port,
      database = database,
      timeout = timeout,
      max_idle_timeout = max_idle_timeout,
      pool_size = pool_size,
    }

    options.pool = "mongodb:" .. database .. ":" .. host .. ":" .. port

    return options
  elseif type(settings) == "table" then
    --[[
      mongodb_config = {
        host = "127.0.0.1",
        port = 27017,
        database = "my_umb_web"
      },
    ]]
    local mongodb_config = settings

    local host = mongodb_config.host or "127.0.0.1"
    local port = mongodb_config.port or 27017
    local database = assert(mongodb_config.database, "`database` missing from config for resty_mongol")
    local timeout = mongodb_config.timeout or 100000
    local max_idle_timeout = mongodb_config.max_idle_timeout or 100000
    local pool_size = mongodb_config.pool_size or 100

    local options = {
      host = host,
      port = port,
      database = database,
      timeout = timeout,
      max_idle_timeout = max_idle_timeout,
      pool_size = pool_size,
    }

    options.pool = "mongodb:" .. database .. ":" .. host .. ":" .. port

    return options
  else
    error("unsupported settings type for db_options!!! type(settings)=" .. type(settings))
  end
end

return _M
