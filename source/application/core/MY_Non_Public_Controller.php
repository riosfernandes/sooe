<?php

class MY_Non_Public_Controller extends CI_Controller {

    function __construct() {
        parent::__construct();
        //definir stylesheets para as páginas
        $this->template->set('styles', $this->get_css());
        $this->template->set('js_files_jquery', $this->get_js());
        $this->template->set('js_files_aditional', array());

        $this->isLogado();
    }

    public function get_js() {
        $js_temp = array('navigator', 'footer');
        $js_files_jquery = array();

        foreach ($js_temp as $js) {            
            $js_files_jquery[sha1($js)] = $this->get_js_formatado($js);
        }

        return $js_files_jquery;
    }

    public function get_js_formatado($js) {
        $js = JSPATH . $js . '.js';
        return base_url() . $js;
    }
    
    public function get_css() {
        $css_temp = array('hyper_header', 'header', 'general', 'navigator', 'content', 'footer');
        $css_files = array();

        foreach ($css_temp as $css) {
            $css_files[sha1($css)] = $this->get_css_formatado($css);
        }

        return $css_files;
    }
    
    public function get_css_formatado($css) {
        $css = CSSPATH . $css . '.css';
        return base_url() . $css;
    }

    function isLogado() {

        //@todo: ativar login quando tiver usuário        
//        $u = $this->session->userdata('usuario_logado');
//        if (!$u) {
//            redirect('login');
//        }
        return true;
    }

    function date_converter($_date = null) {
        $format = '/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/';
        if ($_date != null && preg_match($format, $_date, $partes)) {
            return $partes[3] . '-' . $partes[2] . '-' . $partes[1];
        }
        return false;
    }

}

/* End of file MY_Non_Public_Controller.php */
/* Location: ./application/core/MY_Non_Public_Controller.php */