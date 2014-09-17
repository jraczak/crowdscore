# geocoding service (see below for supported options):

#Geocoder::Configuration.lookup = :google

Geocoder.configure(
  :lookup => :google,
  :timeout => 5,)

# to use an API key:
Geocoder::Configuration.api_key = "AIzaSyBhPFZz5fazzkwQwiexGXBTqEZ8Vj7_U7M"
