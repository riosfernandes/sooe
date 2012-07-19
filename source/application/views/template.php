<html>
    <head>
        <title> <?php echo $title; ?> </title>
    </head>
    <body>
        <ul class="navigation">
            <?php foreach ($nav_list as $i => $nav_item): ?>
                <li class="<?php echo ($nav == $nav_item ? 'selected' : ''); ?>">
                    <?php echo anchor($nav_item, $nav_item); ?>
                </li>
            <?php endforeach ?>
        </ul>
        <div id="contents"><?php echo($contents) ?></div>
        <div id="footer">Copyright 2012</div>
    </body>
</html>