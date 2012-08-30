<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Grupo_usuario extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Grupo de Usuário');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('grupo_usuario');
        $crud->set_subject('Grupo de Usuário');
        $crud->columns('id', 'descricao');
        $crud->edit_fields('descricao');
        $crud->add_fields('descricao');
        /* regras e campos obrigatórios */
        $crud->required_fields('descricao');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }
}

/* End of file grupo_usuario.php */
/* Location: ./application/modules/grupo_usuario/controllers/grupo_usuario.php */