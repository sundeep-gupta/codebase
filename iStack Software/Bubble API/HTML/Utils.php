<?php
/*
 * Utility functions of HTML related...
 * Currently built on OSCommerce... but have to generalize them...
 */
require ('lib/Bubble/Utils.php');

class HTMLUtils {
    /*
     * Given paramters (i.e., attributes, and body), it constructs <a></a> tag and returns string.
     * This function currently is more inclined towards the Bubble Business template... We've to generalize it.
     */
    public static function href_link($attr,$attr2, $body) {
	if(Utils::is_null($attr) or Utils::is_null($attr['href'])) {
            # You may want to throw exception here
	    return '';
	}

	$page               = $attr['href'];
	$parameters         = (Utils::is_null($attr['params']))             ? ''      : $attr['params'];
	$connection         = (Utils::is_null($attr['connection']))         ? 'NOSSL' : $attr['connection'];
	$add_session_id     = (Utils::is_null($attr['add_session_id']))     ? true    : $attr['add_session_id'];
	$search_engine_safe = (Utils::is_null($attr['search_engine_safe'])) ? true    : $attr['search_engine_safe'];
	$request_tpe        = Globals::get('request_type');
	$SID                = Globals::get('SID');

#    global $request_type, $session_started, $SID;

	if ($connection == 'NONSSL') {
	    $link = HTTP_SERVER . DIR_WS_HTTP_CATALOG;
	} elseif ($connection == 'SSL') {
	    if (ENABLE_SSL == true) {
		$link = HTTPS_SERVER . DIR_WS_HTTPS_CATALOG;
	    } else {
		$link = HTTP_SERVER . DIR_WS_HTTP_CATALOG;
	    }
	}

	if (! Utils::is_null($parameters)) {
	    $link     .= $page . '?' . Utils::translate_quote($parameters);
	    $separator = '&';
	} else {
	    $link     .= $page;
	    $separator = '?';
	}

        # if $link as & or ?

	while ( substr($link, -1) == '&' || substr($link, -1) == '?' )
	    $link = substr($link, 0, -1);

// Add the session ID when moving from different HTTP and HTTPS servers, or when SID is defined

	if ( Session::is_started() and $add_session_id == true and  SESSION_FORCE_COOKIE_USE == 'False' ) {
	    if (! Utils::is_null($SID)) {
		$_sid = $SID;
	    } elseif ( ($request_type == 'NONSSL' && $connection == 'SSL' && ENABLE_SSL == true ) ||
		       ( $request_type == 'SSL'   && $connection == 'NONSSL' )) {
		if (HTTP_COOKIE_DOMAIN != HTTPS_COOKIE_DOMAIN) {
		    $_sid = Session::name() . '=' . Session::id();
		}
	    }
	}

        # Need not bother about it coz the SEARCH_ENGINE_FRIENDLY_URL is false... :-)

	if ( SEARCH_ENGINE_FRIENDLY_URLS == 'true' && $search_engine_safe == true ) {
	    while (strstr($link, '&&'))
                $link = str_replace('&&', '&', $link);

	    $link = str_replace('?', '/', $link);
	    $link = str_replace('&', '/', $link);
	    $link = str_replace('=', '/', $link);

	    $separator = '?';
	}

	if (isset($_sid)) {
	    $link .= $separator . $_sid;
	}

        $a = '<a href="'.$link.'" ' ;
        if (! Utils::is_null($attr2) ) {
	    foreach ($attr2 as $key=>$value) {
		$a .= "$key='$value' ";
	    }
	}
        $a .= ">$body</a>";
        return $a;
    }

    /*
     * Accepts the parameters and constructs the <img/> tag. Returns the same.
     */
    public static function image($src, $alt = '', $width = '', $height = '', $parameters = '', $calculate_image_size = 'true',
				     $image_required = 'true') {
	if ( empty($src) or ! file_exists($src) ) {
	    return false;
	}

	# alt is added to the img tag even if it is null to prevent browsers from outputting
	# the image filename as default
	$image = '<img src="' . Utils::translate_quotes($src) . '" border="0" alt="' . Utils::translate_quote($alt) . '"';

	if (! Utils::is_null($alt)) {
	    $image .= ' title=" ' . Utils::translate_quote($alt) . ' "';
	}

	if ( $calculate_image_size == 'true' && (empty($width) || empty($height)) ) {
	    if ($image_size = @getimagesize($src)) {
		if (empty($width) && ! Utils::is_null($height)) {
		    $ratio = $height / $image_size[1];
		    $width = $image_size[0] * $ratio;
		} elseif (! Utils::is_null($width) && empty($height)) {
		    $ratio  = $width / $image_size[0];
		    $height = $image_size[1] * $ratio;
		} elseif (empty($width) && empty($height)) {
		    $width  = $image_size[0];
		    $height = $image_size[1];
		}
	    }
	}

	if (! Utils::is_null($width) && ! Utils::is_null($height)) {
	    $image .= ' width="' . Utils::translate_quote($width) . '" height="' . Utils::translate_quote($height) . '"';
	}

	if (! Utils::is_null($parameters))
	    $image .= ' ' . $parameters;

	$image .= '>';

	return $image;
    }

/*
 * Construct the input element of type iamge and return the equivalent <input> tag.
 */
    function input_image($image, $alt = '', $parameters = '') {
	$language     = Globals::get('language');
	$image_submit = '<input type="image" src="' . Utils::translate_quote(DIR_WS_LANGUAGES . $language . '/images/buttons/' . $image) .
	                '" border="0" alt="' . Utils::translate_quote($alt) . '"';

	if (! Utils::is_null($alt))
	    $image_submit .= ' title=" ' . Utils::translate_quote($alt) . ' "';

	if (! Utils::is_null($parameters))
	    $image_submit .= ' ' . $parameters;

	$image_submit .= '>';
	return $image_submit;
    }

    /*
     * Wrapper over the basic <ing> tag function. Accepts the image name and constructs the path of the image automatically.
     */
    function image_button($image, $alt = '', $parameters = '') {
	$language = Globals::get('language');

	return image(DIR_WS_LANGUAGES . $language . '/images/buttons/' . $image, $alt, '', '', $parameters);
    }

    /*
     * Wrapper over image(), to default the location of the image, used as separator.
     */
    function image_separator($image = 'pixel_black.gif', $width = '100%', $height = '1') {
	return image(DIR_WS_IMAGES . $image, '', $width, $height);
    }


    /*
     * Output a form input field
     */
    function input_field($name, $value = '', $parameters = '', $type = 'text', $reinsert_value = true) {
	$field = '<input type="' . Utils::translate_quote($type) . '" name="' . Utils::translate_quote($name) . '"';
	$g_name = Globals::get($name);

	if ( isset($g_name) && $reinsert_value == true ) {
	    $field .= ' value="' . Utils::translate_quote(stripslashes($g_name)) . '"';
	} elseif (! Utils::is_null($value)) {
	    $field .= ' value="' . Utils::translate_quote($value) . '"';
	}

	if (! Utils::is_null($parameters))
	    $field .= ' ' . $parameters;

	$field .= '>';
	return $field;
    }



}

?>