<?php
class Posts_Model extends Base_Model {

    private $posts;

    function __construct() {
        parent::__construct();
    }

    function get($id) {
        $result = $this->dao->fetch("SELECT * FROM posts WHERE id='" . $id . "'");
        if( $row = $this->dao->getRow($result) ) {
            $this->posts = $row;
        } else {
        throw new Exception("Post #$id not found.");
        }
        return $this->posts;
    }
    
    function get_all() {
        $result = $this->dao->fetch("SELECT * FROM posts");
        while( $row = $this->dao->getRow($result) ) {
            $this->posts[] = $row;
        }
        return $this->posts;
    }

    function insert($post) {
        $result = $this->dao->fetch("INSERT INTO posts (title, body, date_posted) VALUES ('" . $post['title'] . "', '" . $post['body'] . "', '" . date('Y-m-d H:i:s') . "')");
        if($result) {
            return mysql_insert_id();
            exit();
        }
        throw new Exception('Could not create new post.');
    }

    function update($post) {
        $result = $this->dao->fetch("UPDATE posts SET title='" . $post['title'] . "', body='" . $post['body'] . "' WHERE id='" . $post['id'] . "'");
        if(!$result) {
            throw new Exception('Update of Post #' . $post['id'] . 'failed.');
        }
    }

    function delete($id) {
        try {
            $post = $this->get($id);
            $result = $this->dao->fetch("DELETE FROM posts WHERE id='" . $id . "'");
        } catch(Exception $e) {
            throw new Exception($e->getMessage() . " Deletion of Post #$id failed.");
        }
    }

}

?>
