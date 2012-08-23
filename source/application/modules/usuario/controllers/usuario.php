<?php
//@todo: salvar na base o id da session?
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Usuario extends MY_Non_Public_Controller {

    var $error;

    function __construct() {
        parent::__construct();
    }

    function index() {
        $this->template->set('subtitle', 'Categoria de Serviço');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }

    private function get_crud() {
        $this->data['message'] = $this->session->flashdata('message');

        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('usuario');
        $crud->set_subject('Usuário');
        $crud->unset_columns('id', 'senha', 'senha_anterior1', 'senha_anterior2', 'senha_anterior3', 'ultima_troca', 'cadastro');
        $crud->fields('id', 'nome', 'login', 'email', 'grupos', 'tipo_usuario_id', 'situacao_usuario_id', 'senha', 'senha_anterior1', 'senha_anterior2', 'senha_anterior3');
        $crud->unset_texteditor('id', 'senha', 'senha_anterior1', 'senha_anterior2', 'senha_anterior3', 'ultima_troca', 'cadastro');
        $crud->change_field_type('id', 'invisible');
        $crud->change_field_type('senha', 'invisible');
        $crud->change_field_type('senha_anterior1', 'invisible');
        $crud->change_field_type('senha_anterior2', 'invisible');
        $crud->change_field_type('senha_anterior3', 'invisible');
        $crud->set_relation('situacao_usuario_id', 'situacao_usuario', 'descricao');
        $crud->display_as('situacao_usuario_id', 'Situacao');
        $crud->set_relation('tipo_usuario_id', 'tipo_usuario', 'descricao');
        $crud->display_as('tipo_usuario_id', 'Tipo de Usuário');
        $crud->set_relation_n_n('grupos', 'grupo_usuario_x_usuario', 'grupo_usuario', 'usuario_id', 'grupo_usuario_id', 'descricao');
        /* regras e campos obrigatórios */
        $crud->required_fields('login', 'grupos', 'tipo_usuario_id', 'situacao_usuario_id');
        $crud->set_rules('login', 'Login', 'required|min_length[2]');
        $crud->set_rules('grupos', 'Grupos', 'required');
        $crud->set_rules('tipo_usuario_id', 'Tipo de Usuário', 'required');
        $crud->set_rules('situacao_usuario_id', 'Situação do Usuário', 'required');
        $crud->callback_before_insert(array($this, 'checking_new_user'));
        return $crud->render();
    }

    function checking_new_user($post_array) {
        /*
         * verifica se o usuário é novo
         * e atribui senha padrão para o mesmo
         * utilizando o 'login'
         */
        if (empty($post_array['id'])) {
            $post_array['situacao_usuario_id'] = '3';
            $post_array['senha'] = md5($post_array['login']);
        }
        return $post_array;
    }
}

/* End of file usuario.php */
/* Location: ./application/modules/usuario/controllers/usuario.php */