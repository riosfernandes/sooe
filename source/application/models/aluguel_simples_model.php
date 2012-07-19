<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Aluguel_simples_model extends DataMapper {
    /*
     * se não especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'aluguel_simples';
    /*
     * relacionamentos um para muitos
     */
    var $has_one = array("cliente", "quadra");
    var $created_field = 'cadastro';
    var $local_time = TRUE;

//    @todo: fazer validação
//    var $validation = array(
//        'descricao' => array(
//            'label' => 'Descrição',
//            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 50)
//        ),
//        'tipo_quadra_id' => array(
//            'label' => 'Tipo de Quadra',
//            'rules' => array('required', 'trim')
//        ),
//        'situacao_quadra_id' => array(
//            'label' => 'Situação de Quadra',
//            'rules' => array('required', 'trim')
//        )
//    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file aluguel_simples_model.php */
/* Location: ./application/models/aluguel_simples_model.php */