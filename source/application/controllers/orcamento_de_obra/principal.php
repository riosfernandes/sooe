<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Principal extends MY_Non_Public_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('css_files_aditional', array());
        $this->template->set('js_files_aditional', array());
        $this->template->set('titulo', 'Orçamento de Obra');
        $this->template->load('template_teste', 'orcamento_de_obra/index');
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */