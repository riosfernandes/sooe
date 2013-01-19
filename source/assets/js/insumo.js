$(main);

function main()
{    
    $('#datepicker').datepicker();
    
    $("#div_insumo").hide();
    $("#divTableResult").hide();
    $('#precos').hide();

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
            /*listar os preços para o fornecedor
             *e insumo selecionados */            
            resultado = $("#resultado");
            
            resultado.html('<p>Carregando...</p>');
            resultado.load('insumo/get_preco',
            {
                fornecedor_desc        :$('#fornecedor').val()
            });
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
            $('#precos').show();
        }
    });
}