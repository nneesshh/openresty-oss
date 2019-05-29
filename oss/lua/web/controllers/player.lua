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
  app:match("player_manage", "/PlayerManage", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = function(self)
      return { render = "player.Manage", layout = false }
    end,
    
  }))

  app:match("player_query_online", "/PlayerManage/QueryOnline", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      --
      return { render = "player.QueryOnline", layout = false }
    end,

    --
    POST = capture_errors(function(self)
      local byTicketId = false
      local ticketid = 0
      if self.params.ByTicketId == "true" then
        byTicketId = true
        validate.assert_valid(self.params, {
          { "UserTicketId", exists = true, min_length = 7, max_length = 7 },
        })
        ticketid = tonumber(self.params.UserTicketId)
        if not ticketid then
          assert_error(false, "UserTicketId(" .. tostring(self.params.UserTicketId) ..  ") must be a 7 digit number!!!")
        end
      else
        validate.assert_valid(self.params, {
          { "UserName", exists = true, min_length = 2, max_length = 50 },
        })
      end
    
      local PlayerCenter = require("models.PlayerCenter")

      local userInfo
      if byTicketId then
        -- check player ticketid 
        userInfo = PlayerCenter.getUserInfoByTicketId(ticketid)
        if not userInfo then
          assert_error(false, "UserTicketId(" .. tostring(self.params.UserTicketId) ..  ") not exist!!!")
        end
      else
        -- check player username
        userInfo = PlayerCenter.getUserInfo(self.params.UserName)
        if not userInfo then
          assert_error(false, "UserName(" .. tostring(self.params.UserName) ..  ") not exist!!!")
        end
      end

      local userState = PlayerCenter.getUserState(userInfo.user_name)
      
      -- merge userState and userInfo
      local data = userState or {}
      for k, v in pairs(userInfo) do
        data[k] = v
      end

      if data and self.session.user then
        self.success_infos = { "Success" }
        self.PlayerData = { data } -- PlayerData is a row array
        return { render = "player.QueryOnline", layout = false }
      else
        --assert_error(false, "xxxx错误!")
      end
    end,
    -- on_error
    function(self)
      return { render = "player.QueryOnline", layout = false }
  end)
    
  }))

  app:match("player_query_charge", "/PlayerManage/QueryCharge", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,

    GET = function(self)
      --
      return { render = "player.QueryCharge", layout = false }
    end,
    
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "UserName", exists = true, min_length = 2, max_length = 50 },
        { "BeginDate", optional=true, min_length = 10, max_length = 22 },
        { "EndDate", optional=true, min_length = 10, max_length = 22 },
      })
    
      local PlayerCenter = require("models.PlayerCenter")
      
      -- check username
      local userInfo = PlayerCenter.getUserInfo(self.params.UserName)
      if not userInfo then
        assert_error(false, "UserName(" .. tostring(self.params.UserName) ..  ") not exist!!!")
      end

      local d1 = date(false)

      -- check begin_time
      local week_ago = date(d1):adddays(-7)
      local begin_time = week_ago:fmt("%F")
      if self.params.BeginDate and self.params.BeginDate ~= "" then
        local d2 = date(self.params.BeginDate)
        begin_time = d2:fmt("%F")
      end

      -- check end_time
      local end_time = d1:fmt("%F")
      if self.params.EndDate and self.params.EndDate ~= "" then
        local d2 = date(self.params.EndDate)
        end_time = d2:fmt("%F")
      end

      --
      local chargeLog = PlayerCenter.getChargeLog(userInfo.user_name, begin_time, end_time)
      
      local data = chargeLog
      if data and self.session.user then
        self.success_infos = { "Success" }
        self.PlayerData = data
        return { render = "player.QueryCharge", layout = false }
      else
        --assert_error(false, "xxxx错误!")
      end

    end,
    -- on_error
    function(self)
      return { render = "player.QueryCharge", layout = false }
  end)
  }))

  app:match("player_gm_add_coin", "/PlayerManage/GMAddCoin", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,

    GET = function(self)
      --
      return { render = "player.GMAddCoin", layout = false }
    end,
    
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "UserTicketId", optional = true, is_integer = true, min_length = 7, max_length = 7 },
        { "UserName", optional = true, min_length = 2, max_length = 50 },
        { "CoinNum", exists = true, min_length = 1, max_length = 10 },
      })
    
      local PlayerCenter = require("models.PlayerCenter")

      local ticketid = tonumber(self.params.UserTicketId)
      local username = self.params.UserName
      local coinNum = tonumber(self.params.CoinNum)

      -- add coin
      local r, err
      if ticketid then
        r, err = PlayerCenter.gm_addCoinByTicketId(ticketid, coinNum)
        if r then
          self.success_infos = { "Success" }
        else
          assert_error(false, "[PlayerCenter.gm_addCoinByTicketId()] failed, err(" .. tostring(err) ..  ")!!!")
        end
      elseif username and #username > 6 then
        r, err = PlayerCenter.gm_addCoinByUserName(username, coinNum)
        if r then
          self.success_infos = { "Success" }
        else
          assert_error(false, "[PlayerCenter.gm_addCoinByUserName()] failed, err(" .. tostring(err) ..  ")!!!")
        end
      else
        r, err = PlayerCenter.gm_addCoin(coinNum)
        if r then
          self.success_infos = { "Success" }
        else
          assert_error(false, "[PlayerCenter.gm_addCoin()] failed, err(" .. tostring(err) ..  ")!!!")
        end
      end

      -- adjust < 0 to coinNum
      PlayerCenter.gm_adjustNegtiveCoin(0)
      return { render = "player.GMAddCoin", layout = false }
    end,
    -- on_error
    function(self)
      return { render = "player.GMAddCoin", layout = false }
  end)
  }))

end
