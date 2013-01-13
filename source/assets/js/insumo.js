$(main);

function main()
{    
    $("#div_insumo").hide();
    $("#divTableResult").hide();

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
            alert("exibir tabelas com precos")
            
            resultado = $("#resultado");
            
            resultado.html('<p>Carregando...</p>');
            resultado.load('insumo/get_preco',
            {
                fornecedor_desc        :$('#fornecedor').val(),
                insumo_desc            :$('#insumo').val()
            });
            
//            $.post(
        //                'insumo/get_preco',
        //                {
        //                    fornecedor_desc        :$('#fornecedor').val(),
        //                    insumo_desc            :$('#insumo').val()
        //                },
        //                function(data){
        //                    alert("Me exiba")
        //                },
        //                'json'
        //                );
        }
    });    
    
}