function featured_thumb(maxwidth)
{	// featured thumb functionality
	if((typeof maxwidth=='undefined')||(maxwidth==null)){maxwidth=900;}
	$('.arrowright').live('click',function(){
		if ( Math.round(parseFloat($("#featured-thumb-list").css("margin-left"),10))<=-maxwidth)
		{
			$('#featured-thumb-list').stop();
			$('#featured-thumb-list').animate({
			    'margin-left': '-'+maxwidth
			  }, 500, function() {
			    // Animation complete.
			  });
		}
		else
		{
			$('#featured-thumb-list').stop();
			$('#featured-thumb-list').animate({
			    'margin-left': '-=160'
			  }, 500, function() {
			    // Animation complete.
			  });	
		}
	});
	$('.arrowleft').live('click',function(){
		if ( Math.round(parseFloat($("#featured-thumb-list").css("margin-left"),10))>=0)
		{
			$('#featured-thumb-list').stop();
			$('#featured-thumb-list').animate({
			    'margin-left': '0'
			  }, 500, function() {
			    // Animation complete.
			  });
		}
		else
		{
			$('#featured-thumb-list').stop();
			$('#featured-thumb-list').animate({
			    'margin-left': '+=160'
			  }, 500, function() {
			    // Animation complete.
			  });	
		}
	});
	// end featured thumb functionality
}

jQuery(document).ready(function($)
{
	featured_thumb(850);
});