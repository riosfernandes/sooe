<h1> usuário </h1>

<div>
    <ul>
        <?php
        foreach ($usuarios as $u) {
            echo '<li>' . anchor("usuario/delete/$u->id", 'del') . '---' . anchor("usuario/edit/$u->id", 'edi') . '---' . $u->nome . ':' . $u->login . '</li>';
        }
        ?>
    </ul>
</div>