// uso baseComponente.inicializarAjax()
var baseComponente = (function() {


    function inicializarAjax(base,mostrarPrimerError){

        if(mostrarPrimerError === undefined) {
            mostrarPrimerError = true;
        }
        $.ajaxPrefilter(function(options, _, jqXHR) {
            jqXHR.statusCode( {

                408: function() {
                    if(jqXHR.responseJSON!=undefined){
                        redireccionar(base+"/error",jqXHR.responseJSON.datosAdicionales);
                    }else{
                        var newDoc = document.open("text/html", "replace");
                        newDoc.write(jqXHR.responseText);
                        newDoc.close();
                    }
                },
                500: function() {
                    if(jqXHR.responseJSON!=undefined){
                        redireccionar(base+"/error",jqXHR.responseJSON.datosAdicionales);
                    }else{
                        var newDoc = document.open("text/html", "replace");
                        newDoc.write(jqXHR.responseText);
                        newDoc.close();
                    }
                }
            });
            if (typeof jqXHR.complete !== "function") {
                return;
            }

            jqXHR.complete(function(request) {
                if(request!=undefined && request.responseJSON!=undefined){
                    if(request.responseJSON.estatus==408 || request.responseJSON.estatus==404 ||request.responseJSON.estatus==500 ){
                        if(request.responseJSON.url===undefined){
                            redireccionar(base+"/error",request.responseJSON.datosAdicionales);
                        }else{
                            window.location.href = request.responseJSON.url;
                        }

                    }
                    if(request.responseJSON.estatus==200 && request.responseJSON.tipoRespuesta=="MENSAJES"
                        && request.responseJSON.tipoMensaje=="ERROR"){
                        ocultarErrores();
                        $.each(request.responseJSON.mensajes, function( index, value ) {
                            if(mostrarPrimerError){
                                $("#error-"+index+" i ").html("    "+value[0]);
                            }else{
                                $("#error-"+index+" i ").html("    "+value);
                            }
                            $("#error-"+index).show();
                        });
                    }
                }
            });
        });
    }
    function redireccionar(location, args)
    {
        var form = '';
        $.each( args, function( key, value ) {
            form += '<input type="hidden" name="'+key+'" value="'+value+'">';
        });
        form='<form action="'+location+'" method="POST">'+form+'</form>';
        $(form).appendTo('body').submit();
    }
    function tieneError(data){
        var error=false;
        if(data!=undefined && data.tipoMensaje!=undefined && data.tipoMensaje=="ERROR"){
            error=true;
        }
        return error;
    }

    function ocultarErrores(){
        $(".errores").hide();
        $(".errores i").html("");
    }

    function mostrarMensaje(message, position, timeout, theme, icon, closable,url) {
        if(url === undefined) {
            url = "";
        }
        if(toastr!=undefined){
            toastr.options.positionClass = 'toast-' + position;
            toastr.options.extendedTimeOut = 0; //1000;
            toastr.options.timeOut = timeout;
            toastr.options.closeButton = closable;
            toastr.options.iconClass = icon + ' toast-' + theme;
            toastr.options.onHidden = function() {
                if(url!==""){
                    window.location.href = url;
                }};
            toastr['custom'](message);

        }
    }
    function mostrarMensajes(mensajes,mostrarPrimerError){
        if(mostrarPrimerError === undefined) {
            mostrarPrimerError = true;
        }
        ocultarErrores();
        $.each(mensajes, function( index, value ) {
            if(mostrarPrimerError){
                $("#error-"+index+" i ").html("    "+value[0]);
            }else{
                $("#error-"+index+" i ").html("    "+value);
            }
            $("#error-"+index).show();
        });
    }
    function agregarPropiedad(selectorFormulario,valor,nombre){
        var arreglo= [valor];
        var model = $(selectorFormulario).serializeArray();
        $.map(arreglo, function (val, i) {
            return model.push({ "name": nombre, "value": val });
        });
    }
    //Esta funcion es usada para los errores ajax que no son manejados por jquery
    function redireccionarError(base,data){
        redireccionar(base+"/error",data.datosAdicionales);
    }

    // public API
    return {
        inicializarAjax:inicializarAjax,
        tieneError:tieneError,
        ocultarErrores:ocultarErrores,
        mostrarMensaje:mostrarMensaje,
        mostrarMensajes:mostrarMensajes,
        agregarPropiedad:agregarPropiedad,
        redireccionarError:redireccionarError
    };
})();