<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Grupo_usuario_model extends DataMapper {

    var $table = 'grupo_usuario';

//    /* relação n:n com usuário */
//    var $has_many = array(
//        'usuario' => array(
//            'class' => 'Usuario_model',
//            'other_field' => 'usuario',
//            'join_self_as' => 'usuario',
//            'join_other_as' => 'grupo_usuario',
//            'join_table' => 'grupo_usuario_x_usuario')
//    );

    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'descricao' => array(
            'label' => 'Descrição',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 45)
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }
}

/* End of file grupo_usuario.php */
/* Location: ./application/usuario/models/grupo_usuario.php */