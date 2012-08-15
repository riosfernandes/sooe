<?php (defined('BASEPATH')) OR exit('No direct script access allowed');

/*
 * Controller principal que possui functions comuns para todos os outros;
 * OBS> N�o utilizar nos controllers do applications.
 */

class MY_Controller extends CI_Controller {

    function __construct() {
        parent::__construct();
        //pode difinir aqui css e js que ser�o padr�o para todas as telas.
        $this->template->set('css_files', $this->get_css());
        $this->template->set('js_files', $this->get_js());

        $this->CI = & get_instance();
        $this->session = & $this->CI->session;
    }

    /*
     * Retorna um js formatado.
     */

    public function get_js_formatado($js_name) {
        $js_name = JSPATH . $js_name . '.js';
        return base_url() . $js_name;
    }

    /*
     * Retorna um css formatado.
     */

    public function get_css_formatado($css_name) {
        $css_name = CSSPATH . $css_name . '.css';
        return base_url() . $css_name;
    }

    /*
     * Converte datas
     */

    function date_converter($_date = null) {
        $format = '/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/';
        if ($_date != null && preg_match($format, $_date, $partes)) {
            return $partes[3] . '-' . $partes[2] . '-' . $partes[1];
        }
        return false;
    }
    
    public function get_js() {
        $js_temp = array('jquery-1.7.2.min', 'jquery-ui-1.8.21.custom.min', 'general', 'navigator', 'footer');
        $js_files_jquery = array();

        foreach ($js_temp as $js) {            
            $js_files_jquery[sha1($js)] = $this->get_js_formatado($js);
        }

        return $js_files_jquery;
    }
    
    public function get_css() {
        $css_temp = array('ui-lightness/jquery-ui-1.8.21.custom', 'hyper_header', 'header', 'general', 'navigator', 'subtitle', 'content', 'footer');
        $css_files = array();

        foreach ($css_temp as $css) {
            $css_files[sha1($css)] = $this->get_css_formatado($css);
        }

        return $css_files;
    }
    
    /*
     * returna o dado do post com  o mesmo nome passado ou ent�o '';
     */
    public function get_post($name){
        $temp = $_POST[$name];
        return isset($temp) ? $temp : '';
    }

}

/* End of file MY_Controller.php */
/* Location: ./application/core/MY_Controller.php */