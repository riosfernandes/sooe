$(function(){
    
    $('#submenu-home').show();
    
    $('a').live('mouseover', function(e){
        var linkId = $(this).attr('id');
        var subMenuId;
        if(linkId.toString() == 'link-home'){
            subMenuId = 'submenu-home';
            $('#submenu-reserva').hide();
            $('#submenu-relatorio').hide();
            $('#submenu-cadastro').hide();
            $('#submenu-home').show();
        }
        else if(linkId.toString() == 'link-cadastro'){
            subMenuId = '#submenu-cadastro';
            $('#submenu-home').hide();
            $('#submenu-reserva').hide();
            $('#submenu-relatorio').hide();
            $('#submenu-cadastro').show();
        }
        else if(linkId.toString() == 'link-reserva'){
            subMenuId = '#submenu-reserva';
            $('#submenu-home').hide();
            $('#submenu-relatorio').hide();
            $('#submenu-cadastro').hide();
            $('#submenu-reserva').show();
        }
        else if(linkId.toString() == 'link-relatorio'){
            subMenuId = '#submenu-relatorio';
            $('#submenu-home').hide();
            $('#submenu-cadastro').hide();
            $('#submenu-reserva').hide();
            $('#submenu-relatorio').show();
        }
        
//        $(subMenuId).append('<input type="text"></input>');
        
        e.preventDefault();
    });

//    $('#link-home').live('mouseover', function(e){
//        $('#submenu-reserva').hide();
//        $('#submenu-relatorio').hide();
//        $('#submenu-cadastro').hide();
//        e.preventDefault();
//    });
//    
//    $('#link-cadastro').live('mouseover', function(e){
//        $('#submenu-reserva').hide();
//        $('#submenu-relatorio').hide();
//        $('#submenu-cadastro').show();
//        e.preventDefault();
//    });
//    
//    $('#link-reserva').live('mouseover', function(e){
//        $('#submenu-relatorio').hide();
//        $('#submenu-cadastro').hide();
//        $('#submenu-reserva').show();
//        e.preventDefault();
//    });
//    
//    $('#link-relatorio').live('mouseover', function(e){
//        $('#submenu-cadastro').hide();
//        $('#submenu-reserva').hide();
//        $('#submenu-relatorio').show();
//        e.preventDefault();
//    });
});