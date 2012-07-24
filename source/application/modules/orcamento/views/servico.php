<div>
    <?php echo form_label('Categoria') ?>
</div>
<div>
    <?php echo form_dropdown('categoria', array(), set_value('categoria'), 'id="categoria"') ?>
</div>
<div>
    <?php echo form_label('Clã') ?>
</div>
<div>
    <?php echo form_dropdown('cla', array(), set_value('cla'), 'id="cla"') ?>
</div>
<div>
    <?php echo form_label('Família') ?>
</div>
<div>
    <?php echo form_dropdown('familia', array(), set_value('familia'), 'id="familia"') ?>
</div>
<div>
    <?php echo form_label('Servico') ?>
</div>
<div>
    <?php echo form_dropdown('servico', array(), set_value('servico'), 'id="servico"') ?>
</div>
<div>
    <?php echo form_submit('btnAdicionar', 'Adicionar', 'id="btnAdicionar"') ?>
</div>