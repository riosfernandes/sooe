<?php

//print_r($result);

if (isset($result)) {
    echo '<h2>Preços Existentes</h2>';
}

echo '<table>';
if (isset($result)) {
    echo '<tr>';
    echo '<th>Valor</th>';
    echo '<th>Vigência</th>';
    echo '</tr>';
    foreach ($result as $p) {
        echo '<tr id="p' . $p['insumo_id'] . '">';
        echo '<td>' . $p['valor'] . '</td>';
        echo '<td>' . $p['vigencia'] . '</td>';
        echo '</tr>';
    }
}
echo '</table>'
?>
