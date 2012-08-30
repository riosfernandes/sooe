<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Categoria_servico extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Categoria de Serviço');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('categoria_servico');
        $crud->set_subject('Categoria de Serviço'); 
        $crud->columns('id', 'codigo', 'descricao');
        $crud->edit_fields('codigo', 'descricao');
        $crud->add_fields('codigo', 'descricao');
        /* regras e campos obrigatórios */
        $crud->required_fields('codigo', 'descricao');        
        $crud->set_rules('codigo', 'Código', 'required|min_length[2]');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }
}

/* End of file categoria_servico.php */
/* Location: ./application/modules/categoria_servico/controllers/categoria_servico.php */