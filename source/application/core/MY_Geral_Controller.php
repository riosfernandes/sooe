<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

abstract class MY_Geral_Controller extends CI_Controller {

    public function load_template($view, $title, $view_data = array(), $template = 'template') {
        $this->template->set('title', $title);
        $this->template->set('nav', $view);
        $this->template->set('nav_list', array('Usuario'));
        $this->template->load($template, $view, $view_data );
    }
}

/* End of file MY_Geral_Controller.php */
/* Location: ./application/core/MY_Geral_Controller.php */