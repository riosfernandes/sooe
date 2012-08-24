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
            <h2 class="head-alt">Alteração de senha de acesso</h2>
            <div class="fieldset">
                <div class="fields">
                    <?php echo form_label('Login', 'lblLogin') ?>
                    <?php echo form_input('login', '', 'id="txtLogin"') ?>
                </div>
                <div class="fields">
                    <?php echo form_label('Senha atual', 'lblPassword') ?>
                    <?php echo form_password('senha_atual', '', 'id="txtPassword"') ?>
                </div>
                <hr></hr>
                <div class="fields">
                    <?php echo form_label('Nova senha', 'lblPasswordNew1') ?>
                    <?php echo form_password('nova_senha', '', 'id="txtPasswordNew1"') ?>
                </div>
                <div class="fields">
                    <?php echo form_label('Repita a senha', 'lblPasswordNew2') ?>
                    <?php echo form_password('repita_a_senha', '', 'id="txtPasswordNew2"') ?>
                    <?php echo form_submit('submit', 'Alterar Senha', 'id="btnAlterarSenha" class="button"') ?>
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
