<?php

header("Content-Type: text/html; charset=ISO-8859-1", true);

echo '<option value="-1">--- Selecione ---</option>';
foreach ($clientes as $c) {
    echo '<option value="' . $c['id'] . '">' . $c['nome'] . '</option>';
}

?>
