//scripts for login page to run properly
$(function(){
    $('#validation-summary').hide();
    
    //tab funciton
    $("ul.tabs").tabs("div.panes > div");
			
    // Closable function
    $('.closable').append('<span class="closelink" title="Close"></span>');
				
    $('.closelink').click(function() {
        $(this).parent().fadeOut(200);
    });
    
    /* realiza o submit da entrada do usuário
     * no sistema, validando os dados de entrada
     * e tratamento de saída
     **/
    $("#btnEntrar").click(function(){
        $('#validation-summary').hide();
        
        //validar dados do usuário
        var username = $('#fieldUsername').val();
        var password = $('#fieldPassword').val();        
        if(username.length == 0 || password.length == 0){
            showLoginErrors(['Dados de login não informados.']);
            return false;
        }
        
        $.post(
            'login/entrar',
            {
                username        :username,
                password        :password
            },
            function(data){
                if(data.success){
                    var url = 'welcome';
                    $(location).attr('href', url);
                }
                else{
                    showLoginErrors([data.message]);
                }
            },
            'json'
            );
    });
    
    /* captura de evento para recuração de
     * senha
     **/
    $('#btnRecuperar').click(function(){
        $('#validation-summary').hide();
        
        //validação de dados
        var login = $('#fieldUsername').val();
        var email = $('#fieldEmail').val();
        if(login.length == 0 && email.length == 0){
            showLoginErrors(["Necessário informar o usuário", "Necessário informar o e-mail!"]);
            return false;
        }
        else if(email.length == 0){
            showLoginErrors(['Necessário informar o e-mail!']);
            return false;
        }
        else if(login.length == 0){
            showLoginErrors(['Necessário informar o usuário!']);
            return false;
        }
        
        $.post(
            'login/recuperar_senha',
            {
                login   :login,
                email   :email
            },
            function(data){
                alert(data);
                if(data.success){
                    alert('A senha foi enviada para email cadastrado.');
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