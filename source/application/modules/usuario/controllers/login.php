<?php
//@todo: salvar na base o id da session?
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Login extends MY_Controller_Admin {

    var $error;

    function __construct() {
        parent::__construct();
    }

    function index() {
        //validation rules
        $this->load->library('form_validation');
        $this->form_validation->set_rules('username', 'username', 'required');
        $this->form_validation->set_rules('password', 'password', 'trim|required|md5');
        $this->form_validation->set_error_delimiters('<div class="error">', '</div>');

        //método utilizando o post via jquery
        $this->loadLogin();
    }

    private function loadLogin() {
        $data['titulo'] = 'Login';
        $data['css_files'] = array('login');
        $data['js_files'] = array('jquery-1.7.2.min', 'jquery.tools.min', 'login');

        $this->load->view('login', $data);
    }

    function entrar() {
        //obter o usuário e a senha e tentar efetuar o login
        $usuario = isset($_POST['username']) ? $_POST['username'] : '';
        $senha = isset($_POST['password']) ? $_POST['password'] : '';

        //validar
        if ($usuario == "" || $senha == "") {
            $var = array(
                'success' => false,
                'message' => htmlentities('Dados do usuário não informados')
            );
            echo json_encode($var);
            return false;
        }

        $this->load->model('usuario_model');

        $u = new Usuario_model();
        $u->where('login', $usuario);
//      @todo: permitir ao usuário trocar o hash padrão
        $u->where('senha', md5($senha));
//      @todo: Recuperar da configuração do sistema
//      $u->where('situacao_id', 2);
        $u->get(1);

        if ($u->result_count() == 0) {
            $var = array(
                'success' => false,
                'message' => htmlentities('Usuário não localizado')
            );
            echo json_encode($var);
            return false;
        }
        
        $situacao = new Situacao_usuario_model();
        $s = $situacao->get($u->situacao_usuario_id);
        
        if($s == "Novo" || $s == "Expirado"){
            $this->trocar_senha($u);
        }
        else if($s == "Inativo"){
            $var = array(
                'success' => false,
                'message' => htmlentities('Usuário inativo!')
            );
            echo json_encode($var);
            return false;
        }

        // insere data e hora do ultimo login
        $u->update('ultimo_acesso', date("Y-m-d H:i:s"));

        /* salva na session o usuário, o cooke só guarda 4KB, 
         * talvez seja necessário salvar apenas o id do usuario
         */
        $usuario = array(
            'id' => $u->id,
            'nome' => $u->nome,
            'login' => $u->login,
            'email' => $u->email,
            'tipo_usuario_id' => $u->tipo_usuario_id,
            'situacao_id' => $u->situacao_id,
            'senha' => $u->senha,
            'ultima_troca' => $u->ultima_troca,
            'ultimo_acesso' => $u->ultimo_acesso
        );

        $this->session->set_userdata('usuario_logado', $usuario);

        $var = array(
            'success' => true,
            'usuario' => array('login' => $usuario['login'], 'nome' => $usuario['nome']),
            'url' => site_url('welcome')
        );
        echo json_encode($var);
        return TRUE;
    }

    function trocar_senha() {
//        @todo: trocar senha
//        insere data e hora do ultima troca de login
//        $u->update('ultima_troca', date("Y-m-d H:i:s"));
    }

    function logout() {
        $this->session->unset_userdata('usuario_logado');
        $this->session->sess_destroy();
        redirect('login');
    }

    function recuperar_senha() {
//        @todo: fazer a recuperação de senha enviando e-mail para o usuário
//        try {
//            $login = isset($_POST['login']) ? $_POST['login'] : '';
//            $email = isset($_POST['email']) ? $_POST['email'] : '';
//
//            $usuario = new Usuario_model();
//            $usuario->where('login', $login);
//            $usuario->where('email', $email);
//            $usuario->get(1);
//
//            if ($usuario->result_count() != 1) {
//                $var = array(
//                    'success' => false,
//                    'message' => htmlentities('Usuário informado não localizado')
//                );
//                echo json_encode($var);
//                return false;
//            }
//
//            $this->enviar_email(
//                    $usuario->email,
//                    $usuario->senha);
//
//            $var = array(
//                'success' => true
//            );
//            echo json_encode($var);
//            return true;
//        } catch (Exception $e) {
//            $var = array(
//                'success' => false,
//                'message' => htmlentities($e->getMessage())
//            );
//            echo json_encode($var);
//            return false;
//        }
    }

    private function enviar_email($email, $senha) {
        /* @todo: implementar o envio de email para o usuário
         * @todo: logar a solicitação de senha por email informando
         * o usuário.
         */
//        $mensagem = 'Senha para acesso solicitada: ' + senha;
//
//        $this->load->library('email');
//
//        $this->email->from('voce@seu-site.com', 'Seu Nome');
//        $this->email->to(email);
//        $this->email->cc('outro@outro-site.com');
//        $this->email->bcc('fulano@qualquer-site.com');
//
//        $this->email->subject('Recuperação de senha');
//        $this->email->message($mensagem);
//
//        $this->email->send();
    }
}

/* End of file login.php */
/* Location: ./application/modules/usuario/controllers/login.php */