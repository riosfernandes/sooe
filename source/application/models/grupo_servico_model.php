<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Grupo_servico_model extends DataMapper {
    /*
     * se n�o especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'grupo_servico';
//    /*
//     * relacionamentos um para muitos
//     */
//    var $has_many = array(
//        'servico' => array(
//            'class' => 'Servico_model',
//            'other_field' => 'servico',
//            'join_self_as' => 'servico',
//            'join_other_as' => 'projeto',
//            'join_table' => 'atividade')
//    );
    var $has_one = array('grupo_servico');
    var $created_field = 'cadastro';
    var $local_time = TRUE;

    var $validation = array(
        'codigo' => array(
            'label' => 'Codigo',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 20)
        ),
        'descricao' => array(
            'label' => 'Descrição',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 400)
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file grupo_model.php */
/* Location: ./application/usuario/models/servico_model.php */