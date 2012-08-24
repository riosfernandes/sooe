//scripts for login page to run properly
$(function(){
    $('#validation-summary').hide();
    
    // Closable function
    $('.closable').append('<span class="closelink" title="Close"></span>');
				
    $('.closelink').click(function() {
        $(this).parent().fadeOut(200);
    });
    
    /* realiza o submit da entrada do usuario
     * no sistema, validando os dados de entrada
     * e tratamento de sa�da
     **/
    $('#btnAlterarSenha').click(function(){
        $('#validation-summary').hide();
        
        //validar dados do usuario
        var login = $('#txtLogin').val();
        var password = $('#txtPassword').val();
        var password_new_1 = $('#txtPasswordNew1').val();
        var password_new_2 = $('#txtPasswordNew2').val();
        
        if(login.length == 0){
            showLoginErrors(['Login do usuário não informado!']);
            return false;
        }
        else if(password.length == 0){
            showLoginErrors(['Senha atual não informada!']);
            return false;
        }
        else if(password_new_1.length == 0){
            showLoginErrors(['Nova senha não informada!']);
            return false;
        }
        else if(password_new_2.length == 0){
            showLoginErrors(['Repetição da nova senha não informada!']);
            return false;
        }
        else if(password_new_1 != password_new_2){
            showLoginErrors(['A repetição da senha não confere com a nova senha!']);
            return false;
        }
        
        $.post(
            'login/alterar_senha',
            {
                login           :login,
                password        :password,
                password_new_1  :password_new_1,
                password_new_2  :password_new_2
            },
            function(data){
                if(data.success){
                    $(location).attr('href', data.url);
                }
                else{
                    showLoginErrors([data.message]);
                }
            },
            'json'
            );
    });    
    
    function showLoginErrors(msg){
        var divErro = $('#validation-summary').first();
        divErro.children('div').attr('style','');
        divErro.children('div').attr('display','block');
        divErro.children('div').find('p').remove();
        $.each(
            msg, 
            function(index, item){                
                divErro.children('div').append('<p>[' + ++index + '] ' + item + '</p>');
            });
        divErro.fadeIn(200);
    }
});