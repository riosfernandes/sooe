<?php
if (isset($result)) {
    echo '<h2>Preços Existentes</h2>';
} else {
    echo '<p>Ainda não há nenhum insumo associado ao fornecedor informado.</p>';
}

echo '<table id="precos">';
if (isset($result)) {
    echo '<tr>';
    echo '<th>Insumo</th>';
    echo '<th>Unidade</th>';
    echo '<th>Valor</th>';
    echo '<th>Vigência</th>';
    echo '</tr>';
    foreach ($result as $p) {
        echo '<tr id="p' . $p['insumo']['id'] . '">';
        echo '<td>' . $p['insumo']['descricao'] . '</td>';
        echo '<td>' . $p['insumo']['tipo_unidade']['sigla'] . '</td>';
        echo '<td>' . $p['valor'] . '</td>';
        echo '<td>' . $p['vigencia'] . '</td>';
        echo '</tr>';
    }
}
echo '</table>'
?>
