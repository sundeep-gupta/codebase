<?php

Class Controller_Posts {
    private $args;  // Arguments from the Router.
    private $post;  // Model
    private $posts; // Posts ready for the View

    function __construct($args) {
        $this->args = $args;
        $this->post = new Posts_Model();
    }

    function index() {
        $this->posts = $this->post->get_all();
        include showView();
    }

    function view() {
        try {
            $this->posts = $this->post->get($this->args[0]);
            include showView();
        } catch(Exception $e) {
            set_status($e->getMessage());
            header('Location: ' . createURL("posts"));
        }
    }

    function create() {
        try {
            if(isset($_POST['submit'])) {
                $id = $this->post->insert($_POST);
                set_status("New post created. ID: " . $id);
                header('Location: ' . createURL("posts", "view", $id));
            } else {
                include showView();
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
        }
    }

    function edit() {
        try {
            if(isset($_POST['submit'])) {
                $this->post->update($_POST);
                set_status('Post #' . $_POST['id'] . ' updated.');
                header("Location: " . createURL("posts", "view", $_POST['id']));
            } else {
                $this->posts = $this->post->get($this->args[0]);
                include showView();
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
            header("Location: " . createURL("posts"));
        }
    }

    function delete() {
        try {
            if(isset ($this->args[0])) {
                $this->post->delete($this->args[0]);
                set_status('Post #' . $this->args[0] . ' deleted.');
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
        }
        header('Location: ' . createURL("posts"));
    }
}
?>