<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Cla_servico extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Clã de Serviço');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('cla_servico');
        $crud->set_subject('Clã de Serviço');        
        $crud->set_relation('categoria_id', 'categoria_servico', 'codigo');
        $crud->columns('id', 'categoria_id', 'descricao', 'codigo');
        $crud->display_as('categoria_id', 'Categoria');
        $crud->edit_fields('categoria_id', 'codigo', 'descricao');
        $crud->add_fields('categoria_id', 'codigo', 'descricao');
        /* regras e campos obrigatórios */
        $crud->required_fields('categoria_id', 'codigo', 'descricao');
        $crud->set_rules('categoria_id', 'Categoria', 'required');
        $crud->set_rules('codigo', 'Código', 'required|min_length[2]');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }
}

/* End of file categoria_servico.php */
/* Location: ./application/modules/categoria_servico/controllers/categoria_servico.php */