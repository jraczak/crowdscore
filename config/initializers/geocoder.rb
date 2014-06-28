# geocoding service (see below for supported options):

#Geocoder::Configuration.lookup = :google

Geocoder.configure(
  :lookup => :google,
  :timeout => 5,)

# # to use an API key:
# Geocoder::Configuration.api_key = "Ar9yHS5vIiJdt5tR20SqpQn6OIRwDCDCoxSlVqRmF0IILfIE-UFdM9lQRlya1YP_"
