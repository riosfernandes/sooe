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
    var $has_one = array('tipo_insumo', 'tipo_unidade', 'origem_insumo');
    
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