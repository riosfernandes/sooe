<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Aluguel_simples extends MY_Non_Public_Controller {

    function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->load_view();
    }

    private function load_view() {
        $this->template->set('titulo', 'Aluguel Simples');
        $this->template->set('subtitle', 'Aluguel Simples');
        $this->template->set('css_files_aditional', array($this->get_css_formatado('reserva-simples')));
        $this->template->set('js_files_aditional', array($this->get_js_formatado('aluguel-simples')));
        $this->template->load('template_teste', 'aluguel_simples');
    }

    public function get_horarios() {
        $tipo_quadra = $this->input->post('tipo_quadra');
        $data = $this->date_converter($this->input->post('data_reserva'));

        //recupera todas as quadras validas do tipo selecionado
        $quadras = new Quadra_model();

        $quadras->where('situacao_quadra_id', SITUACAO_QUADRA_ID);
        $quadras->where('tipo_quadra_id', $tipo_quadra);

        $q = $quadras->get();
        $horarios = $this->get_horarios_disponiveis($q, $data);

        foreach ($horarios as $h) {
            $dados['horarios'][$h] = $h;
        }
        //preenche os options do select box com os horários        
        $this->load->view('reserva-simples/monta_horarios', $dados);
    }

    private function get_horarios_disponiveis($quadras, $data) {
        $horarios_disponiveis = array();

        //seram salvos na session
        $horarios_disponiveis_quadra = array();

        foreach ($quadras as $q) {
            //pega a unidade de tempo
            $unidade_tempo = $this->get_unidade_tempo_vigente($q);

            //pegar horario funcionamento
            $horario_funcionamento = $this->get_horario_funcionamento_vigente($q);

            $hora_inicio = substr($horario_funcionamento->horario_inicio, 0, 2);
            $minuto_inicio = substr($horario_funcionamento->horario_inicio, 3, 2);
            $data_inicio = mktime($hora_inicio, $minuto_inicio);

            $hora_fim = substr($horario_funcionamento->horario_fim, 0, 2);
            $minuto_fim = substr($horario_funcionamento->horario_fim, 3, 2);
            $data_fim = mktime($hora_fim, $minuto_fim);

            $hora_temp = $data_inicio;
            $array_horas_possiveis = array();

            while (!($hora_temp > $data_fim)) {
                array_push($array_horas_possiveis, strftime("%H:%M", $hora_temp));
                $hora_temp += $unidade_tempo->qtde_minutos * 60;
            }

            //salva os dados necessários na quadra
            $horarios_reservados = $this->get_horarios_reservados($q, $data);

            //confronta os horários disponíveis com os já reservados
            $horarios_disponiveis_quadra_atual = array_diff($array_horas_possiveis, $horarios_reservados);

            //adiciona os horários disponíveis que não sejam repetidos para outras quadras
            $horarios_disponiveis = array_merge($horarios_disponiveis, $horarios_disponiveis_quadra_atual);

            //salva os dados necessários na quadra
            $horarios_disponiveis_quadra[$q->id] = $horarios_disponiveis_quadra_atual;
        }

        //salva na session
        $this->session->set_userdata("horarios_disponiveis_quadra", $horarios_disponiveis_quadra);

        return $horarios_disponiveis;
    }

    private function get_horarios_reservados($quadra, $data) {
        $aluguel_simples = new Aluguel_simples_model();
        $aluguel_simples->where('quadra_id', $quadra->id);
        $aluguel_simples->where('data_reserva', $data);
        
        $arraytemp = array();
        
        foreach ($aluguel_simples->get() as $h) {
            $temp = $h->hora_reserva;
            if(isset($temp)){
                $temp = substr($temp, 0, 5);
                array_push($arraytemp, $temp);
            }            
        }
        
        return $arraytemp;
    }

    private function get_tipo_quadra() {
        if (!isset($this->tipos_quadra)) {
            $tq = new Tipo_quadra_model();
            $this->tipos_quadra = $tq->get();
        }

        return $this->tipos_quadra;
    }

    public function get_tipo_quadra_drop_down() {
        $this->get_tipo_quadra();

        //carregar a tela que monta os tipos de quadra
        foreach ($this->tipos_quadra as $t) {
            $dados['tipos_quadra'][$t->id]['id'] = $t->id;
            $dados['tipos_quadra'][$t->id]['descricao'] = $t->descricao;
        }
        $this->load->view('reserva-simples/monta_tipos_quadra', $dados);
    }

    public function get_clientes_drop_down() {
        $this->get_clientes();

        //monta os clientes através da tela 'monta_clientes'
        foreach ($this->clientes as $c) {
            $dados['clientes'][$c->id]['id'] = $c->id;
            $dados['clientes'][$c->id]['nome'] = $c->nome;
        }
        $this->load->view('reserva-simples/monta_clientes', $dados);
    }

    private function get_horario_funcionamento_vigente($quadra) {
        $horario_funcionamento = new Horario_funcionamento_model();
        $horario_funcionamento->where("quadra_id", $quadra->id);
        $horario_funcionamento->select_max('vigencia');  //@todo: pegar a maior vigencia menor que hoje
        $horario_funcionamento->where("vigencia", $horario_funcionamento->get()->vigencia);
        $horario_funcionamento->select();
        $horario_funcionamento->get();

        if ($horario_funcionamento->result_count() == 0)
            throw new Exception(); //@todo: lançar exception especifico

        return $horario_funcionamento;
    }

    private function get_unidade_tempo_vigente($quadra) {
        $unidade_tempo = new Unidade_tempo_model();
        $unidade_tempo->where("quadra_id", $quadra->id);
        $unidade_tempo->select_max('vigencia');
        $unidade_tempo->where("vigencia", $unidade_tempo->get()->vigencia);
        $unidade_tempo->select();
        $unidade_tempo->get();

        if ($unidade_tempo->result_count() == 0)
            throw new Exception(); //@todo: lançar exception especifico

        return $unidade_tempo;
    }

    public function get_quadras() {
        try {
            $hora = $this->input->post('horario'); //$this->get_hora_post();
            $quadras_horario_selecionado = array();

//            pega horario da session
            $horarios_disponiveis_quadra = $this->session->userdata("horarios_disponiveis_quadra");

            if (!isset($horarios_disponiveis_quadra)) {
                throw new Exception("Horários disponíveis não encontrados na Session");
            }

//            recupera quadras com base no horário selecionado
            $quadras_id = array();
            foreach ($horarios_disponiveis_quadra as $key => $value) {
                if (array_search($hora, $value) !== FALSE)
                    array_push($quadras_id, $key);
            }

            if (!isset($quadras_id) || array_count_values($quadras_id) == 0)
                throw new Exception("Não foi possível recuperar ids das quadras para o horário selecionado " + $hora);

            $quadras = new Quadra_model();
            $quadras->where('situacao_quadra_id', SITUACAO_QUADRA_ID);
            $quadras->where_in('id', $quadras_id);
            $quadras_horario_selecionado = $quadras->get();

            if (!isset($quadras_horario_selecionado))
                throw new Exception("Nenhuma quadra encontrada com disponibilidade para o horário selecionado " + $hora);
            else {
                /* montar array com os dados necessários das quadras
                 * para visualização na view "grid_quadras_livres.
                 */
                foreach ($quadras_horario_selecionado as $q) {
                    $data['quadras'][$q->id]['id'] = $q->id;
                    $data['quadras'][$q->id]['descricao'] = $q->descricao;
                }
                $this->load->view('reserva-simples/grid_quadras_livres', $data);
            }
        } catch (Exception $exc) {
            echo '<p>Problemas ao localizar quadras disponíveis. Erro: ' . $exc->getMessage() . '</p>';
        }
    }

    private function get_qtde_seq_unidade_tempo($quadra, $hora) {
        $horas_disponiveis = array_diff($quadra['horas_possiveis'], $quadra['horarios_reservados']);

        if (!isset($horas_disponiveis) || $horas_disponiveis == NULL || array_count_values($horas_disponiveis) == 0)
            throw new Exception(); //@todo: fazer throw especifico;

        $count = 0;
        foreach ($horas_disponiveis as $h) {
            if ($h == $hora) {
                $count++;
                $hora += $quadra['qtde_minutos'];
            }
        }

        return $count;
    }

    private function get_preco_vigente($quadra_id) {
        $preco = new Preco_model();
        $preco->where("quadra_id", $quadra_id);
        $preco->select_max('vigencia');
        $preco->where("vigencia", $preco->get()->vigencia);
        $preco->select();
        $preco->get();

        if ($preco->result_count() == 0)
            throw new Exception(); //@todo: lançar exception especifico

        return $preco;
    }

    private function get_clientes() {
        if (!isset($this->clientes)) {
            $cliente = new Cliente_model();
            $cliente->select();
            $this->clientes = $cliente->get();
        }
        return $cliente;
    }

    private function has_this_hour($hora, $quadra) {
        if (!isset($quadra->horarios_disponiveis) || $quadra->horarios_disponiveis == NULL || array_count_values($quadra->horarios_disponiveis) == 0)
            return FALSE;

        foreach ($quadra->horarios_disponiveis as $h) {
            if (strcasecmp($h, $hora) == 0)
                return TRUE;
        }

        return FALSE;
    }

    public function pesquisa_cliente() {
        $cliente_nome = $this->input->post('nome');
        $cliente_documento = $this->input->post('documento');

        $c = new Cliente_model();
        $c->like('nome', $cliente_nome);
        $c->or_like('documento', $cliente_documento);
        return $c->get();
    }

    public function reservar() {
        try {
            $data = isset($_POST['Data']) ? $_POST['Data'] : '';
            $horario = isset($_POST['Horario']) ? $_POST['Horario'] : '';
            $cliente = isset($_POST['Cliente']) ? $_POST['Cliente'] : '';
            $quadras = isset($_POST['Quadras']) ? $_POST['Quadras'] : '';
            $qtde_horarios = isset($_POST['Qtde_Horarios']) ? $_POST['Qtde_Horarios'] : '';

            $as = new Aluguel_simples_model();
            $as->cliente_id = $cliente;
            $as->quadra_id = $quadras[0];
            $as->data_reserva = $this->date_converter($data);
            $as->hora_reserva = $horario;
            $as->qtde_unidade_tempo = $qtde_horarios;
            $as->cadastro = date('Y-m-d H:i:s');

            $retorno = $as->save();
            if (!$retorno) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities($retorno)
                );
                echo json_encode($var);
                return false;
            }

            $var = array('success' => true);
            echo json_encode($var);
            return true;
        } catch (Exception $e) {
            $var = array(
                'success' => false,
                'message' => htmlentities($e->getMessage())
            );
            echo json_encode($var);
            return false;
        }
    }

// <editor-fold defaultstate="collapsed" desc="<:: CRUD ::>">

    public function create($post_array) {
        $date = $post_array['data_reserva'];
        sscanf($date, "%d/%d/%d", $d, $m, $y);
        $date = sprintf("%d-%d-%d", $y, $m, $d);

        $a = new Aluguel_simples_model();
        $a->cliente_id = $post_array['cliente_id'];
        $a->quadra_id = $post_array['quadra_id'];
        $a->data_reserva = $date;
        $a->hora_reserva = $post_array['hora_reserva'];
        $a->qtde_unidade_tempo = $post_array['qtde_unidade_tempo'];

        $a->cadastro = date("Y-m-d H:i:s");

        $retorno = $a->save();

        if (!$retorno) {
            return FALSE;
        }
    }

// </editor-fold>
}

/* End of file aluguel_simples.php */
/* Location: ./application/controllers/aluguel_simples.php */