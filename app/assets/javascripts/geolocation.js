function getUserLocation() {
	navigator.geolocation.getCurrentPosition(setUserLocationCookie, alertNoGeolocation, {maximumAge: (900 * 1000)});

}

function setUserLocationCookie(position) {
	var cookie_value = position.coords.latitude + "," + position.coords.longitude;
	document.cookie = "detected_user_location=" + escape(cookie_value);
}

function alertNoGeolocation () {
	alert("Uh oh, we couldn't locate you!");
}