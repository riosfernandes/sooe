$(function(){    
    //    $('#log').hide();
    //    $('#projeto-servicos').hide();    
    
    /* método para pesquisar e autocompletar
     * um serviço no campo e sua inclusão no
     * grid.
     **/
    $( "#city" ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "orcamento/find_servico",
                type: 'POST',
                dataType: "json",
                data: {
                    'name': request.term
                },
                success: function( data ) {
                    response( $.map( data.servico, function( item ) {
                        return {
                            label: item.sco + '  ::  ' + item.descricao,
                            descricao: item.descricao,
                            id: item.id,
                            sco: item.sco
                        }
                    }));
                }
            });
        },
        minLength: 3,
        select: function( event, ui ) {
            addServico(ui.item);
        //            log( ui.item ?
        //                "Selected: " + ui.item.label + ui.item.id :
        //                "Nothing selected, input was " + this.value);
        },
        open: function() {
            $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        },
        close: function() {
            $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
        }
    });
    
    function addServico( item ) {
        if(item){
            var table = $('#table-servicos');
            
            //verifica se o item já foi incluido
            var itens = table.find('input');
            var repetido = false;
            if(itens){
                $.each(itens, function(index, value){                    
                    if(value.id == item.id.toString()){
                        repetido = true;
                        return;
                    }
                });
            }

            if(!repetido){
                var row = '<tr><td><input id="' + item.id + '" type="button" item="' + item.id + '" class="remove"></input></td><td>' + item.sco + '</td><td>' + item.descricao + '</td></tr>';
                table.children('tbody').first().after(row);
                table.parent().fadeIn(200);
                table.scrollTop(0);
            }
            else{
                var log = $('#log-servicos');
                log.html('<p>Serviço já incluído!</p>');
                //                log.slideDown(200);
                log.slideDown(200).delay(1000).slideUp(200);
            }
        }
    }
});