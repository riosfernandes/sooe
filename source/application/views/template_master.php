<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <?php
        echo '<title>' . $titulo . '</title>';

        if (isset($css_files)) {
            foreach ($css_files as $cs_crud) {
                echo link_tag($cs_crud);
            }
        }

        if (isset($js_files)) {
            foreach ($js_files as $js_crud) {
                echo script_tag($js_crud);
            }
        }
        ?>
    </head>
    <body>
        <div id="page">
            <div id="hyper_header"><?php include_once('hyper_header.php') ?></div>
            <div id="header"><?php include_once('header.php') ?></div>
            <div id="navigator"><?php include_once('navigator.php') ?></div>
            <div id="contents">
<?php
if (isset($subtitle))
    echo '<h1>' . $subtitle . '</h1>';
echo($contents)
?>
            </div>
            <div id="footer"><?php include_once('footer.php') ?></div>
        </div>        
    </body>
</html>