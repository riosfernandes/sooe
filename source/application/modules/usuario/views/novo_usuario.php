<?php if ($message) : ?>
    <p><?php echo $message; ?></p>
<?php endif; ?>

<div id="form">
    <div class="block">
        <div>
            <?php echo form_label('Nome', 'lblNome', 'for="nome"') ?>
        </div>
        <div>
            <?php echo form_input('nome', '', 'id="txtUsuarioNome"') ?>
        </div>
        <div>
            <?php echo form_label('Login', 'lblLogin', 'for="login"') ?>
        </div>
        <div>
            <?php echo form_input('login', '', 'id="txtUsuarioLogin"') ?>
        </div>
        <div>
            <?php echo form_label('Email', 'lblEmail', 'for="email"') ?>
        </div>
        <div>
            <?php echo form_input('email', '', 'id="txtUsuarioEmail"') ?>
        </div>
        <div>
            <?php echo form_label('Grupo de Usuário', 'lblGrupoUsuario', 'for="grupo_usuario"') ?>
        </div>
        <div>
            <?php echo form_dropdown('grupo_usuario', $grupos_usuario, '', 'id="cmbGrupoUsuario"') ?>
        </div>
        <div>
            <?php echo form_label('Tipo do Usuário', 'lblTipoUsuario', 'for="tipo_usuario"') ?>
        </div>
        <div>
            <?php echo form_dropdown('tipo_usuario', $tipos_usuario, '', 'id="cmbTipoUsuario"') ?>
        </div>
    </div>
</div>

<div>
    <?php echo form_submit('salvar', 'Salvar', 'id="btnSalvarProjeto" class="button"') ?>
</div>