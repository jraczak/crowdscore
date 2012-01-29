require File.expand_path("../cuke_sunspot", __FILE__)
CukeSunspot.new.start

at_exit do
  EphemeralResponse.deactivate
  CukeSunspot.new.stop
end

EphemeralResponse.configure do |config|
  config.expiration = 1.month
  config.white_list = 'localhost', '127.0.0.1'
  config.debug_output = $stderr
end

EphemeralResponse.activate
