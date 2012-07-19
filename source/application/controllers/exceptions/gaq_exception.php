<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class GAQ_exception extends Exception {

    function __construct($msn = "") {
        parent::__construct($msn);
    }

}

/* End of file aluguel_simples.php */
/* Location: ./application/controllers/aluguel_simples.php */
    