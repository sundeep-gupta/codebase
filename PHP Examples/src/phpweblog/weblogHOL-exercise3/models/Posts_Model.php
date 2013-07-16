<?php
class Posts_Model extends Base_Model {

    private $posts;
    private $comments;

    function __construct() {
        parent::__construct();
    }

    function get($id) {
        $comments = array('comments' => array(0=>'comment 1', 1=>'comment 2'));
        $result = $this->dao->fetch("SELECT * FROM posts WHERE id='" . $id . "'");
        if( $row = $this->dao->getRow($result) ) {
            $this->posts = $row;

            $this->comments = new Comments_Model($id);
            $comments = $this->comments->get_all();

            $this->posts = array_merge($row, array('comments' => $comments));
            
        } else {
            throw new Exception("Post #$id not found.");
        }
        return $this->posts;
    }

    function get_all() {
        //$comments = array('comments' => array(0=>'comment 1', 1=>'comment 2'));

        $result = $this->dao->fetch("SELECT * FROM posts");
        while( $row = $this->dao->getRow($result) ) {
            //$this->posts[] = array_merge($row, $comments);
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
