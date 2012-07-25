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

            if(table.find('input').attr('id') != item.id){
                var row = '<tr><td><input id="' + item.id + '" type="button" item="' + item.id + '" class="remove"></input></td><td>' + item.sco + '</td><td>' + item.descricao + '</td></tr>';
                table.children('tbody').first().after(row);
                table.parent().fadeIn(200);
                table.scrollTop(0);
            }
            else{
                var log = $('#log');
                $("<div/>").text('Serviço já incluído!').prependTo('#log');                
//                log.slideDown(200);
                log.fadeIn(200).delay(2000).fadeOut(200);
            }
        }
    //        $( "<div/>" ).text( message ).prependTo( "#log" );
    //        $( "#log" ).scrollTop( 0 );
    }
});