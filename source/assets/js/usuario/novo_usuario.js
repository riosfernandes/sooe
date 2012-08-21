$(function(){    
    //carrega o combo dos tipos de quadra
    $('#cmbGrupoUsuario').load('usuario/get_grupos_usuario_dropdown');
    $('#cmbTipoUsuario').load('usuario/get_tipos_usuario_dropdown');
});