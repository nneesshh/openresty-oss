local lapis = require("lapis")
local appconfig = require("lapis_appconfig")
local config = appconfig.getConfig()

if config.postgres then
  local options = {}
  for k, v in pairs(config.postgres) do
    options[k] = v
  end
  return options
else
  return error("You have to configure 'postgres' in 'lapis_appconfig'")
end
