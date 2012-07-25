<h1>Novo Projeto</h1>
<div class="block">
    <div>
        <?php echo form_label('Descrição') ?>
    </div>
    <div>
        <?php echo form_input('descricao', '', 'id="txtDescricao"') ?>
    </div>
</div>

<div class="block">

    <div class="ui-widget">
        <div>
            <?php echo form_label('Serviço', 'lblServico', 'for="city"') ?>
        </div>
        <div>
            <input id="city" />
        </div>
    </div>
</div>

<div id="log-servicos" class="log">
</div>

<div id="projeto-servicos">
    <?php $this->load->view('list'); ?>
</div>

<div>
    <?php echo form_submit('salvar', 'Salvar', 'id="btnSalvar" class="button"') ?>
</div>