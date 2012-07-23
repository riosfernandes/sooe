<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>        
        <?php
        echo '<title>' . $titulo . '</title>';

        if (isset($css_files)) {
            foreach ($css_files as $css) {
                echo link_tag(CSSPATH . $css . '.css');
            }
        }
        if (isset($js_files)) {
            foreach ($js_files as $file) {
                echo script_tag(JSPATH . $file . '.js');
            }
        }
        ?>
    </head>

    <body>
        <div id="login">
            <h2 class="head-alt">Login</h2>
            <ul class="tabs">
                <li><a href="#">Login</a></li>
                <li><a href="#">Esqueceu a senha?</a></li>
            </ul>
            <div class="panes">
                <div id="fieldset">
                    <legend>Informe seu usuário e senha para entrar</legend>
                    <?php echo form_label('Usuário', 'username') ?>
                    <?php echo form_input('username', set_value('username'), 'id="fieldUsername" maxlength="12"') ?>
                    <?php echo form_label('Senha', 'password') ?>
<?php echo form_password('password', '', 'id="fieldPassword" maxlength="8"') ?>
<?php echo form_submit('submit', 'Entrar', 'id="btnEntrar" class="button"') ?>
                </div>
                <div id="fieldset">
                    <legend>Informe seu email para recuperar sua senha!</legend>
                    <?php echo form_label('Email', 'email') ?>
<?php echo form_input('email', '', 'id="fieldEmail" maxlength="45"') ?>
<?php echo form_submit('submit', 'Recuperar', 'id="btnRecuperar" class="button pink"') ?>
                </div>
            </div>
        </div>
        <div id="validation-summary">
            <div class="notification closable errors">
                <h3>Favor corrigir os erros!</h3>
            </div>
        </div>

    </body>

</html>
