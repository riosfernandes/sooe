<?php

//echo '<option value="-1">--- Selecione ---</option>';
if (isset($tipos_usuario)) {
    foreach ($tipos_usuario as $g) {
        echo '<option value="' . $g['id'] . '">' . $g['descricao'] . '</option>';
    }
}
?>
