<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Usuario_model extends DataMapper {
    /*
     * se não especificado o datamapper entende que a tabela tem o mesmo 
     * nome do modelo com um 's' no final
     */

    var $table = 'usuario';
    /*
     * relacionamentos um para muitos
     */
    var $has_one = array("tipo_usuario", "situacao");
    var $created_field = 'cadastro';
    var $local_time = TRUE;
    var $validation = array(
        'nome' => array(
            'label' => 'Nome',
            'rules' => array('required', 'trim', 'min_length' => 3, 'max_length' => 45)
        ),
        'login' => array(
            'label' => 'Nome de Usuário',
            'rules' => array('required', 'trim', 'unique', 'min_length' => 3, 'max_length' => 45)
        ),
        'senha' => array(
            'label' => 'Senha',
            'rules' => array('required', 'trim', 'min_length' => 3)//, 'encrypt'
        ),
        'situacao_id' => array(
            'label' => 'Status',
            'rules' => array('required')
        ),
        'tipo_usuario_id' => array(
            'label' => 'Tipo de Usuário',
            'rules' => array('required')
        ),
        'email' => array(
            'label' => 'Endereço de Email',
            'rules' => array('required', 'trim', 'valid_email')
        )
    );

    function __construct($id = NULL) {
        parent::__construct($id);
    }

    // Validation prepping function to encrypt passwords
    function _encrypt($field) {
        // Don't encrypt an empty string
        if (!empty($this->{$field})) {
            // Generate a random salt if empty
            if (empty($this->salt)) {
                $this->salt = md5(uniqid(rand(), true));
            }

            $this->{$field} = sha1($this->salt . $this->{$field});
        }
    }
}

/* End of file usuario_model.php */
/* Location: ./application/models/usuario_model.php */