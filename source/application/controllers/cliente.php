<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Cliente extends MY_Non_Public_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->crud();
    }

    // <editor-fold defaultstate="collapsed" desc="<:: CRUD ::>">
    public function crud() {
        $crud = new grocery_CRUD();
        $crud->set_theme(THEMA_CRUD);
        $crud->set_table('cliente');
        $crud->set_subject('Cliente');
        $crud->where('situacao_id', 2); //apenas ativos

        $crud->required_fields('nome', 'documento', 'nascimento', 'situacao_id');
        $crud->columns('nome', 'documento', 'nascimento');
        $crud->edit_fields('nome', 'documento', 'nascimento', 'situacao_id');
        $crud->add_fields('nome', 'documento', 'nascimento');

        //relacionamentos
        $crud->set_relation('situacao_id', 'situacao', 'descricao');

        $crud->callback_insert(array($this, 'create'));
        $crud->callback_delete(array($this, 'delete'));

        $contents = $crud->render();

        $this->template->set('titulo', 'Manter Cliente');
        $this->template->set('subtitle', 'Cliente');
        $this->template->load('template_teste', 'crudpage', $contents);
    }

    public function create($post_array) {
        $date = $post_array['nascimento'];
        sscanf( $date, "%d/%d/%d", $d, $m, $y );
        $date = sprintf("%d-%d-%d", $y, $m, $d );
        
        $c = new Cliente_model();
        $c->nome = $post_array['nome'];
        $c->documento = $post_array['documento'];
        $c->nascimento = $date;
        //@todo: Recuperar da configuração do sistema
        $c->situacao_id = 2;
        $c->cadastro = date("Y-m-d H:i:s");

        $retorno = $c->save();

        if (!$retorno) {
            return FALSE;
        }
    }

    public function delete($id) {
        $c = new Cliente_model();
        $c->where('id', $id);
        //@todo: Recuperar da configuração do sistema
        return $c->update('situacao_id', 3);
    }

// </editor-fold>
}

/* End of file cliente.php */
/* Location: ./application/controllers/cliente.php */