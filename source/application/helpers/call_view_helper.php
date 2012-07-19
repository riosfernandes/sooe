<?php

function call_view($CI, $titulo, $contents) {
    $CI->template->set('titulo', $titulo);
    $CI->template->load('template_teste', 'crudpage', $contents);
}

?>
