<?php

/*adiciona o js de navegacao*/
echo script_tag(JSPATH . 'navigator.js');

if ($this->session->userdata('usuario_logado')) {
    /*menu*/
    echo '<div id="menu">';
    echo '<ul>';
    echo '<a id="link-home" href="welcome"><li>Home</li></a>';
    echo '<a id="link-cadastro" href=""><li>Cadastro</li></a>';
    echo '<a id="link-reserva" href=""><li>Reserva</li></a>';
    echo '<a id="link-relatorio" href=""><li>Relatório</li></a>';
    echo '</ul>';
    echo '</div>';

    /*submenu*/
    echo '<div id="submenu-home" class="submenu">';
    echo '<ul>';
//    echo '<a href=""><li></li></a>';
//    echo '<a href=""><li></li></a>';
//    echo '<a href=""><li></li></a>';
    echo '</ul>';
    echo '</div>';
    
    echo '<div id="submenu-cadastro" class="submenu">';
    echo '<ul>';
    echo '<a id="link-cadastro-usuario" href="' . site_url('usuario') . '"><li>Usuário</li></a>';
    echo '<a id="link-cadastro-quadra" href="' . site_url('quadra') . '"><li>Quadra</li></a>';
    echo '<a id="link-cadastro-cliente" href="' . site_url('cliente') . '"><li>Cliente</li></a>';
    echo '</ul>';
    echo '</div>';
    
    echo '<div id="submenu-reserva" class="submenu">';
    echo '<ul>';
    echo '<a id="link-reserva-simples" href="' . site_url('aluguel_simples') . '"><li>Simples</li></a>';
    echo '<a id="link-reserva-mensalista" href="' . site_url('aluguel_mensalista') . '"><li>Mensalista</li></a>';
    echo '</ul>';
    echo '</div>';
    
    echo '<div id="submenu-relatorio" class="submenu">';
    echo '<ul>';
    echo '<a id="link-relatorio-reservas-mensal" href="' . site_url('relatorio_reservas_mensal') . '"><li>Reservas Por Mês</li></a>';
    echo '<a id="link-relatorio-clientes-periodo" href="' . site_url('relatorio_clientes_periodo') . '"><li>Relação de Clientes Por Período</li></a>';
    echo '</ul>';
    echo '</div>';
}
?>