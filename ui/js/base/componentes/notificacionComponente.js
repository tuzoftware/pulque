/**
 * Created by Solutions on 25/10/2016.
 */
// uso bootstrapDialogComponente.mostrarError(mensje)
var notificacionComponente = (function() {

    function mostrarError(mensaje){
        Lobibox.notify('error', {
            showClass: 'rollIn',
            hideClass: 'rollOut',
            delay: 7000,
            msg: mensaje,
            title: 'Error',
            sound: false,
            width: $(window).width()
        });
    }

    function mostrarCorrecto(mensaje){
        Lobibox.notify('success', {
            showClass: 'rollIn',
            hideClass: 'rollOut',
            delay: 7000,
            msg: mensaje,
            title: 'Exito',
            sound: false,
            width: $(window).width()
        });
    }

    // public API
    return {
        mostrarCorrecto:mostrarCorrecto,
        mostrarError:mostrarError
    };
})();