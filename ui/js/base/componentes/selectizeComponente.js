//0.5
//Funciona con grids del lado del cliente
//para muchos grids instanciarlo como se muestra abajo;
//var selectize=selectizeComponente("#id1");
//var selectize2=selectizeComponente("#id2");
var selectizeComponente = (function(selector) {

    var instancia=$(selector).selectize()[0].selectize;

    function getValue(){
        return instancia.getValue();
    }

    function setValue(valor){
        return instancia.setValue(valor);
    }

    function limpiar(){
        instancia.setValue("");
    }

    function disable(){
        instancia.disable();
    }

    function enable() {
        instancia.enable();
    }

    function instanciar(){
        return instancia;
    }

    function encadenar(url,nombre_id,selectComponenteHijo,valorHijoPredefinido) {
        instancia.on('change', function() {
            var datos = {};
            datos[nombre_id]=instancia.getValue();
            $.post(url,datos,function (data) {
                /* Los datos esperados son en el siguiente formato
                 data=[
                 {text: "Bandung", value: 1 },
                 {text: "Cimahi", value: 2 }
                 ];*/
                var hijo=selectComponenteHijo.instanciar();
                hijo.clear();
                hijo.clearOptions();
                hijo.load(function(callback) {
                    callback(data);
                });
                if(valorHijoPredefinido!==undefined){
                    hijo.setValue(valorHijoPredefinido);
                }
            });
        });
    }

    //Inicio Return
    return {
        getValue:getValue,
        limpiar: limpiar,
        setValue:setValue,
        instanciar:instanciar,
        encadenar:encadenar,
        enable:enable,
        disable:disable
        //:cargar
    };
    //Fin Return
});