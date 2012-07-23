<?php

class Install extends CI_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        
    }

    function reset_warning() {
        if ($this->db->table_exists('user')) {
            show_error('The database is already configured');
        }
        $this->template->set('titulo', '| Initialize System |');
        $this->template->set('subtitle', 'System Management and database load');
        $this->template->load('template_master', 'reset');
    }

    /**
     * Resets the entire Database
     */
    function reset() {
        $this->load->dbforge();
        try {
            // force disabling of g-zip so output can be streamed
            apache_setenv('no-gzip', '1');
        } catch (Exception $e) { /* ignore */
        }


//        @todo: Abrir views especifica para o load das tables;
        ?><div class="database_setup"><?php
        $this->_message('Creating the database at <strong>' . $this->db->database . '</strong><br/>', '');
        $success = $this->_drop_tables();
        echo("<br/><br/>");
        $success = $success && $this->_create_tables();
        echo("<br/><br/>");
        $success = $success && $this->_init_data();
        ?></div><?php
        if ($success) {
            ?><p><a href="<?php echo site_url('welcome'); ?>">Continue</a></p><?php
        } else {
            ?>An error occurred.  Please reset the database and try again.<?php
        }
    }

    function _drop_tables() {
        $this->load->helper('file');
        $path = APPPATH . 'sql/' . $this->db->dbdriver . '/drop';
        if (!file_exists($path)) {
            show_error("ERROR: Unable to automatically create tables for " . $this->db->dbdriver . ' databases.');
        }
        $tables = get_filenames($path);

        foreach ($tables as $table) {
            $list = file($path . '/' . $table);

            foreach ($list as $l) {
                $l = trim($l);
                if (empty($l) || $l[0] == '#') {
                    continue;
                }
                if ($this->db->table_exists($l)) {
                    $this->_message("Dropping table $l...");
                    if ($this->dbforge->drop_table($l)) {
                        echo("done.");
                    } else {
                        echo("ERROR.");
                        return FALSE;
                    }
                }
            }
            return TRUE;
        }
    }

    function _create_tables() {
        $tables = $this->_get_tables();

        foreach ($tables as $table) {
            $n = str_ireplace('.sql', '', $table);
            $this->_message("Creating table $n...");
            $path = APPPATH . 'sql/' . $this->db->dbdriver . '/create/' . $table;
            $sql = file_get_contents($path);
            if ($this->db->query($sql)) {
                echo("done.");
            } else {
                echo("ERROR.");
                return FALSE;
            }
        }
        return TRUE;
    }

    function _get_tables() {
        $this->load->helper('file');
        $path = APPPATH . 'sql/' . $this->db->dbdriver . '/create';
        if (!file_exists($path)) {
            show_error("ERROR: Unable to automatically create tables for " . $this->db->dbdriver . ' databases.');
        }

        return get_filenames($path);
    }

    function _init_data() {
//        $this->load->helper('file');
//        $path = APPPATH . 'sql/' . $this->db->dbdriver . '/data';
//        $files = get_filenames($path);
//
//        if (!isset($files) || array_count_values($files) == 0)
//            return;
//
//        foreach ($files as $file) {
//            if (!strpos($file, '.sql')) {
//                continue;
//            }
//            $class = str_ireplace('.sql', '', $file);
//            $this->_message("Importing data for $class ");
//            $sql = file_get_contents(APPPATH . 'sql/' . $this->db->dbdriver . '/data/' . $file);
//            if ($this->db->query($sql)) {
//                echo("done.");
//            } else {
//                echo("ERROR.");
//                return FALSE;
//            }
//        }
        return TRUE;
    }

    function _save_object($obj) {
        if (!$obj->save()) {
            $this->_message('Errors: <ul><li>' . implode('</li><li>', $r->error->all) . '</li></ul>', '');
            return FALSE;
        }
        $this->_message('.', '');
        return TRUE;
    }

    function _message($msg, $lb = '<br/>') {
        echo($lb . $msg);
        ob_flush();
        flush();
    }

    /**
     * Allows the creation of an Administrator
     *
     */
    function init($save = FALSE) {
        $first_time = $this->session->userdata('first_time');
        if (!$first_time) {
            show_error('This page can only be accessed the first time.');
        }
        $user = new User();

        if ($save) {
            $user->trans_start();
            $user->from_array($_POST, array('name', 'email', 'username', 'password', 'confirm_password'));
            $group = new Group();
            $group->get_by_id(1);
            if ($user->save($group)) {
                $user->password = $this->input->post('password');
                if (!$this->login_manager->process_login($user)) {
                    show_error('Errors: <ul><li>' . implode('</li><li>', $user->error->all) . '</li></ul><pre>' . var_export($user->error, TRUE) . '</pre>');
                }
                $this->session->unset_userdata('first_time');
                $user->trans_complete();
                redirect('welcome');
            }
        }

        $user->load_extension('htmlform');

        // ID is not included because it is not necessary
        $form_fields = array(
            'Contact Information' => 'section',
            'name' => array(
                'label' => 'Your Name'
            ),
            'email',
            'Login Information' => 'section',
            'username',
            'password',
            'confirm_password'
        );

        $this->load->view('template_header', array('title' => 'Set Up Your Account', 'section' => 'admin'));
        $this->load->view('admin/init', array('user' => $user, 'form_fields' => $form_fields));
        $this->load->view('template_footer');
    }

}