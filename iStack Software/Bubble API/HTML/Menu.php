<?php
require_once(BB_LIB.'/Bubble/HTML/UList.php');
class Menu extends UList {
    protected $menu_items = null;
    protected $active_menu_item = null;
    function __construct($menu_items,  $attr = null) {
	parent::__construct($attr);
	$this->menu_items       = $menu_items;

    }

    public function set_active_menu_item($active_menu_item ) {
	$this->active_menu_item = $menu_item_index;
    }
    public function get_html_text() {
	foreach($this->menu_items as $name => $url) {
	    $menu_attr = null;
	    if($name == $this->active_menu_item[0]) {
		$menu_attr - $this->active_menu_item[1];
	    }
	    $this->add_element($menu_attr, '<a href="'.$url.'">'.$name.'</a>');  
	}
	return parent::get_html_text();
    }
}

?>
