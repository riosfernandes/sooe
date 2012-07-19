<?php

//OBSOLETO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//@todo: transformar em abstract e incluir um validation para inserir, alterar e deletar
class Grud_library extends CI_Controller {

    private $table;

    function __construct($table = '') {
        $this->table = $table;
    }

    public function getAll($count = NULL) {
        $ci = & get_instance();
        $query = $ci->db->get($this->table, $count);
        return $query->result();
    }

    function add($dados = array()) {
        $ci = &get_instance();
        $ci->db->insert($this->table, $dados);
        return $ci->db->affected_rows();
    }

    //@todo: fazer delete
    function delete() {
        //@todo: limpar campos antes de mandar para a base
        //@todo: Recuperar o id
        $ci = &get_instance();
        $ci->db->where('id', $ci->uri->segment(3));
        $ci->db->delete('usuario');
        return $ci->db->affected_rows();
    }

    //@todo: terminar update
    function update($dados = array()) {
        //@todo: limpar campos antes de mandar para a base
        $ci = &get_instance();
        foreach ($dados as $key => $value) {
            $ci->db->set($key, $value);
        }

        $ci->db->where('id', $dados['id']);
        $ci->db->update($this->table);

        return $ci->db->affected_rows();
    }

    public function getByID($id) {
        $ci = &get_instance();
        $ci->db->where('id', $id);
        $query = $ci->db->get($this->table);

        return $query->row(0);
    }

}

?>
