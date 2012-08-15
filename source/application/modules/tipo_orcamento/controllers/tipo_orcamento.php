<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tipo_orcamento extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {        
        $this->template->set('subtitle', 'Tipo de Orçamento');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('tipo_orcamento');
        $crud->set_subject('Tipo de Orçamento');        
        $crud->columns('id', 'descricao');
        $crud->edit_fields('descricao');
        $crud->add_fields('descricao');
        return $crud->render();
    }
}

/* End of file tipo_orcamento.php */
/* Location: ./application/modules/fase_projeto/controllers/tipo_orcamento.php */