<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tipo_custo extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {        
        $this->template->set('subtitle', 'Tipo de Custo');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('tipo_custo');
        $crud->set_subject('Tipo de Custo');        
        $crud->columns('id', 'descricao');
        $crud->edit_fields('descricao');
        $crud->add_fields('descricao');
        $crud->required_fields('descricao');
        return $crud->render();
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */