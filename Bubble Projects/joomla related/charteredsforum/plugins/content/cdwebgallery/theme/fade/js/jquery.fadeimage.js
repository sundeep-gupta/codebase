/*
 * Fade image
 */

(function($){
	$.fn.fadeimage = function(o) {
		var defaults = {
				color: '#fff',
				dimming: 0.45,
				parent: 'li',
				children: 'img'
		};
		var settings = $.extend(defaults, o);
		
		$(this).parent(settings.parent).css('background-color', settings.color);
		$(this).children(settings.children).css('opacity', settings.dimming).hover(function () {
			$(this).stop().fadeTo(300, 1);
		}, function () {
			$(this).stop().fadeTo(300, settings.dimming);
		});
		
	};
})(jQuery);