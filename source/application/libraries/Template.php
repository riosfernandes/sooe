<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Template {

    var $template_data = array();

    function set($name, $value) {
        if (isset($this->template_data[$name])) {
            if (is_array($value)) {
                foreach ($value as $v) {
                    array_push($this->template_data[$name], $v);
                }
            } else {
                array_push($this->template_data[$name], $value);
            }
        } else {
            $this->template_data[$name] = $value;
        }
    }

    function load($template = '', $view = '', $view_data = array(), $return = FALSE) {
        $this->CI = & get_instance();
        $this->set('contents', $this->CI->load->view($view, $view_data, TRUE));
        return $this->CI->load->view($template, $this->template_data, $return);
    }

    /*
     * carrega uma view que já possui crud internamente
     */

    function load_with_crud($template = '', $view = '', $return = FALSE) {
        $this->CI = & get_instance();
        $this->set('contents', $view);
        return $this->CI->load->view($template, $this->template_data, $return);
    }

}

/* End of file Template.php */
/* Location: ./application/libraries/template.php */