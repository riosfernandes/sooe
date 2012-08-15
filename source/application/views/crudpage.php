<head>
    <?php
    
    /* imprimir o css do crud */
    if (isset($css_files)) {
        foreach ($css_files as $cs_crud) {
            echo link_tag($cs_crud);
        }
    }
    /* imprimir o js do crud */
    if (isset($js_files)) {
        foreach ($js_files as $js_crud) {
            echo script_tag($js_crud);
        }
    }
    ?>
</head>

<div>
    <?php
    /* imprime o conteúdo do crud (view) */
    echo $output;
    ?>
</div>
