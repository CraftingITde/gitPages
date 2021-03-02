<?php
    // exec command
    $output = shell_exec('git fetch --all && git reset --hard origin/$GIT_BRANCH && git pull origin $GIT_BRANCH');
?>

<?php echo $output; ?>
