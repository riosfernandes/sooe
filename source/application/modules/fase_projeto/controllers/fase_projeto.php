<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Fase_projeto extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Fase de Projeto');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('fase_projeto');
        $crud->set_subject('Fase de Projeto');        
        $crud->columns('id', 'descricao');
        $crud->edit_fields('descricao');
        $crud->add_fields('descricao');
        $crud->required_fields('descricao');
        return $crud->render();
    }
}

/* End of file fase_projeto.php */
/* Location: ./application/modules/fase_projeto/controllers/fase_projeto.php */