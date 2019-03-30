local lapis = require("lapis")
local appconfig = require("lapis_appconfig")
local config = appconfig.getConfig()

if config.mysql then
  local db_options = require("db.mysql_options")
  return db_options.new(config.mysql)
else
  return error("You have to configure 'mysql' in 'lapis_appconfig'")
end
