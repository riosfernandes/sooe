<?php

 header("Content-Type: text/html; charset=ISO-8859-1",true);

//echo '<pre>';
//print_r($quadras);

if (!isset($quadras) || count($quadras) == 0) {
    echo '<p>Nenhuma quadra disponível!</p>';
} else {
    echo '<table id="quadraslivrestable">';
    echo '<tr>';
    echo '<th></th>';
    echo '<th>Id</th>';
    echo '<th>Descrição</th>';
    echo '</tr>';

    foreach ($quadras as $q) {
        echo '<tr class="tableLine" quadra="q' . $q['id'] . '">';
        echo '<td class="tableLink"><input class="add" type="button" item="item' . $q['id'] . '"></input></td>';
        echo '<td class="tableItemText" quadraId="1">' . $q['id'] . '</td>';
        echo '<td class="tableItemText" quadraDescricao="desc">' . $q['descricao'] . '</td>';
        echo '</tr>';
    }

    echo '</table>';
}
?>