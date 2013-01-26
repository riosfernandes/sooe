<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Insumo_model extends DataMapper {

    var $table = 'insumo';
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
    var $has_one = array(
        'unidade' => array(
            'class' => 'tipo_unidade_model',
            'other_field' => 'insumo',
            'join_self_as' => 'id',
            'join_other_as' => 'tipo_unidade',
            'join_table' => 'insumo'
        )
    );
    var $has_many = array(
        'fornecedor' => array(
            'class' => 'fornecedor_model',
            'other_field' => 'insumo',
            'join_self_as' => 'insumo',
            'join_other_as' => 'fornecedor',
            'join_table' => 'insumo_x_fornecedor'
        )
    );
    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'codigo' => array(
            'label' => 'Código',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 20)
        ),
        'descricao' => array(
            'label' => 'Descrição',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 45)
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file insumo_model.php */
/* Location: ./application/usuario/models/insumo_model.php */