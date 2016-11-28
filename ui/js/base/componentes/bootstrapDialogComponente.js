/**
 * Created by Solutions on 25/10/2016.
 */
// uso bootstrapDialogComponente.mostrarError(mensje)
var bootstrapDialogComponente = (function() {

    function mostrarError(mensaje){
        BootstrapDialog.show({
            title: 'Error',
            message: '<span style="display: table-cell"><i class="fa fa-times-circle modal-advertencia" > </i></span> <span class="modal-mensaje" >'+mensaje+'</span>',
            type: BootstrapDialog.TYPE_DANGER,
            buttons: [{
                label: 'Aceptar',
                action: function(dialog) {
                    dialog.close();
                }

            }]
        });
    }

    function mostrarCorrecto(mensaje){
        BootstrapDialog.show({
            title: 'Correcto',
            message: '<span style="display: table-cell"><i class="fa fa-check-circle modal-correcto" > </i></span> <span class="modal-mensaje" >'+mensaje+'</span>',
            type: BootstrapDialog.TYPE_SUCCESS,
            buttons: [{
                label: 'Aceptar',
                action: function(dialog) {
                    dialog.close();
                }

            }]
        });
    }

    // public API
    return {
        mostrarCorrecto:mostrarCorrecto,
        mostrarError:mostrarError
    };
})();