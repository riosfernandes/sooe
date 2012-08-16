<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tipo_fornecedor_model extends DataMapper {

    var $table = 'tipo_fornecedor';
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
//    var $has_one = array('categoria_servico');
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

/* End of file tipo_fornecedor.php */
/* Location: ./application/usuario/models/tipo_fornecedor.php */