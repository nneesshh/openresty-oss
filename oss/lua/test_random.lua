-- common
package.path = package.path .. ";./?.lua;./lua/?.lua;./lua/?/init.lua"
package.path = package.path .. ";./lualibs/?.lua;./lualibs/?/init.lua"
package.path = package.path .. ";./src/?.lua;./src/?/init.lua"

package.cpath = package.cpath .. ";./?.dll;./clibs/?.dll"

-- lua socket
package.path = package.path .. ";./lualibs/socket/?.lua"

require("bootstrap")

local rand = math.random
for i=1, 1000 do
    print(rand(1, 450))
end

print("Over")