<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Servico_model extends DataMapper {
    /*
     * se não especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'servico';
    /*
     * relacionamentos um para muitos
     */
    var $has_one = array('categoria_servico', 'cla', 'familia');
    var $created_field = 'cadastro';
    var $local_time = TRUE;

//    var $validation = array(
//        'nome' => array(
//            'label' => 'Nome',
//            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 45)
//        ),
//        'login' => array(
//            'label' => 'Nome de Usuário',
//            'rules' => array('required', 'trim', 'unique', 'min_length' => 3, 'max_length' => 45)
//        ),
//        'senha' => array(
//            'label' => 'Senha',
//            'rules' => array('required', 'trim', 'min_length' => 3)//, 'encrypt'
//        ),
//        'situacao_id' => array(
//            'label' => 'Status',
//            'rules' => array('required')
//        ),
//        'tipo_usuario_id' => array(
//            'label' => 'Tipo de Usuário',
//            'rules' => array('required')
//        ),
//        'email' => array(
//            'label' => 'Endereço de Email',
//            'rules' => array('required', 'trim', 'valid_email')
//        )
//    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

}

/* End of file usuario_model.php */
/* Location: ./application/usuario/models/usuario_model.php */