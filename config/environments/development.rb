Mvp2::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.active_record.mass_assignment_sanitizer = :strict
  config.active_record.auto_explain_threshold_in_seconds = 0.5
	config.action_mailer.default_url_options = { :host => 'localhost:3000' }
	config.action_mailer.perform_deliveries = false
  config.assets.compress = false
  config.assets.debug = true

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.disable_browser_cache = true
  end
end
