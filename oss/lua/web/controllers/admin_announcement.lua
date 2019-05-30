-- Localize
local cwd = (...):gsub('%.[^%.]+$', '') .. "."
local ostime = os.time
local date = require("date")

local appconfig = require("lapis_appconfig")
local config = appconfig.getConfig()

local app_helpers = require("lapis.application")
local respond_to = app_helpers.respond_to
local capture_errors = app_helpers.capture_errors
local assert_error = app_helpers.assert_error

local validate = require("lapis.validate")

local auth = require(cwd .. "authorize")

return function(app)
  app:match("admin_announcement", "/AdminGameAnnouncement", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      local GameAnnouncement = require("models.GameAnnouncement")
      local gameAnnouncementList = GameAnnouncement.getLatest()
      
      if #gameAnnouncementList > 0 then
        self.CurrentGameAnnouncement = gameAnnouncementList[1]
      end

      return { render = "admin.GameAnnouncement", layout = false }
    end,

  }))

  app:match("admin_announcement_create", "/AdminGameAnnouncement/Create", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      --
      return { render = "admin.GameAnnouncementCreate", layout = false }
    end,

    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "DeadlineTime", exists = true, min_length = 16, max_length = 22 },
        { "PlayInterval", exists = true, min_length = 1, max_length = 3 },
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })

      local GameAnnouncement = require("models.GameAnnouncement")
      local now = date(false)
    
      -- check deadline time
      local ten_min_later = now:copy():addminutes(10)
      local deadlinetime = ten_min_later
      
      if self.params.DeadlineTime ~= "" then
        local dIn = date(self.params.DeadlineTime)
        if dIn > now then
          deadlinetime = dIn
        end
      end
      
      -- check interval seconds
      local intervalSeconds = tonumber(self.params.PlayInterval)
      if not intervalSeconds then
        intervalSeconds = 30
      end
      
      if self.session.user then
          GameAnnouncement.create(deadlinetime, intervalSeconds, self.params.Content, now)
          
          return { redirect_to = self:url_for("admin_announcement") }
      else
        --assert_error(false, "创建失败!")
      end    
    end,
    -- on_error
    function(self)
        return { render = "admin.GameAnnouncementCreate", layout = false }
    end)
  }))

end