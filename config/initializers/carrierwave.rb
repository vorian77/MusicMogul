ENV['AWS_SECRET_ACCESS_KEY'] = "AorwybwpmYAK2N2TOZ1RjINQugICitXPzMC2q+a/"
ENV['AWS_ACCESS_KEY_ID'] = "AKIAIAZHJIZGTW6R55AQ"
ENV['AWS_BUCKET'] = "FanHelpMVP"

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  if Rails.env.development?
    # config.storage = :file
    config.storage = :fog
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
  end
end
