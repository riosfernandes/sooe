<?php if ($message) : ?>
    <p><?php echo $message; ?></p>
<?php endif; ?>

<div id="form">
    <div class="block">
        <div>
            <?php echo form_label('Nome', 'lblNome') ?>
            <?php echo form_input('nome', '', 'id="txtUsuarioNome"') ?>
        </div>
        <div>
            <?php echo form_label('Login', 'lblLogin') ?>
            <?php echo form_input('login', '', 'id="txtUsuarioLogin"') ?>
        </div>
        <div>
            <?php echo form_label('Email', 'lblEmail') ?>
            <?php echo form_input('email', '', 'id="txtUsuarioEmail"') ?>
        </div>
        <div>
            <?php echo form_label('Grupo de Usuário', 'lblGrupoUsuario') ?>
            <?php echo form_dropdown('grupo_usuario', $grupos_usuario, set_value('grupo_usuario'), 'id="cmbGrupoUsuario"') ?>
        </div>
        <div>
            <?php echo form_label('Tipo do Usuário', 'lblTipoUsuario') ?>
            <?php echo form_dropdown('tipo_usuario', $tipos_usuario, set_value('tipo_usuario'), 'id="cmbTipoUsuario"') ?>
        </div>
    </div>
</div>

<div>    
    <?php echo form_submit('limpar', 'Limpar', 'id="btnLimpar" class="button"') ?>
    <?php echo form_submit('salvar', 'Salvar', 'id="btnSalvar" class="button"') ?>
</div>