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
            <div id="hyper_header"><?php $this->load->view('hyper_header') ?></div>
            <div id="header"><?php $this->load->view('header') ?></div>
            <div id="side_bar"><?php $this->load->view('side_bar') ?></div>
            <div id="contents">
                <?php
                if (isset($subtitle))
                    echo '<h1>' . $subtitle . '</h1>';
                echo($contents)
                ?>
            </div>
            <div id="footer"><?php $this->load->view('footer') ?></div>

            <?php
//            echo 'Lista de metodos:</br><pre>';
//            var_dump(debug_backtrace());
//            exit;
            ?>
        </div>
    </body>
</html>