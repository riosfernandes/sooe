<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Familia_servico_model extends DataMapper {

    var $table = 'familia_servico';
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
    var $has_one = array('cla_servico');
    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'descricao' => array(
            'label' => 'Descrição',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 300)
        ),
        'codigo' => array(
            'label' => 'Codigo',
            'rules' => array('required', 'trim', 'min_length' => 2, 'max_length' => 2)
        ),
        'cla_servico_id' => array(
            'label' => 'Clã',
            'rules' => array('required')
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file familia_servico.php */
/* Location: ./application/usuario/models/familia_servico.php */