local delay = 60 -- in seconds
local STDERR = ngx.STDERR
local EMERG = ngx.EMERG
local ALERT = ngx.ALERT
local CRIT = ngx.CRIT
local ERR = ngx.ERR
local WARN = ngx.WARN
local NOTICE = ngx.NOTICE
local INFO = ngx.INFO
local DEBUG = ngx.DEBUG

--
require = require("utils.require").require

-- lapis
package.path = package.path .. ";/home/www/oss/lualibs/lapis-1.7.0/?.lua;/home/www/oss/lualibs/lapis-1.7.0/?/init.lua"
package.path = package.path .. ";/home/www/oss/lualibs/loadkit-1.1.0/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/etlua-1.3.0/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lapis-redis/?.lua"
package.path = package.path .. ";/home/www/oss/lua/web/?.lua" -- for lapis's MVC view path

-- resty: core, lrucache, mysql, jit-uuid, redis, string, limit-traffic, mongol
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-core-0.1.16rc3/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-lrucache-0.09rc1/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-mysql-0.21/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-jit-uuid-0.0.7/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-redis-0.26/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-string-0.11/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-limit-traffic-0.06rc1/lib/?.lua"
package.path = package.path .. ";/home/www/oss/lualibs/lua-resty-mongol-master/lib/?.lua;/home/www/oss/lualibs/lua-resty-mongol-master/lib/?/init.lua"

-- date
package.path = package.path .. ";/home/www/oss/lualibs/luadate-2.1/?.lua"

-- print package path
print("\n======== package.path ========\n" .. package.path)
print("\n======== package.cpath ========\n" .. package.cpath)

--
require("uuid")

--[[
local func_check_per_min = function(premature)
    -- do some routine job in Lua just like a cron job
    if premature then
         return
    end
    --
    ngx.log(NOTICE, "do the health check or other routine work")

    --
end

if 0 == ngx.worker.id() then
    ngx.log(NOTICE, "[init_worker_http] start heartbeat timer at worker -- ", ngx.worker.id())

    local ok, err = ngx.timer.every(delay, func_check_per_min)
    if not ok then
        ngx.log(ERR, "failed to create timer: ", err)
        return
    end
end
--[[]]