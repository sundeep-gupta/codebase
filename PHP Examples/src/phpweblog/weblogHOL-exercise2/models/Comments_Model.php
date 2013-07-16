<?php
class Comments_Model extends Base_Model {

    private $comments;
    private $post_id;

    function __construct($post_id) {
        parent::__construct();
        $this->post_id = $post_id;
    }

    function get_post_id() {
        return $this->post_id;
    }
    
    function get($id) {
        $result = $this->dao->fetch("SELECT * FROM comments WHERE post_id='" . $this->post_id . "' AND id='" . $id . "'");
        if( $row = $this->dao->getRow($result) ) {
            $this->comments = $row;
        } else {
            throw new Exception("Post #$id not found.");
        }
        return $this->comments;
    }

    function get_all() {
        $result = $this->dao->fetch("SELECT * FROM comments WHERE post_id = '" . $this->post_id . "'");
        while( $row = $this->dao->getRow($result) ) {
            $this->comments[] = $row;
        }
        return $this->comments;
    }

    function insert($comment) {
        $result = $this->dao->fetch("INSERT INTO comments (post_id, body, date_posted) VALUES ('" . $comment['post_id'] . "', '" . $comment['body'] . "', '" . date('Y-m-d H:i:s') . "')");
        if($result) {
            return mysql_insert_id();
            exit();
        }
        throw new Exception('Could not create new post.');
    }

    function update($comment) {
        $result = $this->dao->fetch("UPDATE comments SET body='" . $comment['body'] . "' WHERE id='" . $comment['id'] . "'");
        if(!$result) {
            throw new Exception('Update of Post #' . $comment['id'] . 'failed.');
        }
    }

    function delete($id) {
        try {
            //$comment = $this->get($id);
            $result = $this->dao->fetch("DELETE FROM comments WHERE id='" . $id . "'");
        } catch(Exception $e) {
            throw new Exception($e->getMessage() . " Deletion of Post #$id failed.");
        }
    }

}

?>
