var datePickerComponente = (function() {

    function crearFecha(selector){
        $(selector).datetimepicker({
            format: 'DD/MM/YYYY',
            showClear: true,
            ignoreReadonly: true
        }).on("dp.change", function (e) {
            if ($(this).val()) {
                $(this).closest($(".form-group")).removeClass("is-empty");
            } else {
                $(this).closest($(".form-group")).addClass("is-empty");
            }
        });
    }

    function crearFechaEncadenada(selectorFechaInicio,selectorFechaFin){
        $(selectorFechaInicio).datetimepicker({
            format: 'DD/MM/YYYY',
            showClear: true,
            ignoreReadonly: true
        }).on("dp.change", function (e) {
            if ($(this).val()) {
                $(this).closest($(".form-group")).removeClass("is-empty");
            } else {
                $(this).closest($(".form-group")).addClass("is-empty");
            }
        });
        $(selectorFechaFin).datetimepicker({
            format: 'DD/MM/YYYY',
            showClear: true,
            ignoreReadonly: true,
            useCurrent: false //Important! See issue #1075
        }).on("dp.change", function (e) {
            if ($(this).val()) {
                $(this).closest($(".form-group")).removeClass("is-empty");
            } else {
                $(this).closest($(".form-group")).addClass("is-empty");
            }
        });
        $(selectorFechaInicio).on("dp.change", function (e) {
            $(selectorFechaFin).data("DateTimePicker").minDate(e.date);
        });
        $(selectorFechaFin).on("dp.change", function (e) {
            $(selectorFechaInicio).data("DateTimePicker").maxDate(e.date);
        });
    }

    // public API
    return {
        crearFecha: crearFecha,
        crearFechaEncadenada: crearFechaEncadenada
    };
})();
