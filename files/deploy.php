<?php
    // exec command
    $output = shell_exec('git pull origin $GIT_BRANCH');
?>

<?php echo $output; ?>
