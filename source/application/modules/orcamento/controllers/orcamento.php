<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Orcamento extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {        
        $this->data['message'] = $this->session->flashdata('message');        
        $servico = new Servico_model();
        $this->data['servicos'] = $servico->get_by_active();
        
        $this->template->set('js_files', array(
            $this->get_js_formatado('orcamento/list'),
            $this->get_js_formatado('orcamento/orcamento')));
        $this->template->set('css_files', array($this->get_css_formatado('orcamento/orcamento')));        
        $this->template->set('titulo', 'Or�amento de Obra');
        $this->template->load('template_teste', 'orcamento', $this->data);
    }

    public function add() {
        $this->template->set('js_files', array($this->get_js_formatado('orcamento/list')));
        $this->template->set('titulo', 'Or�amento de Obra');
        $this->template->load('template_teste', 'servico');
        
//        $this->load->library('form_validation');
//
//        if ($this->_validation() == TRUE) {
//            $action = $this->_action();
//
//            if ($action)
//                $this->session->set_flashdata('message', 'Yupi! You have a new item!');
//            else
//                $this->session->set_flashdata('message', 'Caspita!! Something wrong');
//
//            redirect('administrators/admin');
//        }
//        $this->template->build('crud', $this->data);
    }

    private function _validation($id = NULL) {
//        $this->form_validation->set_rules('group_id', 'Group', 'required');
//        $this->form_validation->set_rules('name', 'Name', 'required|max_length[90]');
//        $this->form_validation->set_rules('email', 'E-mail', 'required|max_length[90]|valid_email');
//        $pass_required = ($id == NULL) ? 'required' : '';
//        $this->form_validation->set_rules('password', 'Password', $pass_required);
//        $this->form_validation->set_rules('active', 'Active', 'required');
//
//        return $this->form_validation->run();
        return TRUE;
    }

    private function _action($id = NULL) {
//        $projeto = new Projeto_model($id);
//        $projeto->descricao = !isset($_POST['descricao'])? $_POST['descricao'] : '';  //$this->input->post('descricao', TRUE);
//        $projeto->email = $this->input->post('email', TRUE);
//        $projeto->active = $this->input->post('active', TRUE);
//        $projeto->updated = gmdate('Y-m-d H:i:s');
//        if ($id == NULL)
//            $projeto->created = gmdate('Y-m-d H:i:s');
//        if ($this->input->post('password')) {
//            $this->load->helper('security');
//            $projeto->password = do_hash($this->input->post('password', TRUE));
//        }
//
//        return $projeto->save();
    }

    public function find_servico(){
        $texto = $this->input->post('texto');
        
        
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */