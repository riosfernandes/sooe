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

    public function show_preco_insumo() {
        $this->template->set(
                'css_files', array(
            $this->get_css_formatado('insumo'),
            $this->get_css_formatado('flexigrid/flexigrid'),
            $this->get_css_formatado('flexigrid/flexigrid.pack')
                )
        );
        $this->template->set('js_files', array(
            $this->get_js_formatado('flexigrid/flexigrid'),
            $this->get_js_formatado('flexigrid/flexigrid.pack'),
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

    public function get_preco() {
        $fornecedor_id = $this->input->post('fornecedor_desc') + 0;

        if ($fornecedor_id == 0) {
            return;
        }

        $insumo_id = $this->input->post('insumo_desc') + 0;

        $page = 1;
        $sortname = 'id';
        $sortorder = 'asc';
        $qtype = '';  // Search column
        $query = '';  // Search string

        if (isset($_POST['insumo_desc'])) {
            $insumo_id = $this->input->post('insumo_desc') + 0;
        }
        if (isset($_POST['page'])) {
            $page = $this->input->post('page');
        }
        if (isset($_POST['sortname'])) {
            $sortname = $this->input->post('sortname');
        }
        if (isset($_POST['sortorder'])) {
            $sortorder = $this->input->post('sortorder');
        }
        if (isset($_POST['qtype'])) {
            $qtype = $this->input->post('qtype');
        }
        if (isset($_POST['query'])) {
            $query = $this->input->post('query');
        }
        if (isset($_POST['rp'])) {
            $rp = $this->input->post('rp');
        }

        $pageStart = ($page - 1) * $rp;

        $rs = new Fornecedor_model();
        $rs->start_cache();
        $rs->where('id', $fornecedor_id);
        $rs->stop_cache();
        $total_registros = $rs->get()->result_count();

        $data = array();
        $data["total"] = $total_registros;
        $data['page'] = $page;
        $data['rows'] = array();

        if ($qtype != '' && $query != '')
            $rs->insumo->like($qtype, $query);

        if ($insumo_id != 0)
            $rs->insumo->where('id', $insumo_id);

        $rs->insumo->get($rp, $pageStart);

        $is_insumo_especifico = ($insumo_id != 0);


        if ($is_insumo_especifico) {
            $custo = new Insumo_x_fornecedor_model();
            $custo->start_cache();
            $custo->where('insumo_id', $rs->insumo->id);
            $custo->where('fornecedor_id', $rs->id);
            $custo->where('deleted', 0);
            $custo->stop_cache();

            foreach ($custo->get() as $c) {
                $vigencia = strftime("%Y-%m-%d %H:%M:%S", strtotime($c->vigencia));
                $id = $rs->insumo->id;
                $data['rows'][] = array(
                    'id' => $id,
                    'cell' =>
                    array(
                        'insumo_id' => $rs->insumo->id,
                        'insumo_des' => $rs->insumo->descricao,
                        'insumo_un' => $rs->insumo->unidade->get()->sigla,
                        'vigencia' => $vigencia,
                        'valor' => $c->valor
                    )
                );
            }
        } else {
            $id;
            foreach ($rs->insumo as $insumo) {

                if (empty($id) || $id != $insumo->id)
                    $id = $insumo->id;
                else
                    continue;

                $custo = new Insumo_x_fornecedor_model();
                $custo->start_cache();
                $custo->where('insumo_id', $insumo->id);
                $custo->where('fornecedor_id', $rs->id);
                $custo->where('deleted', 0);
                $custo->stop_cache();
                $custo->select_max('vigencia'); // filtra por vigencia
                $vigencia = $custo->get()->vigencia;
                
                if($vigencia == NULL)
                    continue;
                
                $custo->where('vigencia', $vigencia);
                $valor = $custo->get()->valor;
                if($valor == NULL)
                    continue;

                $data['rows'][] = array(
                    'id' => $insumo->id,
                    'cell' =>
                    array(
                        'insumo_id' => $insumo->id,
                        'insumo_des' => $insumo->descricao,
                        'insumo_un' => $insumo->unidade->get()->sigla,
                        'vigencia' => strftime("%Y-%m-%d %H:%M:%S", strtotime($vigencia)),
                        'valor' => $valor
                    )
                );
            }
        }

        echo json_encode($data);
    }

    public function add_preco() {

        try {
            $fornecedor_id = $this->input->post('fornecedor_des') - 0;
            $insumo_id = $this->input->post('insumo_des') - 0;
            $valor = $this->input->post('valor');
            $vigencia = $this->input->post('vigencia');

            if ($fornecedor_id == 0 || $insumo_id == 0 || $valor == 0 || $vigencia == '') {
                return;
            }

            $vigencia = date('Y-m-d', strtotime($vigencia));

            $rs = new Insumo_x_fornecedor_model();
            $rs->fornecedor_id = $fornecedor_id;
            $rs->insumo_id = $insumo_id;
            $rs->vigencia = $vigencia;
            $rs->valor = $valor;
            $rs->save();

            $data['sucess'] = TRUE;
        } catch (Exception $e) {
            $data['sucess'] = FALSE;
            $data['error'] = $e->getMessage();
        }

        echo json_encode($data);
    }

    public function remove_preco() {

        try {
            $fornecedor_id = $this->input->post('fornecedor_desc') - 0;
            $insumo_id_list = $this->input->post('insumo_id_list');

            if ($fornecedor_id == 0 || $insumo_id_list == 0) {
                throw new Exception("Fornecedor ou insumo inválido!");
            }

            foreach ($insumo_id_list as $item) {
                $rs = new Insumo_x_fornecedor_model();
                $rs->where('vigencia', $item['vigencia']);
                $rs->where('fornecedor_id', $fornecedor_id);
                $rs->where('insumo_id', $item['insumo_id'])->update(array('deleted' => 1, 'date_deleted' => date('Y-m-d G:i:s')));
            }

            $data['sucess'] = TRUE;
        } catch (Exception $e) {
            $data['sucess'] = FALSE;
            $data['error'] = $e->getMessage();
        }

        echo json_encode($data);
    }

}

/* End of file insumo.php */
/* Location: ./application/modules/insumo/controllers/insumo.php */