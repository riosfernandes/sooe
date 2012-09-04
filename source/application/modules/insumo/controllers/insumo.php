<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Insumo extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Insumo');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }
    
    private function get_crud(){
        $this->data['message'] = $this->session->flashdata('message');
        
        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('insumo');
        $crud->set_subject('Insumo');
        $crud->unset_columns('id');
        $crud->fields('id', 'codigo', 'descricao', 'tipo_insumo_id', 'tipo_unidade_id', 'origem_insumo_id');
        $crud->display_as('codigo', 'Código');
        $crud->display_as('descricao', 'Descrição');
        $crud->display_as('tipo_insumo_id', 'Tipo');
        $crud->display_as('tipo_unidade_id', 'Unidade');
        $crud->display_as('origem_insumo_id', 'Origem');
        $crud->change_field_type('id', 'invisible');
        
        /* relacionamentos */
        $crud->set_relation('tipo_insumo_id', 'tipo_insumo', 'descricao');
        $crud->set_relation('tipo_unidade_id', 'tipo_unidade', 'sigla');
        $crud->set_relation('origem_insumo_id', 'origem_insumo', 'descricao');
        
        /* regras e campos obrigatórios */
        $crud->required_fields('descricao');        
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }
    
    function show_preco_insumo(){
        $this->template->set('css_files', array($this->get_css_formatado('preco_insumo')));
        $this->template->set('js_files', array($this->get_js_formatado('preco_insumo')));
        $this->template->set('subtitle', 'Preço de Insumo');
        $this->template->load('template_teste', 'insumo/preco_insumo');
    }
}

/* End of file insumo.php */
/* Location: ./application/modules/insumo/controllers/insumo.php */