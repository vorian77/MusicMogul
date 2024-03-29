Mvp2::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  config.assets.precompile += %w[active_admin.css active_admin.js]
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { :host => 'www.musicmogul.com' }
  config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
    r301 %r{.*}, 'http://www.musicmogul.com$&', :if => Proc.new { |rack_env|
      !["www.musicmogul.com"].include?(rack_env['SERVER_NAME'])
    }
  end
end
