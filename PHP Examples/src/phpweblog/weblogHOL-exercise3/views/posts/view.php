<?php
include dirname(__FILE__) . '/../common/header.php';
?>
            <h1><?php echo($this->posts['title']); ?></h1>
            <h3><?php echo($this->posts['date_posted']); ?></h3>
            <h2><?php echo($this->posts['body']); ?></h2>
            <?php
            if( isset($this->posts['comments']) ) {
                echo '<ul>';
                foreach ($this->posts['comments'] as $comment) {
                    echo('<li>' . $comment['body'] . ' <a href="' . createURL("comments", "delete", $this->posts['id'], $comment['id']) . '">delete</a></li>');
                }
                echo '</ul>';
            }
            ?>
            <a href="<?php echo createURL("posts", "edit", $this->posts['id']); ?>">Edit</a>
            <a href="<?php echo createURL("posts", "delete", $this->posts['id']); ?>">Delete</a>
            <a href="<?php echo createURL("comments", "create", $this->posts['id']); ?>">Add Comment</a>
            <a href="<?php echo createURL("posts"); ?>">Posts Index</a>

<?php
include dirname(__FILE__) . '/../common/footer.php';
?>