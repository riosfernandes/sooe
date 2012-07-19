<?php

class MY_Public_Controller extends CI_Controller {

    function __construct() {
        parent::__construct();
        //definir stylesheets para as páginas
        $this->template->set('styles', array('general', 'hyper_header', 'header', 'navigator', 'content', 'footer'));
        $this->template->set('js_files_jquery', array('jquery-1.7.1.min', 'jquery.tools.min', 'navigator', 'footer'));
        $this->template->set('js_files_aditional', array());
    }

}

/* End of file MY_Public_Controller.php */
/* Location: ./application/core/MY_Public_Controller.php */