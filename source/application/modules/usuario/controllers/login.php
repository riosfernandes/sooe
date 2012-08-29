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
        $this->load_login();
    }

    private function load_login() {
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

        /* verificar a situação do usuário que está
         * tentando efetuar login 
         */
        $situacao = new Situacao_usuario_model();
        $s = $situacao->where('id', $u->situacao_usuario_id)->get();

        if ($s->descricao == "Novo") {
            $var = array(
                'success' => false,
                'trocar_senha' => true,
                'url' => 'login/load_alterar_senha?login=' . $u->login,
                'message' => htmlentities('Bem vindo, ' . $u->nome . '! Efetue a troca de sua senha de acesso.')
            );
            echo json_encode($var);
            return false;
        } else if ($s->descricao == "Expirado") {
            $var = array(
                'success' => false,
                'trocar_senha' => true,
                'url' => 'login/load_alterar_senha',
                'message' => htmlentities('Você não realiza login no sistema a muito tempo, sendo assim, você deve realizar a troca de sua senha de acesso!')
            );
            echo json_encode($var);
            return false;
        } else if ($s->descricao == "Inativo") {
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

    function load_alterar_senha() {
        $data['login'] = isset($_GET['login']) ? $_GET['login'] : '';
        $data['titulo'] = 'Login';
        $data['css_files'] = array('alterar_senha');
        $data['js_files'] = array('jquery-1.7.2.min', 'jquery.tools.min', 'alterar_senha');

        $this->load->view('alterar_senha', $data);
    }

    function alterar_senha() {
        try {
            $login = isset($_POST['login']) ? $_POST['login'] : '';
            $password = isset($_POST['password']) ? $_POST['password'] : '';
            $password_new_1 = isset($_POST['password_new_1']) ? $_POST['password_new_1'] : '';
            $password_new_2 = isset($_POST['password_new_2']) ? $_POST['password_new_2'] : '';

            //salvando o hash da senha
            $password_hash = md5($password);
            $password_new_hash = md5($password_new_1);

            /*
             * validar entradas do usuário
             */
            if (strlen($login) == 0) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Login do usuário não informado!')
                );
                echo json_encode($var);
                return false;
            } else if (strlen($password) == 0) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Senha atual do usuário não informada!')
                );
                echo json_encode($var);
                return false;
            } else if (strlen($password_new_1) == 0) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Nova senha não informada!')
                );
                echo json_encode($var);
                return false;
            } else if (strlen($password_new_2) == 0) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Confirmação de nova senha não informada!')
                );
                echo json_encode($var);
                return false;
            } else if ($password_new_1 !== $password_new_2) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Confirmação de senha não confere com a nova senha informada!')
                );
                echo json_encode($var);
                return false;
            }

            /*
             * localizar usuário pelo login e senha 
             */
            $usuario = new Usuario_model();
            $u = $usuario->where('login', $login)->where('senha', $password_hash)->get(1);
            if (count($u->all) == 0) {
                $var = array(
                    'success' => false,
                    'message' => htmlentities('Usuário informado não encontrado ou a senha informada não é a senha atual de acesso!')
                );
                echo json_encode($var);
                return false;
            } else {
                /*
                 * testar se a nova senha é igual a uma das últimas
                 * senhas informadas pelo usuário, se for
                 * não permitir seu uso. 
                 */
                if($password_new_hash == $password_hash){
                    $var = array(
                        'success' => false,
                        'message' => htmlentities('A senha não pode ser identica a senha atual!')
                    );
                    echo json_encode($var);
                    return false;
                }
                if ($password_new_hash == $u->senha_anterior1 ||
                        $password_new_hash == $u->senha_anterior2 ||
                        $password_new_hash == $u->senha_anterior3) {
                    $var = array(
                        'success' => false,
                        'message' => htmlentities('A senha não pode ser identica as últimas 3 já informadas!')
                    );
                    echo json_encode($var);
                    return false;
                }

                /*
                 * obter a situação de usuário ativo 
                 */
                $situacao = new Situacao_usuario_model();
                $s = $situacao->where('descricao', 'Ativo')->get(1);
                if (count($s->all) == 0)
                    throw new Exception('Situação "Ativo" não existente!');

                /*
                 * efetuar a troca de senha do usuário 
                 */
                $u->senha_anterior3 = $u->senha_anterior2;
                $u->senha_anterior2 = $u->senha_anterior1;
                $u->senha_anterior1 = $u->senha;
                $u->senha = md5($password_new_1);
                $u->ultima_troca = date('Y-m-d H:i:s');
                $u->ultimo_acesso = date('Y-m-d H:i:s');
                $u->situacao_usuario_id = $s->id;
                $u->save();

                /*
                 * incluir o usuário na session 
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

                /*
                 * direcionar para página principal do sistema 
                 */
                $var = array(
                    'success' => true,
                    'url' => site_url('welcome'),
                    'message' => htmlentities('Troca efetuada com sucesso!')
                );
                echo json_encode($var);
                return true;
            }
        } catch (Exception $ex) {
            $var = array(
                'success' => false,
                'message' => htmlentities($ex->getMessage())
            );
            echo json_encode($var);
            return false;
        }
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