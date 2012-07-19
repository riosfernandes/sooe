<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Usuario extends MY_Non_Public_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->crud();
    }

    // <editor-fold defaultstate="collapsed" desc="<:: CRUD ::>">
    public function crud() {
        $crud = new grocery_CRUD();
        $crud->set_theme(THEMA_CRUD);
        $crud->set_table('usuario');
        $crud->set_subject('Usuarios');

        $crud->required_fields('nome', 'login', 'email', 'tipo_usuario_id', 'situacao_id');
        $crud->columns('nome', 'login', 'email', 'tipo_usuario_id', 'situacao_id');
        $crud->edit_fields('nome', 'login', 'email', 'tipo_usuario_id', 'situacao_id');
        $crud->add_fields('nome', 'login', 'email', 'tipo_usuario_id');
        $crud->set_relation('tipo_usuario_id', 'tipo_usuario', 'descricao');
        $crud->set_relation('situacao_id', 'situacao', 'descricao');
        $crud->callback_insert(array($this, 'create'));
        $crud->callback_delete(array($this, 'delete'));
        $crud->callback_update(array($this, 'update'));
        $crud->where('situacao_id', 1);
        $crud->or_where('situacao_id', 2);

        $contents = $crud->render();
//        $this->load->view('template_crud', $contents);
        
        
        $this->template->set('titulo', 'Manter Usuário');        
        $this->template->set('subtitle', 'Usuário');
        // nome do template , nome da view
        $this->template->load('template_teste', 'crudpage', $contents);
    }

    public function create($post_array) {
        $u = new Usuario_model();
        $u->nome = $post_array['nome'];
        $u->login = $post_array['login'];
        $u->email = $post_array['email'];
        $u->tipo_usuario_id = $post_array['tipo_usuario_id'];
        //@todo: Recuperar da configuração do sistema
        $u->situacao_id = 1;
        $u->senha = md5('123');
        $u->cadastro = date("Y-m-d H:i:s");

        $retorno = $u->save();

        if (!$retorno) {
            return FALSE;
        }
    }

    public function delete($id) {
        $u = new Usuario_model();
        $u->where('id', $id);
        //@todo: Recuperar da configuração do sistema
        return $u->update('situacao_id', 3);
    }

    public function update($post_array, $id) {
        $u = new Usuario_model($id);
        $u->nome = $post_array['nome'];
        $u->situacao_id = $post_array['situacao_id'];
        $u->email = $post_array['email'];
        $u->tipo_usuario_id = $post_array['tipo_usuario_id'];

        return $u->save();
    }

// </editor-fold>
}

/* End of file usuario.php */
/* Location: ./application/controllers/usuario.php */