/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var loadRecentPosts = function(url) {
  $('#recent-posts').load(url);
}

var loadRecentRestaurants = function(url) {
  $('#recent-restaurants').load(url);
}

var loadRecentComments = function(url) {
  $('#recent-comments').load(url);
}

var loadRecommendation = function(url) {
  $('#recommendation').load(url);
}

var loadPopularPosts = function(url) {
  $('#popular-posts').load(url);
}

var loadAdvertise = function(url) {
  $('#advertise ').load(url);
}

var loadPost = function(url) {
  $('#content-main').load(url);
}

var loadMapSearchResult = function(url) {
  $('#content-main').load(url);
}

var loadRestaurantMenu = function(url) {
  $('#restaurant-menu').load(url);
}

var loadRestaurantActivities = function(url) {
  $('#restaurant-activities').load(url);
}

var loadRestaurantCoupon = function(url) {
  $('#restaurant-coupon').load(url);
}
var loadRestaurantMap = function(url) {
  $('#restaurant-map').load(url);
}
var loadRestaurantAlbum = function(url) {
  $('#restaurant-album').load(url);
}

var about = function() {
  jQuery.noConflict();

	// Position modal box in the center of the page
	jQuery.fn.center = function () {
		this.css("position","absolute");
		this.css("top", ( jQuery(window).height() - this.height() ) / 2+jQuery(window).scrollTop() + "px");
		this.css("left", ( jQuery(window).width() - this.width() ) / 2+jQuery(window).scrollLeft() + "px");
		return this;
	  }

	jQuery(".modal-profile").center();


	// Set height of light out div
	jQuery('.modal-lightsout').css("height", jQuery(document).height());

	// Fade in modal box once link is clicked
	jQuery('a[rel="modal-profile"]').click(function() {
		jQuery('.modal-profile').fadeIn("slow");
		jQuery('.modal-lightsout').fadeTo("slow", .5);
	});


	// closes modal box once close link is clicked, or if the lights out divis clicked
	jQuery('a.modal-close-profile, .modal-lightsout').click(function() {
		jQuery('.modal-profile').fadeOut("slow");
		jQuery('.modal-lightsout').fadeOut("slow");
	});
}
var addToCart = function(url) {
  jQuery('.add_to_cart').click(function() {
    updateCart(url, this);
  });

  jQuery(".add_to_cart").hover(function() {
    jQuery(this).css('cursor','pointer');
  }, function() {
    jQuery(this).css('cursor','auto');
  });


};

var addCartButtons = function() {

  /* add checkout and clear cart items */
  jQuery('<div/>', {
    'id' : 'cart_checkout',
    'class' : 'cart_checkout',
    'text' : 'Checkout'
  }).appendTo('#shopping_cart');
  jQuery('<div/>', {
    'id' : 'cart_reset',
    'class' : 'cart_reset',
    'text' : 'Reset Cart'
  }).appendTo('#shopping_cart');

  jQuery(".cart_reset").hover(function() {
    jQuery(this).css('cursor','pointer');
  }, function() {
    jQuery(this).css('cursor','auto');
  });

  jQuery('.cart_reset').click(function(){
    resetCart();
  });

  jQuery(".cart_checkout").hover(function() {
    jQuery(this).css('cursor','pointer');
  }, function() {
    jQuery(this).css('cursor','auto');
  });

  jQuery('.cart_checkout').click( function() {
    checkoutCart();
  });

};


var resetCart = function() {
  var url = '/DineAvenueBeta/index.php?r=restaurant/resetCart';
  jQuery.get(url, function(data){
    refreshCart(data);
  });
};

var checkoutCart = function() {
  var url = '/DineAvenueBeta/index.php?r=restaurant/checkout';
  jQuery.get(url, function(data) {
    jQuery('#content').text(data);
  });
}

/**
 *  Sends the item data to server, and recieves the shoppingCart object to refresh the cart.
 */
var updateCart = function(url, obj) {
    var data = {};
    if (obj != null) {
      jQuery(obj).closest('.menuItemList').children().each(function(x, item) {
        var itemClass = jQuery(item).attr('class');

        if (itemClass == 'menuItemName') {
          data['id'] = jQuery(item).attr('id');
        }
        if (itemClass == 'menuItemCost') {
            data['price'] = jQuery(item).text();
        }
      });
      if (data['id'] != null) {
        data['quantity'] = 1;
      }
    }
    //var url = 'index.php?r=restaurant/addToCart';
    jQuery.post(url,data, function(data) {
      var cartObj = jQuery.parseJSON(data);
      // Now we have complete cart info in the cartObj...
      // Lets render the cart
      refreshCart(cartObj);
    });

};

/*
 * Called by updateCart() to refresh the shopping cart.
 */
var refreshCart = function(cartObj) {
  if (cartObj == null || cartObj['items'] == null || cartObj['items'].length == 0) {
    jQuery('#shopping_cart').text('Cart is Empty');
    return;
  }
  jQuery('#shopping_cart').text('');
  /*
   * add div elements to display the cart items.
   */
  jQuery('<div/>', {
    'id' : 'cart_items'
  }).appendTo('#shopping_cart');
  for(i = 0; i < cartObj['items'].length; i++) {
    var item = cartObj['items'][i];
    jQuery('<div/>', {
      'class' : 'cart_itemname',
      'text' : item['id'] // to replace with name
    }).appendTo('#cart_items');

    jQuery('<div/>', {
      'class' : 'cart_itemprice',
      'text' : item['price'] // to replace with name
    }).appendTo('#cart_items');

    jQuery('<div/>', {
      'class' : 'cart_itemquantity',
      'text' : item['quantity'] // to replace with name
    }).appendTo('#cart_items');

  }

  /* Display the summary items */
  jQuery('<div/>', {
    'id' : 'cart_total',
    'text' : 'Total : ' + cartObj['total']
  }).appendTo('#shopping_cart');

  jQuery('<div/>', {
    'id' : 'cart_discount',
    'text' : 'Discount: ' + cartObj['discount']
  }).appendTo('#shopping_cart');

  jQuery('<div/>', {
    'id' : 'cart_tax',
    'text' : 'Tax :' + cartObj['tax']
  }).appendTo('#shopping_cart');

  addCartButtons();
  //jQuery('#shopping_cart').text(cartObj['total']);
}

