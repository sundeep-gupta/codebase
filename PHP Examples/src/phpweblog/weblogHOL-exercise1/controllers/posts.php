<?php
class Controller_Posts{
    private $args;  // Arguments from the Router.
    private $post;  // Model
    private $posts; // Posts ready for the View

    function __construct($args) {
        $this->args = $args;
        $this->post = new Posts_Model();
    }
    
    function index() {
        echo("hello index");
    }

    
}

?>
