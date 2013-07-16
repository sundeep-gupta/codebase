<?php
include dirname(__FILE__) . '/../common/header.php';
?>
        <h1>Create New Post</h1>
        <form name="create_post" action="<?php echo createURL("posts", "create"); ?>" method="POST">
            Title: <input type="text" name="title" value="" /><br/>
            Body: <input type="text" name="body" value="" />
            <input type="submit" name="submit" value="Submit" />
        </form>

<?php
include dirname(__FILE__) . '/../common/footer.php';
?>
