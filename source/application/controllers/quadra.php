<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Quadra extends MY_Non_Public_Controller {

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
        $crud->set_table('quadra');
        $crud->set_subject('Quadra');
        //@todo$crud->where('situacao_id', 2); //apenas ativos

        $crud->required_fields('descricao', 'tipo_quadra_id', '');
        $crud->columns('id', 'descricao', 'tipo_quadra_id', 'situacao_quadra_id');
        $crud->edit_fields('descricao', 'tipo_quadra_id', 'situacao_quadra_id');
        $crud->add_fields('descricao', 'tipo_quadra_id', 'situacao_quadra_id');

        //relacionamentos
        $crud->set_relation('situacao_quadra_id', 'situacao_quadra', 'descricao');
        $crud->set_relation('tipo_quadra_id', 'tipo_quadra', 'descricao');

        $crud->callback_insert(array($this, 'create'));
        $crud->callback_delete(array($this, 'delete'));

        $contents = $crud->render();

        $this->template->set('titulo', 'Manter Quadra');
        $this->template->set('subtitle', 'Quadra');
        $this->template->load('template_teste', 'crudpage', $contents);
    }

    public function create($post_array) {
        $q = new Quadra_model();
        $q->descricao = $post_array['descricao'];
        $q->tipo_quadra_id = $post_array['tipo_quadra_id'];
        //@todo: Recuperar da configuração do sistema
        $q->situacao_quadra_id = $post_array['situacao_quadra_id'];
        $q->cadastro = date("Y-m-d H:i:s");

        $retorno = $q->save();

        if (!$retorno) {
            return FALSE;
        }
    }

    public function delete($id) {
        $q = new Quadra_model();
        $q->where('id', $id);
        //@todo: Recuperar da configuração do sistema
        return $q->update('situacao_quadra_id', 2); //inativo
    }

// </editor-fold>
}

/* End of file quadra.php */
/* Location: ./application/controllers/quadra.php */