<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tipo_unidade extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Tipo de Unidade');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('tipo_unidade');
        $crud->set_subject('Tipo de Unidade');
        $crud->columns('id', 'descricao', 'sigla');
        $crud->edit_fields('descricao', 'sigla');
        $crud->add_fields('descricao', 'sigla');
        /* regras e campos obrigatórios */
        $crud->required_fields('descricao', 'sigla');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        $crud->set_rules('sigla', 'Sigla', 'required|min_length[1]');
        return $crud->render();
    }
}

/* End of file tipo_unidade.php */
/* Location: ./application/modules/tipo_unidade/controllers/tipo_unidade.php */