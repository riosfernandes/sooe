﻿<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Welcome extends MY_Non_Public_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('css_files', array($this->get_css_formatado('welcome')));
        $this->template->set('js_files', array($this->get_js_formatado('welcome')));
        $this->template->set('titulo', 'Seja bem vindo');
        $this->template->load('template_teste', 'welcome');
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */