<?php
class Header extends Div{

    function __construct($header_attr = null, $html_attr = null) {

	         parent::__construct( $html_attr);

             $topmenubar = new Div(array('id'=>'topmenubar'));
             $topmenubarmenu = new Div(array('id' => 'topmenubarmenu'));
             $topmenubarmenu->add_data('<p class="topmenu"> <a href="#">About</a> | <a href="#">Contact</a> | <img src="images/phone7.png"><strong><i>0000000000 </i></strong</p>');
             $topmenubar->add_data($topmenubarmenu);
             $this->add_data($topmenubar);
             $this->add_data(new Div(array('id'=>'titlebar')));

             $mainmenu = new Div(array('id'=>'mainmenu'));
             $mainmenu->add_data('<script type="text/javascript" language="JavaScript1.2" src="dhtml/sc.js"></script>');
             $this->add_data($mainmenu);
             
             $pictureslide = new Div(array('id'=>'pictureslide'));
             $pictureslide->add_data('<img src="images/tempimage.png">');
             $this->add_data($pictureslide);                             
    }
}
?>