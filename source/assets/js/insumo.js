$(main);

function main()
{        
    $("#div_insumo").hide();
    $("#divTableResult").hide();
    $('#form_preco').hide();

    $('#fornecedor').autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "insumo/find_fornecedor",
                type: 'POST',
                dataType: "json",
                data: {
                    'term'          : request.term
                },
                success: function( data ) {
                    response( $.map( data.result, function( item ) {
                        return {
                            id: item.id,
                            label: item.label,
                            value: item.descricao
                        }
                    }));
                }
            });
        },
        minLength: 3,
        select: function( event, ui ) {     
            $("#div_insumo").show();
            $('#insumo').focus();
            slide_down_callback_preco();
            select_insumo(event, ui);
        }
    });  
    
    $('#insumo').autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "insumo/find_insumo",
                type: 'POST',
                dataType: "json",
                data: {
                    'term'                     : request.term,
                    'fornecedor_desc'          : $('#fornecedor').val()
                },
                success: function( data ) {
                    response( $.map( data.result, function( item ) {
                        return {
                            id: item.id,
                            label: item.label,
                            value: item.descricao
                        }
                    }));
                }
            });
        },
        minLength: 3,
        select: function( event, ui ) {
            slide_down_callback_preco();
        }
    });
}
//
//function filter_preco(event, ui){
//    /* filtrar os preços listados conforme o
//     * insumo informado.
//     **/
//    $('#form_preco').load('insumo/get_preco',
//    {
//        fornecedor_desc         :$('#fornecedor').val(),
//        insumo_desc             :$('#insumo').val()
//    });
//}

function select_insumo(event, ui ){
    /* a lista de preços já associados deve surgir para o usuário visualizar logo após a seleção do     
     **/
    $('#form_preco').show();
//    $('#form_preco').slideDown('0', slide_down_callback_preco); // garante que só seja executado após o slow acontecer
}

function slide_down_callback_preco(){
    /*listar os preços para o fornecedor
     *e insumo selecionados */            
    resultado = $("#resultado");
            
    resultado.html('<p>Carregando...</p>');
    resultado.load('insumo/get_preco',
    {
        fornecedor_desc         :$('#fornecedor').val(),
        insumo_desc             :$('#insumo').val()
    },
    callback_insumo);
}


function callback_insumo(data){
    $('#btn_incluir_preco').click(add_preco);
    $('#txt_data_vigencia').datepicker();
}

function add_preco(e){
    data = 
    { 
        fornecedor_des      : $('#fornecedor').val(),
        insumo_des          : $('#insumo').val(),
        valor               : $('#txt_preco_insumo').val(),
        vigencia            : $('#txt_data_vigencia').val() // datepicker( "getDate" )
    }
  
    $.post('insumo/add_preco', data, slide_down_callback_preco, 'JSON');    
    $('#form_preco').hide();
}