<?php if ($message) : ?>
    <p><?php echo $message; ?></p>
<?php endif; ?>

<table>
    <thead>
        <tr>
            <td><a id="link-add" href="<?php echo site_url('orcamento/add')?>">New</a></td>
        </tr>
        <tr>
            <td>Descrição</td>
            <td>SCO</td>
            <td>&nbsp;</td>       <!-- editar o registro -->
        </tr>
    </thead>
    <tbody>
        <?php foreach ($servicos as $s) : ?>
            <tr>
                <td><?php echo $s->sco; ?></td>
                <td><?php echo $s->descricao; ?></td>
                <td><?php echo anchor('orcamento/edit/' . $s->id, '<i class="icon-pencil"></i>', 'title="Edit"'); ?></td>
            </tr>
        <?php endforeach; ?>
    <tbody>
</table>