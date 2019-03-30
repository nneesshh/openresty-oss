local lapis = require("lapis")
local appconfig = require("lapis_appconfig")
local config = appconfig.getConfig()

if config.mongodb then
  local db_options = require("db.mongodb_options")
  return db_options.new(config.mongodb)
else
  return error("You have to configure 'mongodb' in 'lapis_appconfig'")
end
