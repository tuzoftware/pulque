var dataTableComponente = (function (selector, url, columnas, selectorFormulario, numerodeResultados) {
    if (selectorFormulario === undefined) {
        selectorFormulario = "";
    }
    $.fn.dataTable.ext.errMode = 'throw';
    if (numerodeResultados === undefined) {
        numerodeResultados = 10;
    }
    var tieneError = false;
    var dt = $(selector).DataTable({
        "bFilter": false, "bLengthChange": false, "ordering": false, "iDisplayLength": numerodeResultados,
        "language": {
            "zeroRecords": "No se encontraron resultados",
            "info": 'Mostrando resultados del <span class="label label-default">_PAGE_</span> al <span class="label      label-default">_PAGES_</span> de un total de <span class="label label-danger">_TOTAL_</span>',
            "infoEmpty": "No se encontraron resultados",
            "paginate": {
                "first": "Primera",
                "last": "Ultima",
                "next": "Siguiente",
                "previous": "Anterior"
            }
        },
        "serverSide": true,
        //Habilita el paginado por medio del servidor de aplicaciones
        "fnDrawCallback": function () {
            //Metodo que se ejecuta al finalizar la peticion
            $("#loading").hide();
            $(this).fadeIn();
            $('#buscar').empty().html('<i class="i-buscar"></i> Buscar').removeAttr('disabled');
        },
        "preDrawCallback": function (settings) {
            if (settings.json !== undefined && settings.json.tipoRespuesta != "DATOS" && tieneError) {
                return false;
            }
        },
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            var model = $(selectorFormulario).serializeArray();
            $.map(model, function (objeto) {
                oSettings.oAjaxData[objeto["name"]] = objeto["value"];
            });
            $.ajax({
                "dataType": 'json',
                "type": "POST",
                "url": url,
                "data": oSettings.oAjaxData,
                // "data" :$.makeArray( aoData ),
                "success": function (json) {
                    /* Do whatever additional processing you want on the callback,
                     then tell DataTables */
                    if (json.tipoRespuesta === "DATOS") {
                        fnCallback(json);
                    }

                }
            });

        },

        "columns": columnas
    });
    dt.on('xhr', function (e, settings, json) {
        if (json === null || json.tipoRespuesta != "DATOS") {
            // custom error reporting if needed
            return true;
        }
    });


    function buscar() {
        $(".errores").hide();
        $(".errores i").html("");
        dt.draw();
    }

    function obtenerSeleccionado(elemento) {
        var renglon = $(elemento).closest("tr");
        var row = dt.row(renglon);
        return row.data();
    }

    function recargar() {
        dt.draw();
    }

    function detalle(selectorPlantilla) {

        $(selector+' tbody').on('click', '.odd,.even', function (e) {
            if($(e.target).is('button')  || $(e.target).is('a')){
                return;
            }
            var tr = $(this).closest('tr');
            var row = dt.row(tr);
            if ( row.child.isShown() ) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('dt-renglon-activo');
            }
            else {
                var renglon = obtenerSeleccionado(this);
                var htmlDetalle=handleBarsComponente.compilar(selectorPlantilla,renglon);
                // Open this row
                row.child(htmlDetalle).show();
                tr.addClass('dt-renglon-activo');
            }
        } );
    }


    //Inicio Return
    return {
        buscar: buscar,
        obtenerSeleccionado: obtenerSeleccionado,
        recargar: recargar,
        detalle:detalle
    };

    //Fin Return
});