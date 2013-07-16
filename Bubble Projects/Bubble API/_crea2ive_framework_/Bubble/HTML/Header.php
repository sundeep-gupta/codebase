<?

require_once(BB_LIB.'/Bubble/HTML/Menu.php');

class Header extends Div{
    protected $top = null;
    protected $menu = null;

    protected $header_attr;

    function __construct($attr = array ()) {
	parent::__construct( $attr);
    }

    function set_logo($logo = '' ) {
	$this->logo = $logo;
	$this->add_data($this->logo);
    }
    function set_menu($menu) {
	$this->menu = $menu;
	$this->add_data($this->menu);
    } 
}


?>