<?php

header("Content-Type: text/html; charset=ISO-8859-1", true);

echo '<option value="-1">--- Selecione ---</option>';
foreach ($tipos_quadra as $t) {
    echo '<option value="' . $t['id'] . '">' . $t['descricao'] . '</option>';
}

?>
