<?php (defined('BASEPATH')) OR exit('No direct script access allowed');

class MY_Controller_Admin extends MY_Controller {

    function __construct() {
        parent::__construct();

        $this->_check_database();
    }

    private function _check_database() {

        if (ENVIRONMENT !== 'development')
            return;

        // Special auto-setup routine
        if (!$this->CI->db->table_exists('usuario')) {
            redirect('install/reset_warning');
        }
    }

}

/* End of file MY_Controller_Admin.php */
/* Location: ./application/core/MY_Controller_Admin.php */