$(function(){    
    $('#projeto-servicos').hide();
    
    
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
            var row = '<tr><td><input id="' + item.id + '" type="button" item="' + item.id + '" class="remove"></input></td><td>' + item.sco + '</td><td>' + item.descricao + '</td></tr>';
            alert(row);
            table.find('tbody').append(row);
            table.show().parent().fadeIn(200);
        }
    //        $( "<div/>" ).text( message ).prependTo( "#log" );
    //        $( "#log" ).scrollTop( 0 );
    }
});