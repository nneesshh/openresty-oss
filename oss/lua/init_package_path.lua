-- common
package.path = package.path .. ";./?.lua;./lua/?.lua;./lua/?/init.lua"
package.path = package.path .. ";./lualibs/?.lua;./lualibs/?/init.lua"
package.path = package.path .. ";./src/?.lua;./src/?/init.lua"

package.cpath = package.cpath .. ";./?.dll;./clibs/?.dll"

-- lua socket
package.path = package.path .. ";./lualibs/socket/?.lua"

-- 
require = require("utils.require").require

--dofile "lua/main.lua"
--dofile "lua/test_mongo.lua"