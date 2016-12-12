//0.2
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

    //Inicio Return
    return {
        getValue:getValue,
        limpiar: limpiar,
        setValue:setValue
        //:cargar
    };
    //Fin Return
});