<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Categoria_servico extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme('datatables');
        $crud->set_table('categoria_servico');
        $crud->set_subject('Categoria de Serviço');        
        $crud->columns('id', 'sigla', 'descricao');
        $crud->edit_fields('sigla', 'descricao');
        $crud->add_fields('sigla', 'descricao');
        $contents = $crud->render();

        $this->template->set('subtitle', $crud->get_subject());
        $this->template->load('template_teste', 'crudpage', $contents);
    }
}

/* End of file categoria_servico.php */
/* Location: ./application/modules/categoria_servico/controllers/categoria_servico.php */