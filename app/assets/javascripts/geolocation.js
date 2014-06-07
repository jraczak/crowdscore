function getUserLocation() {
	navigator.geolocation.getCurrentPosition(setUserLocationCookie, alertNoGeolocation, {maximumAge: (900 * 1000)});

}

function setUserLocationCookie(position) {
	var cookie_value = position.coords.latitude + "," + position.coords.longitude;
	var d = new Date();
	d.setTime(d.getTime() + (15*60*1000)); // 15 minutes to milliseconds
	var expires = "expires=" + d.toGMTString();
	document.cookie = "detected_user_location=" + escape(cookie_value) + "; " + expires;
	
	console.log(cookie_value);
	
	$.ajax({
	  type: "GET",
	  url: "/dashboard",
	  dataType: "script"
	});
}

function alertNoGeolocation () {
	alert("Uh oh, we couldn't locate you!");
}