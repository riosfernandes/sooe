<?php echo link_tag(CSSPATH . 'orcamento/navigator.css') ?>
<?php echo script_tag(JSPATH . 'orcamento/navigator.js') ?>

<ul class="menu-sistem-bar"> 
    <li><a href="#">Cadastro</a>
        <ul>
            <li><a href="#">Fase de Projeto</a></li> 
            <li><a href="#">Tipo de Recurso</a></li> 
            <li><a href="#">Tipo de Unidade</a></li> 
        </ul> 
    </li>
    <li><a href="#">Projeto</a> 
        <ul> 
            <li><a href="#">Estimativa</a></li> 
            <li><a href="<?php echo site_url('orcamento') ?>">Orçamento</a></li>
        </ul> 
    </li>
</ul>
