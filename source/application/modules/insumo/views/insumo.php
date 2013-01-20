<div id="form">
    <div class="block">
        <div id="div_forncedor" class="ui-widget">
            <label for="fornecedor">Fornecedor</label>
            <input id="fornecedor" />
        </div>
        <div id="div_insumo" class="ui-widget">
            <label for="insumo">Insumo</label>
            <input id="insumo" />
        </div>
    </div>
</div>

<div id="form_preco">
    <div class="box">
        <div>
            <?php echo form_label('Preço'); ?>
            <?php echo form_input('preco', 0.00, 'id="txt_preco_insumo"'); ?>
        </div>
        <div>
            <?php echo form_label('Vigência'); ?>
            <?php echo form_input('vigencia', date('d/m/Y'), 'id="txt_data_vigencia"'); ?>
        </div>
        <?php echo form_button('incluir_preco', 'Incluir', 'id="btn_incluir_preco" class="button"'); ?>
    </div>
</div>

<div id="resultado">
</div>