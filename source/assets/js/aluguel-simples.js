$(function(){    
    //controla visibilidade dos steps (1, 2 ou 3)
    $('#step-2').find('li').attr('class', 'disabled');
    $('#step-3').find('li').attr('class', 'disabled');
    
    //esconder as tables de quadras
    $("#painel-quadras-livres").hide();
    $("#painel-quadras-reserva").hide();    

    //carrega o combo dos tipos de quadra
    $('#tipo_quadra').load('aluguel_simples/get_tipo_quadra_drop_down');        
    
    //carrega o combo dos clientes
    $('#cliente').load('aluguel_simples/get_clientes_drop_down');
    
    /* captura evento 'onChange' para o combo de tipo de quadra
     * carregando os horários quando o mesmo modifica
     **/
    $('#tipo_quadra').change(function(){
        carregarHorario($(this).val());
    });
        
    /* captura evento 'onChange' do combo de horários
     * carregando as quadras quando o mesmo modifica
     **/
    $('#horarios').change(function(){
        carregarQuadras();
    });
    
    /* captura evento 'onClick' para a quadra.
     * permite que ao clicar na quadra livre
     * o usuário esteja adicionando o mesmo ao grid de
     * quadras para reserva
     **/
    $('#quadraslivres input').live('click', function(){
        /* Utilizamos 'live' para atribuir o evento click ao link
         * isso porque criamos dinamicamente esse elemento
         * ele ainda não está no DOM, quando o jQuery vai executar
         **/                
        var column = $(this).parent(); //o $(this) pega a tag <a> e o parent pega a tag <td>
        var row = column.parent(); //pega a tag <tr>
        row.first().find('.add').removeClass('add').addClass('remove'); //modifica a classe do button
        $('#quadrasreservatable').append(row); //inclui a row com o link alterado na table de quadras para reserva
        var div = $('#quadraslivrestable');        
        if(div.find('td').length == 0){
            div.parent().parent().hide();
        }
        $('#painel-quadras-reserva').show(); //habilitar a div que irá exibir as quadras para reserva
        return false;
    });    
     
    /* captura evento 'onClick' para a quadra.
     * permite que ao clicar na quadra livre
     * o usuário esteja removendo uma quadra
     * de reserva tornando-a disponível
     **/
    $('#quadrasreserva input').live('click', function(){
        /* Utilizamos 'live' para atribuir o evento click ao link
         * isso porque criamos dinamicamente esse elemento
         * ele ainda não está no DOM, quando o jQuery vai executar
         **/
        var column = $(this).parent(); //o $(this) pega a tag <a> e o parent pega a tag <td>
        var row = column.parent(); //pega a tag <tr>
        row.first().find('.remove').removeClass('remove').addClass('add'); //modifica a classe do button
        $('#quadraslivrestable').append(row); //inclui a row com o link alterado na table de quadras livres
        var div = $('#quadrasreservatable');        
        if(div.find('td').length == 0){
            div.parent().parent().hide();
        }
        $('#painel-quadras-livres').show(); //habilitar a div que irá exibir as quadras livres
        return false;
    });
    
    /* captura evento 'onClick' do botão 'btnSubmit'
     * que realiza o post de reserva de quadras.
     **/    
    $('#btnSubmit').click(function(){
        /* obter as quadras informadas
         * pelo usuário para reserva.
         **/
        var cliente = $('#cliente').val();
        var quadras = new Array();
        var i = 0;
        $('#quadrasreserva td').each(function(){
            if($(this).attr('quadraId') == "1"){
                quadras[i] = $(this).html();
                i++;
            }
        });
        //validações
        if(cliente == "-1"){
            alert('Informe o cliente para reserva.');
            return false;
        }
        if(quadras.length == 0){
            alert('Nenhuma quadra foi informada para reserva!');
            return false;
        }
        else if(quadras.length > 1){
            alert('Somente uma quadra pode ser reservada!');
            return false;
        }
        
        //post passando os parâmetros via json
        $.post("aluguel_simples/reservar/",
        {
            Data                            : $("#data_reserva").val(),
            Horario                         : $("#horarios").val(),
            Cliente                         : $("#cliente").val(),
            Quadras                         : quadras,
            Qtde_Horarios                   : $("#qtde_horarios").val()
        },        
        function(data){
            if(data.success){
                $(location).attr('href', 'aluguel_simples');
                alert("Reserva solicitada efetuada com sucesso!");
            }
            else{
                alert(data.message);
            }
        },
        "json"
        );
        
        return false;
    });    
    
    /* carrega os horários com base no
     * tipo de horário informado
     **/
    function carregarHorario(tipoHorario){        
        if(!tipoHorario)
            return;
        
        var data = $('#data_reserva').val();
        
        $('#quadras').html('');        
        var horarios = $('#horarios');
        horarios.html('<option>Carregando...</option>').load('aluguel_simples/get_horarios/', {
            tipo_quadra:tipoHorario,
            data_reserva:data
        });
    }
    
    /* realiza a carga de quadras para um horário
     * informado.
     **/
    function carregarQuadras(){
        var horario = $('#horarios').val();
        
        var quadraslivres = $('#quadraslivres')        
        if(horario != null){
            $("#painel-quadras-livres").show();
            quadraslivres.html('<p>Carregando...</p>');
            quadraslivres.load('aluguel_simples/get_quadras/', {
                horario:horario
            });
        }
        else{
            quadraslivres.html('<p>Nenhuma quadra disponível para o horário!</p>');
        }
    }
});