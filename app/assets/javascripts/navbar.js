// var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
//   __hasProp = {}.hasOwnProperty,
//   __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } 
// function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); 
// child.__super__ = parent.prototype; return child; };

// this.ShopSavvyPage = (function() {
//   function ShopSavvyPage() {
//     this._bindEventHandlers = __bind(this._bindEventHandlers, this);
//     this._bindEventHandlers();
//   }

//   ShopSavvyPage.prototype._bindEventHandlers = function() {
//     var binding, e, eventName, functionInstance, functionName, selector, _results;
//     _results = [];
//     for (selector in this.eventHandlers()) {
//       try {
//         binding = this.eventHandlers()[selector];
//         eventName = binding.split("#")[0];
//         functionName = binding.split("#")[1];
//         functionInstance = this[functionName];
//         console.log("Successfully bound the '" + eventName + "' event of '" + selector + "' to the '" + functionName + "' function.");
//         _results.push($("body").on(eventName, selector, functionInstance));
//       } catch (_error) {
//         e = _error;
//         _results.push(console.log("Failed to bind event handler: " + e));
//       }
//     }
//     return _results;
//   };

//   ShopSavvyPage.prototype.eventHandlers = function() {
//     throw new Error("Subclasses should implement the eventHandlers function!");
//   };

//   return ShopSavvyPage;

// })();

// this.ProductPage = (function(_super) {
//   __extends(ProductPage, _super);

//   function ProductPage() {
//     ProductPage.__super__.constructor.call(this);
//   }

//   ProductPage.prototype.eventHandlers = function() {
//     return {
//       ".button.like.liked": "click#unlikeProduct"
//     };
//   };

//   return ProductPage;

// })(this.ShopSavvyPage);







// function CustomModule () {
// 	this._bindEventHandlers()
// }

// CustomModule.prototype._bindEventHandlers = function () {
// 	var b, e, fI, fN;
// 	console.log(this.events)
// 	for (s in this.events) {
// 	  try {
// 	    b = this.events()[s];
// 	    e = binding.split("#")[0];
// 	    f = this[binding.split("#")[1]];

// 	    $("body").on(e, s, f);
// 	    console.log("Successfully bound the '" + e + "' event of '" + s + "' to the '" + f + "' function.");
// 	  } catch (_error) {}
// 	}
// };

// CrowdscoreHeader.prototype = new CustomModule();
// CrowdscoreHeader.prototype.constructor = CrowdscoreHeader;

// function CrowdscoreHeader () {
// 	this.events = {		
// 		'.cs-h-search-trigger' : 'click#toggleHeaderState',
// 		'.cs-h-search-img' : 'click#toggleHeaderState'}
// }

// CrowdscoreHeader.prototype.events = function () {
// 	return {
// 		'.cs-h-search-trigger' : 'click#toggleHeaderState',
// 		'.cs-h-search-img' : 'click#toggleHeaderState'
// 	}
// }



// CrowdscoreHeader.prototype.toggleHeaderState = function () {
// 	alert('')
// }

$(document).ready(function () {	
	$('.cs-h-search-trigger').click(function (e) {
		// $('.cs-h-inner').toggleClass('cs-h-push');

    if ($('.cs-h-inner').hasClass('cs-h-push')) {
      $('.cs-h-inner').removeClass('cs-h-push');
    } else {
      $('.cs-h-inner').addClass('cs-h-push');
    }

    $('.cs-h').click(function (e) {
      e.stopPropagation()
    });

		e.stopPropagation();
	});

  $('#cs-h-search-input').focus(function (e) {
    console.log(e)
  });

	$('body').click(function (e) {
    // if ($('#cs-h-search-input').is(':focus')) {
    //   return;
    // }
		if ($('.cs-h-inner').hasClass('cs-h-push')) {
			$('.cs-h-inner').removeClass('cs-h-push');
		}
	});

	// var navbar = new CrowdscoreHeader();
});