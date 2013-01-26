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
            slide_down_callback_insumo();
        }
    });
}
 
function slide_down_callback_insumo(){
     $("#resultado").flexReload();
}

function select_insumo(event, ui ){
    /* a lista de preços já associados deve surgir para o usuário visualizar logo após a seleção do     
     **/
    $('#form_preco').show("fast", callback_insumo);
//    $('#form_preco').slideDown('0', slide_down_callback_preco); // garante que só seja executado após o slow acontecer
}

function slide_down_callback_preco(){   
    colModel = [
    {
        display: 'Insumo', 
        name : 'insumo_des', 
        width : 40, 
        sortable : true, 
        align: 'center'
    },

    {
        display: 'Unidade', 
        name : 'insumo_un', 
        width : 180, 
        sortable : true, 
        align: 'left'
    },

    {
        display: 'Valor', 
        name : 'valor', 
        width : 120, 
        sortable : true, 
        align: 'left'
    },

    {
        display: 'Vigência', 
        name : 'vigencia', 
        width : 130, 
        sortable : true, 
        align: 'center' 
    }];
    
    search_items = [
    {
        display: 'Insumo', 
        name : 'descricao', 
        isdefault: true
    }
    ];
    
    $("#resultado").flexigrid({
        url: 'insumo/get_preco',
        dataType: 'json',
        colModel : colModel,
        searchitems : search_items,
        sortname: "insumo_id",
        sortorder: "asc",
        usepager: true,
        title: 'Preços',
        useRp: true,
        rp: 50,
        showTableToggleBtn: true,
        singleSelect: true,
        onSubmit: get_params_flexi
    });   
}

function get_params_flexi()
{
    var dt = 
    [ 
    {
        name: 'fornecedor_desc', 
        value: $('#fornecedor').val()
    }, 
    {
        name: 'insumo_desc', 
        value: $('#insumo').val()
    }
    ];
            
    $("#resultado").flexOptions({
        params: dt
    });
    
    return true;

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
  
    $.post('insumo/add_preco', data, slide_down_callback_insumo, 'JSON');    
//    $('#form_preco').hide();
}