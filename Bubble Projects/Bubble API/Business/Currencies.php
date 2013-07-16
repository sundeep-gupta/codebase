<?php
/*
  $Id: currencies.php,v 1.16 2003/06/05 23:16:46 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/

/*
 * Class to handle currencies
 * TABLES: currencies
 */
class Currencies {
    public $currencies;

    # class constructor
    function __construct($dbConn) {
	$this->currencies = array();
	$dbConn->add_query('BB_CURRENCY_ALL',
			 "select code, title, symbol_left, symbol_right, decimal_point, thousands_point, decimal_places, value ".
			 "from " . TABLE_CURRENCIES);
	$currencies_query = $dbConn->execute('BB_CURRENCY_ALL',null);
	while ($currencies = $currencies_query->fetchRow(DB_FETCHMODE_ASSOC)) {
	    $this->currencies[$currencies['code']] = array('title' => $currencies['title'],
                                                       'symbol_left' => $currencies['symbol_left'],
                                                       'symbol_right' => $currencies['symbol_right'],
                                                       'decimal_point' => $currencies['decimal_point'],
                                                       'thousands_point' => $currencies['thousands_point'],
                                                       'decimal_places' => $currencies['decimal_places'],
                                                       'value' => $currencies['value']);
	}
    }

// class methods
    function format($number, $calculate_currency_value = true, $currency_type = '', $currency_value = '') {
#	global $currency;
#
#	if (empty($currency_type)) 
#	    $currency_type = $currency;
	if (empty($currency_type))
	    $currency_type = LANGUAGE_CURRENCY;
	if ($calculate_currency_value == true) {
	    $rate          = (tep_not_null($currency_value)) ? $currency_value : $this->currencies[$currency_type]['value'];
	    $format_string = $this->currencies[$currency_type]['symbol_left'] .
		             number_format(tep_round($number * $rate, 
						     $this->currencies[$currency_type]['decimal_places']), 
					   $this->currencies[$currency_type]['decimal_places'], 
					   $this->currencies[$currency_type]['decimal_point'], 
					   $this->currencies[$currency_type]['thousands_point']) . 
		             $this->currencies[$currency_type]['symbol_right'];
// if the selected currency is in the european euro-conversion and the default currency is euro,
// the currency will displayed in the national currency and euro currency
	    if ( (DEFAULT_CURRENCY == 'EUR') && 
		 ($currency_type == 'DEM' || $currency_type == 'BEF' || $currency_type == 'LUF' || 
		  $currency_type == 'ESP' || $currency_type == 'FRF' || $currency_type == 'IEP' || 
		  $currency_type == 'ITL' || $currency_type == 'NLG' || $currency_type == 'ATS' || 
		  $currency_type == 'PTE' || $currency_type == 'FIM' || $currency_type == 'GRD') ) {
		$format_string .= ' <small>[' . $this->format($number, true, 'EUR') . ']</small>';
	    }
	} else {
	    $format_string = $this->currencies[$currency_type]['symbol_left'] .
		             number_format(tep_round($number, 
						     $this->currencies[$currency_type]['decimal_places']), 
					   $this->currencies[$currency_type]['decimal_places'],
					   $this->currencies[$currency_type]['decimal_point'], 
					   $this->currencies[$currency_type]['thousands_point']) .
		            $this->currencies[$currency_type]['symbol_right'];
      }
      return $format_string;
    }

    function is_set($code) {
	if (isset($this->currencies[$code]) && tep_not_null($this->currencies[$code])) {
	    return true;
	} 
	return false;
    }

    function get_value($code) {
	return $this->currencies[$code]['value'];
    }

    function get_decimal_places($code) {
	return $this->currencies[$code]['decimal_places'];
    }

    function display_price($products_price, $products_tax, $quantity = 1) {
	$tax = $this->add_tax($prod_price,$product_tax);
	return $this->format($tax * $quantity);
    }
    // this func is availabe in general.php also (with diff name)
    function add_tax($price, $tax) {       
	if ( (DISPLAY_PRICE_WITH_TAX == 'true') && ($tax > 0) ) {
	    return tep_round($price, $this->currencies[DEFAULT_CURRENCY]['decimal_places']) + tep_calculate_tax($price, $tax);
	} else {
	    return tep_round($price, $this->currencies[DEFAULT_CURRENCY]['decimal_places']);
	}
    }
// Wrapper function for round()
    function tep_round($number, $precision) {

	if (strpos($number, '.') && (strlen(substr($number, strpos($number, '.')+1)) > $precision)) {
	    $number = substr($number, 0, strpos($number, '.') + 1 + $precision + 1);
	    
	    if (substr($number, -1) >= 5) {
		if ($precision > 1) {
		    $number = substr($number, 0, -1) + ('0.' . str_repeat(0, $precision-1) . '1');
		} elseif ($precision == 1) {
		    $number = substr($number, 0, -1) + 0.1;
		} else {
		    $number = substr($number, 0, -1) + 1;
		}
	    } else {
		$number = substr($number, 0, -1);
	    }
	}
	return $number;
    }
}
?>
