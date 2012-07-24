<?php if ($message) : ?>
    <p><?php echo $message; ?></p>
<?php endif; ?>

<table id="table-servicos">
    <thead>
        <tr>
            <td><a id="link-add" href="<?php echo site_url('orcamento/add') ?>">New</a></td>
        </tr>
        <tr>
            <td></td>
            <td>Descrição</td>
            <td>SCO</td>            
        </tr>
    </thead>
    <tbody>
        <?php if (isset($servicos)) : ?>
            <?php foreach ($servicos as $s) : ?>
                <tr>
                    <td><input id="<?php echo $s->id ?>" type="button" item="<?php echo $s->id ?>" class="remove"></input></td>
                    <td><?php echo $s->descricao; ?></td>
                    <td><?php echo $s->sco; ?></td>
                </tr>
            <?php endforeach; ?>
        <?php endif; ?>
    <tbody>
</table>