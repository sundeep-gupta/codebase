<?php
include dirname(__FILE__) . '/../common/header.php';
?>
            <h1>Create New Comment for Post #<?php echo $this->comment->get_post_id(); ?></h1>
            <form name="create_comment" action="<?php echo createURL("comments", "create", $this->comment->get_post_id()); ?>" method="POST">
                Comment: <input type="text" name="body" value="" />
                <input type="hidden" name="post_id" value="<?php echo $this->comment->get_post_id(); ?>" />
                <input type="submit" name="submit" value="Submit" />
            </form>
<?php
include dirname(__FILE__) . '/../common/footer.php';
?>
