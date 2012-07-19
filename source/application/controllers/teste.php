<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Teste extends MY_Public_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {
        $this->template->set('titulo', 'Welcome to CodeIgniter');
        // nome do template , nome da view
        $this->template->load('template_teste', 'about');
    }

    function about(){
        $this->template->set('titulo', 'Welcome to CodeIgniter');
        // nome do template , nome da view
        //$this->template->set('styles', array('general','content','navigator'));
        $this->template->load('template_teste', 'welcome_message');
    }
}

/* End of file teste.php */
/* Location: ./application/controllers/teste.php */
