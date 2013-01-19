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
            $data['result'][$r->id]['descricao'] = "$r->id :: [$r->codigo] $r->nome";
            $data['result'][$r->id]['label'] = "[$r->codigo] $r->nome";
        }

        if (isset($data['result']))
            $data['success'] = true;
        else
            $data['error'] = 'Nenhum fornecedor encontrado';

        echo json_encode($data);
    }

    public function find_insumo() {
        try {
            $termo = $this->input->post('term');

            $this->load->model('insumo_model');

            $rs = new Insumo_model();
            $rs->like('codigo', '%' . $termo . '%');
            $rs->or_like('descricao', '%' . $termo . '%');
            $rs->or_like('id', '%' . $termo . '%');

            foreach ($rs->get() as $r) {
                $data['result'][$r->id]['id'] = $r->id;
                $data['result'][$r->id]['descricao'] = "$r->id :: [$r->codigo] $r->descricao";
                $data['result'][$r->id]['label'] = "[$r->codigo] $r->descricao";
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
        $fornecedor_id = $this->input->post('fornecedor_desc') + 0;

        if ($fornecedor_id == 0) {
            return;
        }

        $wheres['fornecedor_id'] = $fornecedor_id;

        $rs = new Insumo_x_fornecedor_model();
        $rs->where($wheres);

        $data = array();
        $total_registros = $rs->get()->result_count();
        $data["total"] = $total_registros;

        if ($total_registros > 0) {
            // tem que repetir, pois depois do get() o DataMapper apagar as clausulas wheres.
            $rs->where($wheres);
            foreach ($rs->get() as $r) {
                //dados do insumo
                $insumo_model = new Insumo_model();
                $insumo_obj = $insumo_model->where('id', $r->insumo_id)->get();
                $insumo['id'] = $insumo_obj->id;
                $insumo['descricao'] = $insumo_obj->descricao;
                $insumo['codigo'] = $insumo_obj->codigo;
                $tipo_insumo_model = new Tipo_insumo_model();
                $tipo_insumo_obj = $tipo_insumo_model->where('id', $insumo_obj->tipo_insumo_id)->get();
                $tipo_insumo['id'] = $tipo_insumo_obj->id;
                $tipo_insumo['descricao'] = $tipo_insumo_obj->descricao;
                $insumo['tipo_insumo'] = $tipo_insumo;
                $tipo_unidade_model = new Tipo_unidade_model();
                $tipo_unidade_obj = $tipo_unidade_model->where('id', $insumo_obj->tipo_unidade_id)->get();
                $tipo_unidade['id'] = $tipo_unidade_obj->id;
                $tipo_unidade['descricao'] = $tipo_unidade_obj->descricao;
                $tipo_unidade['sigla'] = $tipo_unidade_obj->sigla;
                $insumo['tipo_unidade'] = $tipo_unidade;
                //dados do fornecedor
                $fornecedor_model = new Fornecedor_model();
                $fornecedor_obj = $fornecedor_model->where('id', $fornecedor_id)->get();
                $fornecedor['id'] = $fornecedor_obj->id;
                $fornecedor['nome'] = $fornecedor_obj->nome;
                $fornecedor['codigo'] = $fornecedor_obj->codigo;
                
                $data['result'][$r->insumo_id]['insumo'] = $insumo;
                $data['result'][$r->insumo_id]['fornecedor'] = $fornecedor;
                $data['result'][$r->insumo_id]['vigencia'] = strftime("%d/%m/%Y %H:%M:%S", strtotime($r->vigencia));
                $data['result'][$r->insumo_id]['valor'] = $r->valor;
                $data['result'][$r->insumo_id]['cadastro'] = $r->cadastro;
            }
        }
        
        echo $this->load->view('preco_insumo', $data);
    }

}

/* End of file insumo.php */
/* Location: ./application/modules/insumo/controllers/insumo.php */