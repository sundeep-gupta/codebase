<?php
class Header extends Div{
    protected $menu_items = array (
	'Home'         => 'index.php',
	'Products'     => 'controller.php?action=Products',
	'Articles'     => 'controller.php?action=Articles',
	'Training'     => 'controller.php?action=Training',
	'My Space'     => 'controller.php?action=MySpace',
	'News'         => 'controller.php?action=News',
	'Forum'        => 'controller.php?action=Forum',
	'About Us'     => 'controller.php?action=AboutUs',
	);
    protected $header_attr;

    function __construct($header_attr = null, $html_attr = array ('id' =>'ddtab3','class'=>'solidblockmenu')) {
	parent::__construct( $html_attr);
	$this->header_attr = $header_attr;

	$data = '<a href="index.php"><img border="0" src="images/title4.jpg" width="800" height="114"></a>';
	$this->add_data($data);
	$menu = new UList();
	foreach ($this->menu_items as $name=>$url) {
	    $menu_attr = null;
	    if (is_array($this->header_attr) and $this->header_attr['active_menu'] == $name) {
		      $menu_attr = array('id' => 'current');
	    }
	    $menu->add_element($menu_attr, '<a href="'.$url.'"><span>'.$name.'</span></a>');
	}
	$this->add_data($menu);
    }
}
?>