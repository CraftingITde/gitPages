<?php
    /**
     * GIT DEPLOYMENT SCRIPT
     *
     * Used for automatically deploying websites via git
     *
     */
    // exec command
    $output = shell_exec('git pull origin $GIT_BRANCH');
?>

<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <title>GIT DEPLOYMENT SCRIPT</title>
</head>
    <body>
        <div>
            <?php echo $output; ?>
        </div>
    </body>
</html>
