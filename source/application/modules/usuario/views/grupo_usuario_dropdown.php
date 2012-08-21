<?php

//echo '<option value="-1">--- Selecione ---</option>';
if (isset($grupos_usuario)) {
    foreach ($grupos_usuario as $g) {
        echo '<option value="' . $g['id'] . '">' . $g['descricao'] . '</option>';
    }
}
?>
