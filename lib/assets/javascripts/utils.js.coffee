window.Utils =
  # Taken from http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
  calculateDistanceInMiles: (lat1, lon1, lat2, lon2) ->
    R = 6371
    dLat = (lat2-lat1).toRad()
    dLon = (lon2-lon1).toRad() 
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
      Math.sin(dLon/2) * Math.sin(dLon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    R * c * 0.6214

# Convert an integer to radians
if typeof(Number.prototype.toRad) == "undefined"
  Number.prototype.toRad = ->
    this * Math.PI / 180
