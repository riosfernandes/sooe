<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Quadra_model extends DataMapper {
    
    /*
     * se não especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'quadra';
    /*
     * relacionamentos um para muitos
     */
    var $has_one = array("situacao_quadra", "tipo_quadra");
    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'descricao' => array(
            'label' => 'Descrição',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 50)
        ),
        'tipo_quadra_id' => array(
            'label' => 'Tipo de Quadra',
            'rules' => array('required', 'trim')
        ),
        'situacao_quadra_id' => array(
            'label' => 'Situação de Quadra',
            'rules' => array('required', 'trim')
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file quadra_model.php */
/* Location: ./application/models/quadra_model.php */