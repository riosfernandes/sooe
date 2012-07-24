$(function(){
    function log( message ) {
        $( "<div/>" ).text( message ).prependTo( "#log" );
        $( "#log" ).scrollTop( 0 );
    }

    $( "#city" ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                //                url: "http://ws.geonames.org/searchJSON",
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
                            value: item.descricao,
                            id: item.id
                        }
                    }));
                }
            });
        },
        minLength: 3,
        select: function( event, ui ) {
            log( ui.item ?
                "Selected: " + ui.item.label + ui.item.id :
                "Nothing selected, input was " + this.value);
        },
        open: function() {
            $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        },
        close: function() {
            $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
        }
    });
});