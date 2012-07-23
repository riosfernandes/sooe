<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <?php
        echo '<title>' . $titulo . '</title>';

        // <editor-fold defaultstate="collapsed" desc="<<:: CSS ::>>">
        if (!isset($css_files))
            $css_files = array();


        if (isset($styles))
            $css_files = array_merge($css_files, array_diff($styles, $css_files));


        if (isset($css_files_aditional))
            $css_files = array_merge($css_files, array_diff($css_files_aditional, $css_files));

        if (isset($css_files)) {
            foreach ($css_files as $cs_crud) {
                echo link_tag($cs_crud);
            }
        }// </editor-fold>
        // <editor-fold defaultstate="collapsed" desc="<<:: JS ::>>">
        if (!isset($js_files)) {
            $js_files = array();

            $js = JSPATH . 'jquery-1.7.2.js';
            $js_files[sha1($js)] = $js;
        }

        if (isset($js_files_jquery))
            $js_files = array_merge($js_files, array_diff($js_files_jquery, $js_files));


        if (isset($js_files_aditional))
            $js_files = array_merge($js_files, array_diff($js_files_aditional, $js_files));

        if (isset($js_files)) {
            foreach ($js_files as $js_crud) {
                echo script_tag($js_crud);
            }
        }// </editor-fold>
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