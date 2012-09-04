<?php
?>

<div>
    <label>Fornecedor</label>
    <input id="txtFornecedor" type="text"/>
</div>

<div>
    <label>Insumo</label>
    <input id="txtInsumo" type="text"/>
</div>

<div id="lista-precos-fornecedor" style="padding:30px; color: brown">
Aqui será exibida a lista de vigências de preços para o insumo naquele fornecedor, se já existir. O usuário só poderá selecionar um registro e atualizá-lo se a vigência for superior a data atual. Vigências passadas não poderão ser alteradas e devem ser substituídas por novas vigências.
</div>

<div>
    <label>Vigência</label>
    <input id="txtDataVigencia" type="text"/>
    
    <label>Preço</label>
    <input id="txtPreco" type="text"/>
</div>

<input id="btnSalvar" type="button" value="Salvar"/>
