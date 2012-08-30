<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tipo_fornecedor extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Tipo de Fornecedor');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('tipo_fornecedor');
        $crud->set_subject('Tipo de Fornecedor');
        $crud->columns('id', 'descricao');
        $crud->edit_fields('descricao');
        $crud->add_fields('descricao');
        /* regras e campos obrigatórios */
        $crud->required_fields('descricao');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }
}

/* End of file tipo_fornecedor.php */
/* Location: ./application/modules/tipo_fornecedor/controllers/tipo_fornecedor.php */