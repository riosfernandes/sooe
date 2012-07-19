<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Cliente_model extends DataMapper {
    /*
     * se não especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'cliente';
    /*
     * relacionamentos um para muitos
     */
    var $has_one = array("situacao");
    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'nome' => array(
            'label' => 'Nome',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 50)
        ),
        'documento' => array(
            'label' => 'Documento',
            'rules' => array('required', 'trim', 'unique', 'min_length' => 5, 'max_length' => 15)
        ),
        'nascimento' => array(
            'label' => 'Data de Nascimento',
            'rules' => array('required', 'trim', 'min_length' => 3)//, 'encrypt'
        ),
        'situacao_id' => array(
            'label' => 'Status',
            'rules' => array('required')
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }
}

/* End of file cliente_model.php */
/* Location: ./application/models/cliente_model.php */