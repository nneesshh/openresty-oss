-- common
package.path = package.path .. ";./?.lua;./lua/?.lua;./lua/?/init.lua"
package.path = package.path .. ";./lualibs/?.lua;./lualibs/?/init.lua"
package.path = package.path .. ";./src/?.lua;./src/?/init.lua"

package.cpath = package.cpath .. ";./?.dll;./clibs/?.dll"

-- lua socket
package.path = package.path .. ";./lualibs/socket/?.lua"

-- lapis
package.path = package.path .. ";./lualibs/lapis-1.7.0/?.lua;./lualibs/lapis-1.7.0/?/init.lua"
package.path = package.path .. ";./lualibs/loadkit-1.1.0/?.lua"
package.path = package.path .. ";./lualibs/etlua-1.3.0/?.lua"
package.path = package.path .. ";./lualibs/lapis-redis/?.lua"
package.path = package.path .. ";./lua/web/?.lua" -- for lapis's MVC view path
package.path = package.path .. ";./lapis_env/?.lua"

-- resty: core, lrucache, mysql, jit-uuid, redis, string, limit-traffic, mongol
package.path = package.path .. ";./lualibs/lua-resty-core-0.1.16rc3/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-lrucache-0.09rc1/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-mysql-0.21/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-jit-uuid-0.0.7/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-redis-0.26/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-string-0.11/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-limit-traffic-0.06rc1/lib/?.lua"
package.path = package.path .. ";./lualibs/lua-resty-mongol-master/lib/?.lua;./lualibs/lua-resty-mongol-master/lib/?/init.lua"

-- date
package.path = package.path .. ";./lualibs/luadate-2.1/?.lua"

-- 
require = require("utils.require").require

-- print package path
print("\n======== package.path ========\n" .. package.path)
print("\n======== package.cpath ========\n" .. package.cpath)

--dofile "lua/main.lua"
--dofile "lua/test_mongo.lua"