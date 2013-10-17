require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJZTKQSL62KW4T2JQ',                        # required
    :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = "crowdscore-media-#{Rails.env}"                     # required
end