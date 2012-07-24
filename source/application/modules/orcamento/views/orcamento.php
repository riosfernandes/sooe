<h1>Novo Projeto</h1>
<div>
    <?php echo form_label('Descrição') ?>
</div>
<div>
    <?php echo form_input('descricao', '', 'id="txtDescricao"') ?>
</div>


<div class="demo">

    <div class="ui-widget">
        <label for="city">Your city: </label>
        <input id="city" />
    </div>

    <div class="ui-widget" style="margin-top:2em; font-family:Arial">
        Result:
        <div id="log" style="height: 200px; width: 300px; overflow: auto;" class="ui-widget-content"></div>
    </div>

</div><!-- End demo -->


<div id="projeto-servicos">
    <?php $this->load->view('list'); ?>
</div>
<div>
    <?php echo form_submit('salvar', 'Salvar', 'id="btnSalvar"') ?>
</div>