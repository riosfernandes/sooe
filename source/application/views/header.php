<div id="logo">    
</div>
<div id="user_logged">
    <div id="img_user">        
    </div>
    <div id="user_welcome">
        <div>
            <?php
            $u = $this->session->userdata('usuario_logado');
            echo '<p class="welcome">' . ucwords($u['nome']) . '</p>';
            ?>
        </div>
        <div>
            <a class="user_change_password" href="<?php echo site_url('login/alterar_senha') ?>">Alterar Senha</a>
        </div>        
        <div>
            <a href="<?php echo site_url('login/logout') ?>">
                <div class="img_sair">&nbsp;</div>
            </a>
        </div>
    </div>
</div>