<?php

Class Controller_Comments {
    private $args;  // Arguments from the Router.
    private $comment;  // Model
    private $comments; // Comments ready for the View

    function __construct($args) {
        $this->args = $args;
        $this->comment = new Comments_Model($this->args[0]); // Create a new comment model with the post id ($this->args[0])
    }

    function create() {
        try {
            if(isset($_POST['submit'])) {
                $id = $this->comment->insert($_POST);
                set_status("New comment for post ID: " . $this->args[0] . " created. ID: " . $id);
                /*
                 * Uncomment the header() function and fill in the createURL function
                 * Hint:  The controller is "posts"
                 *
                 */
                //header('Location: ' . createURL("", "", ));
            } else {
                include showView();
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
        }
    }

    function delete() {
        try {
            if(isset ($this->args[1])) {
                $this->comment->delete($this->args[1]);
                set_status('Comment #' . $this->args[1] . ' deleted.');
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
        }
        header('Location: ' . createURL("posts", "view", $this->args[0]));
    }

    /*
    function index() {
        $this->comments = $this->comment->get_all();
        include showView();
    }

    function view() {
        try {
            $this->comments = $this->comment->get($this->args[1]);
            include showView();
        } catch(Exception $e) {
            set_status($e->getMessage());
            header('Location: ' . createURL("posts"));
        }
    }

    function edit() {
        try {
            if(isset($_POST['submit'])) {
                $this->comment->update($_POST);
                set_status('Post #' . $_POST['id'] . ' updated.');
                header("Location: " . createURL("posts", "view", $_POST['id']));
            } else {
                $this->comments = $this->comment->get($this->args[0]);
                include showView();
            }
        } catch(Exception $e) {
            set_status($e->getMessage());
            header("Location: " . createURL("posts"));
        }
    }

     *
     */
}
?>