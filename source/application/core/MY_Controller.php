<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller {

    private $default_template;
    function __construct($default_template = 'template') {
        parent::__construct();   
        $this->default_template = $default_template;
    }

    function _my_output($output = null) {
        $this->load->view($this->default_template, $output);
    }
    
    function index() {
        $this->_my_output((object) array('output' => '', 'js_files' => array(), 'css_files' => array()));
    }
}
