<?php

header("Content-Type: text/html; charset=ISO-8859-1", true);

echo '<option value="-1">--- Selecione ---</option>';
foreach ($horarios as $h) {
    echo '<option value="' . $h . '">' . $h . '</option>';
}

?>
