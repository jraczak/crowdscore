require 'carrierwave/orm/activerecord'
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|
  config.cache_dir = Rails.root.join('tmp', 'uploads')
  config.fog_credentials = {
    :provider => "AWS"
  }
  config.fog_directory = "crowdscore-#{Rails.env}"
end
