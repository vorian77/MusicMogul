Rails.application.assets.logger = Logger.new('/dev/null')
Rails::Rack::Logger.class_eval do
  def call_with_quiet_assets(env)
    previous_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0
    call_without_quiet_assets(env).tap { Rails.logger.level = previous_level }
  end
  alias_method_chain :call, :quiet_assets
 end
