/**
 * A jQuery-Geolocation-Plugin
 *
 * @author Thomas Michelbach <thomas@nomoresleep.net>
 * @copyright NoMoreSleep(tm) <http://developer.nomoresleep.net>
 * @version 0.1
 */
!function(o){o.extend(o.support,{geolocation:function(){return o.geolocation.support()}}),o.geolocation={find:function(t,n,c){o.geolocation.support()?(c=o.extend({highAccuracy:!1,track:!1},c),o.geolocation.object()[c.track?"watchPosition":"getCurrentPosition"](function(o){t(o.coords)},function(){n()},{enableHighAccuracy:c.highAccuracy})):n()},object:function(){return navigator.geolocation},support:function(){return o.geolocation.object()?!0:!1}}}(jQuery);