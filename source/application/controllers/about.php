<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class About extends MY_Public_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {
        $this->template->set('titulo', 'Seja bem vindo');
        $this->template->load('template_teste', 'about');
    }

}

/* End of file about.php */
/* Location: ./application/controllers/about.php */
