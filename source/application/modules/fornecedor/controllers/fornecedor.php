<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Fornecedor extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Fornecedor');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('fornecedor');
        $crud->set_subject('Fornecedor');
        $crud->unset_columns('id');
        $crud->fields('id', 'codigo', 'nome', 'cnpj', 'inscricao_estadual', 'tipo_fornecedor_id');
        $crud->unset_texteditor('id');
        $crud->change_field_type('id', 'invisible');
        
        /* relacionamentos */
        $crud->set_relation('tipo_fornecedor_id', 'tipo_fornecedor', 'descricao');
        
        /* descrição dos campos de relacionamento */
        $crud->display_as('tipo_fornecedor_id', 'Tipo de Fornecedor');
        
        /* regras e campos obrigatórios */
        $crud->required_fields('nome');
        $crud->required_fields('codigo');
        $crud->required_fields('tipo_fornecedor_id');
        $crud->set_rules('nome', 'Nome', 'required|min_length[3]');
        $crud->set_rules('codigo', 'Código', 'required|min_length[3]');
        $crud->set_rules('tipo_fornecedor_id', 'Tipo de Fornecedor', 'required');
        return $crud->render();
    }
}

/* End of file tipo_fornecedor.php */
/* Location: ./application/modules/tipo_fornecedor/controllers/tipo_fornecedor.php */