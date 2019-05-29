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

local NEWS_TYPE_VERSION = 1
local NEWS_TYPE_CHEAT = 2
local NEWS_TYPE_FAQ = 3

return function(app)
  app:match("news_manage", "/NewsManage", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      return { render = "news.Manage", layout = false }
    end,
  }))

  ---
  --- version
  ---
  app:match("news_version", "/NewsManage/Version", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      local NewsCenter = require("models.NewsCenter")
      local newstype = NEWS_TYPE_VERSION
      local newsList = NewsCenter.getAllByType(newstype)
      
      if #newsList > 0 then
        self.CurrentNews = newsList[1]
      end
      
      return { render = "news.Version", layout = false }
    end,
  }))

  app:match("news_version_create", "/NewsManage/Version/Create", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      --
      return { render = "news.VersionCreate", layout = false }
    end,

    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local NewsCenter = require("models.NewsCenter")
      local d = date(false)

      local newstype = NEWS_TYPE_VERSION
      local content, createby, createtime
      if self.session.user then
        content = self.params.Content
        createby = self.session.user.UserName
        createtime = d:fmt("%F %T")
        NewsCenter.create(newstype, content, createby, createtime)
        
        return { redirect_to = self:url_for("news_version") }
      else
        --assert_error(false, "创建失败!")
      end
    end,
    -- on_error
    function(self)
        return { render = "news.Version", layout = false }
    end)
  }))
  
  app:match("news_version_edit", "/NewsManage/Version/Edit", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      local News = require("models.NewsCenter")
      local id = self.params.Id
      local obj = News.get(id)
      if obj then
        self.CurrentNews = obj
      else
        assert_error(false, "编辑失败!")
      end
        
      return { render = "news.VersionEdit", layout = false }
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_version") }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local News = require("models.NewsCenter")
      local d = date(false)
      
      local id = self.params.Id
      local obj = News.get(id)
      if obj and self.session.user then
        obj.content = self.params.Content
        obj.createby = self.session.user.UserName
        obj.createtime = d:fmt("%F %T")
        News.update(obj)
      else
        assert_error(false, "编辑失败Post!")
      end
      
      self.results = { status = "success" }
      self.CurrentNews = obj
      return { render = "news.VersionEdit", layout = false }
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_version") }
    end),
  }))

  app:match("news_version_delete", "/NewsManage/Version/Delete", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      self.Consent = {
        Id = self.params.Id,
        SourceUrl = self:url_for(self.route_name),
        Tips = "确认删除？",
      }
      
      return { render = "consent.Index", layout = false }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "IsConsent", exists = true },
      })
      
      if "yes" == self.params.IsConsent then
        
        local News = require("models.NewsCenter")
        local id = self.params.Id
        News.deleteById(id)
        return { redirect_to = self:url_for("news_version") }
      else
        return { redirect_to = self:url_for("news_version") }
      end
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_version") }
    end),
  }))

  ---
  --- cheat
  ---
  app:match("news_cheat", "/NewsManage/Cheat", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      local NewsCenter = require("models.NewsCenter")
      local newstype = NEWS_TYPE_CHEAT
      local newsList = NewsCenter.getAllByType(newstype)
      
      if #newsList > 0 then
        self.CurrentNews = newsList[1]
      end
      
      return { render = "news.Cheat", layout = false }
    end,
  }))

  app:match("news_cheat_create", "/NewsManage/Cheat/Create", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      --
      return { render = "news.CheatCreate", layout = false }
    end,

    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local NewsCenter = require("models.NewsCenter")
      local d = date(false)

      local newstype = NEWS_TYPE_CHEAT
      local content, createby, createtime
      if self.session.user then
        content = self.params.Content
        createby = self.session.user.UserName
        createtime = d:fmt("%F %T")
        NewsCenter.create(newstype, content, createby, createtime)
        
        return { redirect_to = self:url_for("news_cheat") }
      else
        --assert_error(false, "创建失败!")
      end
    end,
    -- on_error
    function(self)
        return { render = "news.Cheat", layout = false }
    end)
  }))
  
  app:match("news_cheat_edit", "/NewsManage/Cheat/Edit", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      local News = require("models.NewsCenter")
      local id = self.params.Id
      local obj = News.get(id)
      if obj then
        self.CurrentNews = obj
      else
        assert_error(false, "编辑失败!")
      end
        
      return { render = "news.CheatEdit", layout = false }
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_cheat") }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local News = require("models.NewsCenter")
      local d = date(false)
      
      local id = self.params.Id
      local obj = News.get(id)
      if obj and self.session.user then
        obj.content = self.params.Content
        obj.createby = self.session.user.UserName
        obj.createtime = d:fmt("%F %T")
        News.update(obj)
      else
        assert_error(false, "编辑失败Post!")
      end
      
      self.results = { status = "success" }
      self.CurrentNews = obj
      return { render = "news.CheatEdit", layout = false }
    end,
    -- on_error
    function(self)
        return { redirect_to = self:url_for("news_version") }
    end),
  }))

  app:match("news_cheat_delete", "/NewsManage/Cheat/Delete", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      self.Consent = {
        Id = self.params.Id,
        SourceUrl = self:url_for(self.route_name),
        Tips = "确认删除？",
      }
      
      return { render = "consent.Index", layout = false }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "IsConsent", exists = true },
      })
      
      if "yes" == self.params.IsConsent then
        
        local News = require("models.NewsCenter")
        local id = self.params.Id
        News.deleteById(id)
        return { redirect_to = self:url_for("news_cheat") }
      else
        return { redirect_to = self:url_for("news_cheat") }
      end
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_cheat") }
    end),
  }))

  ---
  --- FAQ
  ---
  app:match("news_faq", "/NewsManage/FAQ", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      local NewsCenter = require("models.NewsCenter")
      local newstype = NEWS_TYPE_FAQ
      local newsList = NewsCenter.getAllByType(newstype)
      
      if #newsList > 0 then
        self.CurrentNews = newsList[1]
      end
      
      return { render = "news.FAQ", layout = false }
    end,
  }))

  app:match("news_faq_create", "/NewsManage/FAQ/Create", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    GET = function(self)
      --
      return { render = "news.FAQCreate", layout = false }
    end,

    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local NewsCenter = require("models.NewsCenter")
      local d = date(false)

      local newstype = NEWS_TYPE_FAQ
      local content, createby, createtime
      if self.session.user then
        content = self.params.Content
        createby = self.session.user.UserName
        createtime = d:fmt("%F %T")
        NewsCenter.create(newstype, content, createby, createtime)
        
        return { redirect_to = self:url_for("news_faq") }
      else
        --assert_error(false, "创建失败!")
      end
    end,
    -- on_error
    function(self)
        return { render = "news.FAQ", layout = false }
    end)
  }))
  
  app:match("news_faq_edit", "/NewsManage/FAQ/Edit", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      local News = require("models.NewsCenter")
      local id = self.params.Id
      local obj = News.get(id)
      if obj then
        self.CurrentNews = obj
      else
        assert_error(false, "编辑失败!")
      end
        
      return { render = "news.FAQEdit", layout = false }
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_faq") }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "Content", exists = true, min_length = 2, max_length = 4096 },
      })
      
      local News = require("models.NewsCenter")
      local d = date(false)
      
      local id = self.params.Id
      local obj = News.get(id)
      if obj and self.session.user then
        obj.content = self.params.Content
        obj.createby = self.session.user.UserName
        obj.createtime = d:fmt("%F %T")
        News.update(obj)
      else
        assert_error(false, "编辑失败Post!")
      end
      
      self.results = { status = "success" }
      self.CurrentNews = obj
      return { render = "news.FAQEdit", layout = false }
    end,
    -- on_error
    function(self)
        return { redirect_to = self:url_for("news_version") }
    end),
  }))

  app:match("news_faq_delete", "/NewsManage/FAQ/Delete", respond_to({
    --
    before = function(self)
      auth(self, "any", self.route_name)
    end,
    
    --
    GET = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
      })
      
      self.Consent = {
        Id = self.params.Id,
        SourceUrl = self:url_for(self.route_name),
        Tips = "确认删除？",
      }
      
      return { render = "consent.Index", layout = false }
    end),
  
    --
    POST = capture_errors(function(self)
      validate.assert_valid(self.params, {
        { "Id", exists = true, min_length = 24, max_length = 24 },
        { "IsConsent", exists = true },
      })
      
      if "yes" == self.params.IsConsent then
        
        local News = require("models.NewsCenter")
        local id = self.params.Id
        News.deleteById(id)
        return { redirect_to = self:url_for("news_faq") }
      else
        return { redirect_to = self:url_for("news_faq") }
      end
    end,
    -- on_error
    function(self)
      return { redirect_to = self:url_for("news_faq") }
    end),
  }))

end