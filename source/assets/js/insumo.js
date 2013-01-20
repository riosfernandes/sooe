$(main);

function main()
{        
    $("#div_insumo").hide();
    $("#divTableResult").hide();
    $('#form_preco').hide();

    //    $('#precos').hide();


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
        select: select_insumo
    });
}

function select_insumo(event, ui ){
    //    $('#precos').show();
    $('#form_preco').slideDown('slow', slide_down_callback_preco); // garante que só seja executado após o slow acontecer
}

function slide_down_callback_preco(){
    /*listar os preços para o fornecedor
     *e insumo selecionados */            
    resultado = $("#resultado");
            
    resultado.html('<p>Carregando...</p>');
    resultado.load('insumo/get_preco',
    {
        fornecedor_desc        :$('#fornecedor').val()
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
        vigencia            : $('#txt_data_vigencia').datepicker( "getDate" )
    }
  
    $.post('insumo/add_preco', data, slide_down_callback_preco, 'JSON')
}