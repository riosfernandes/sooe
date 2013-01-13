<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Insumo extends MY_Non_Public_Controller {

    public $data = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->template->set('subtitle', 'Insumo');
        $this->template->load('template_teste', 'crudpage', $this->get_crud());
    }

    private function get_crud() {
        $this->data['message'] = $this->session->flashdata('message');

        $crud = new grocery_CRUD();
        $crud->set_theme(GROCERY_CRUD_THEME);
        $crud->set_table('insumo');
        $crud->set_subject('Insumo');
        $crud->unset_columns('id');
        $crud->fields('id', 'codigo', 'descricao', 'tipo_insumo_id', 'tipo_unidade_id', 'origem_insumo_id');
        $crud->display_as('codigo', 'Código');
        $crud->display_as('descricao', 'Descrição');
        $crud->display_as('tipo_insumo_id', 'Tipo');
        $crud->display_as('tipo_unidade_id', 'Unidade');
        $crud->display_as('origem_insumo_id', 'Origem');
        $crud->change_field_type('id', 'invisible');

        /* relacionamentos */
        $crud->set_relation('tipo_insumo_id', 'tipo_insumo', 'descricao');
        $crud->set_relation('tipo_unidade_id', 'tipo_unidade', 'sigla');
        $crud->set_relation('origem_insumo_id', 'origem_insumo', 'descricao');

        /* regras e campos obrigatórios */
        $crud->required_fields('descricao');
        $crud->set_rules('descricao', 'Descrição', 'required|min_length[3]');
        return $crud->render();
    }

    function show_preco_insumo() {
        $this->template->set(
                'css_files', array($this->get_css_formatado('insumo'),
            $this->get_css_formatado('source/easyui'),
            $this->get_css_formatado('source/icon'),
            $this->get_css_formatado('source/demo'),
            $this->get_css_formatado('source/source')
                )
        );
        $this->template->set('js_files', array(
//            $this->get_js_formatado('jquery.easyui.min'),
            $this->get_js_formatado('insumo')
        ));

        $this->template->set('subtitle', 'Preço de Insumo');
        $this->template->load('template_teste', 'insumo/insumo');
    }

    public function find_fornecedor() {
        $termo = isset($_POST['term']) ? $_POST['term'] : '';

        $rs = new Fornecedor_model();
        $rs->like('codigo', '%' . $termo . '%');
        $rs->or_like('nome', '%' . $termo . '%');
        $rs->or_like('cnpj', '%' . $termo . '%');
        $rs->or_like('inscricao_estadual', '%' . $termo . '%');

        foreach ($rs->get() as $r) {
            $data['result'][$r->id]['id'] = $r->id;
            $data['result'][$r->id]['descricao'] = "$r->id --- $r->nome";
            $data['result'][$r->id]['label'] = "CNPJ: $r->cnpj, $r->nome - CD: $r->codigo - IE: $r->inscricao_estadual";
        }

        if (isset($data['result']))
            $data['success'] = true;
        else
            $data['error'] = 'Nenhum fornecedor encontrado';

        echo json_encode($data);
    }

    public function find_insumo() {
        try {
            $fornecedor_id = $this->input->post('fornecedor_desc');
            $fornecedor_id = $fornecedor_id + 0; // o PHP soma o começo que é um número e discarta o resto, melhor que substring =)
            $termo = $this->input->post('term');

//TODO: tem que buscar apenas os insumos que o fornecedor possui
//        $rs = new Insumo_x_fornecedor_model();
//        $rs->where('fornecedor_id', $fornecedor_id);
//        $ids = $rs->get()->to_array('insumo_id');

            $this->load->model('insumo_model');

            $rs = new Insumo_model();
//        $rs->where('id', $ids); 
            $rs->like('codigo', '%' . $termo . '%');
            $rs->or_like('descricao', '%' . $termo . '%');
            $rs->or_like('id', '%' . $termo . '%');

            foreach ($rs->get() as $r) {
                $data['result'][$r->id]['id'] = $r->id;
                $data['result'][$r->id]['descricao'] = "$r->id --- $r->descricao";
                $data['result'][$r->id]['label'] = "CD: $r->codigo, $r->descricao";
            }

            if (isset($data)) {
                $data['success'] = true;
                echo json_encode($data);
            }
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }

    function get_preco() {
        $insumo_id = $this->input->post('insumo_desc') + 0;
        $fornecedor_id = $this->input->post('fornecedor_desc') + 0;

        if ($insumo_id == 0 || $fornecedor_id == 0) {
            return;
        }

        $wheres['fornecedor_id'] = $fornecedor_id;
        $wheres['insumo_id'] = $insumo_id;

        $rs = new Insumo_x_fornecedor_model();
        $rs->where($wheres);

        $data = array();
        $data["total"] = $rs->get()->result_count();

        // tem que repetir, pois depois do get() o DataMapper apagar as clausulas wheres.
        $rs->where($wheres);
        
        $i =0;
         foreach ($rs->get() as $r) {
                $data['result'][++$i]['insumo_id'] = $r->insumo_id;
                $data['result'][++$i]['fornecedor_id'] = $r->fornecedor_id;
                $data['result'][++$i]['vigencia'] = $r->vigencia;
                $data['result'][++$i]['valor'] = $r->valor;
                $data['result'][++$i]['cadastro'] = $r->cadastro;
            }
        
        echo json_encode(var_dump($data));
    }
}

/* End of file insumo.php */
/* Location: ./application/modules/insumo/controllers/insumo.php */