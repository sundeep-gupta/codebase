<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->


<?php
include dirname(__FILE__) . '/../common/header.php';

foreach ($this->posts as $post) {
?>
    <h1><a href="<?php echo createURL("posts", "view", $post['id']); ?>"><?php echo($post['title']); ?></a></h1>
    <h3><?php echo($post['date_posted']); ?></h3>
    <h2><?php echo($post['body']); ?></h2>
    <hr>
<?php
}
?>
<a href="<?php echo createURL("posts", "create"); ?>">Create New Post</a>

<?php
include dirname(__FILE__) . '/../common/footer.php';
?>