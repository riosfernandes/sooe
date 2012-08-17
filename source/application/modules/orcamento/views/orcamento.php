<div id="form">
    <div class="block">
        <div>
            <?php echo form_label('Descrição', 'lblDescricao', 'for="descricao"') ?>
        </div>
        <div>
            <?php echo form_input('descricao', '', 'id="txtDescricaoProjeto"') ?>
        </div>
        <div>
            <div>
                <?php echo form_label('Serviço', 'lblServico', 'for="servico"') ?>
            </div>
            <div class="ui-widget">
                <input id="servico" />
            </div>
        </div>
    </div>

    <div id="log-servicos" class="log">
    </div>

    <div id="projeto-servicos" class="block">
        <?php $this->load->view('list'); ?>
    </div>
</div>

<div>
    <?php echo form_submit('salvar', 'Salvar', 'id="btnSalvarProjeto" class="button"') ?>
</div>