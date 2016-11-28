var dataTableComponente = (function(selector,url,columnas,selectorFormulario="") {
    $.fn.dataTable.ext.errMode = 'throw';
	//.on( 'error.dt', function ( e, settings, techNote, message ) {
    //         console.log( 'Ocurrio un error: ', message );
    //         })
var tieneError=false;
	var dt=$(selector).DataTable({"bFilter": false,"bLengthChange": false,"ordering": false,	"iDisplayLength": 10,	
		     "language": {
              "zeroRecords": "No se encontraron resultados",
             "info": 'Mostrando resultados del <span class="label label-default">_PAGE_</span> al <span class="label      label-default">_PAGES_</span> de un total de <span class="label label-danger">_TOTAL_</span>',
             "infoEmpty": "No se encontraron resultados",
			  "paginate": {
               "first":      "Primera",
               "last":       "Ultima",
               "next":       "Siguiente",
               "previous":   "Anterior"
              }
            //"infoFiltered": "(filtered from _MAX_ total records)"
            },
			 "serverSide": true,			//Habilita el paginado por medio del servidor de aplicaciones
                "fnDrawCallback": function (oSettings) {	//Metodo que se ejecuta al finalizar la peticion
					$("#loading").hide();
                    $(this).fadeIn();
                    $('#buscar').empty().html('<i class="i-buscar"></i> Buscar').removeAttr('disabled'); 
                },
				 "preDrawCallback": function( settings ) {
					  
					 if(settings.json!==undefined){
						 console.log(settings.json.tipoRespuesta);
						  if(settings.json.tipoRespuesta!="DATOS" && tieneError){
							  
						    return false;	
						  }
					 }
                },
				"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
//aoData=aoData.concat( $(selectorFormulario).serializeArray() );
  // aoData.push( { "name": "more_data", "value": "my_value" } );
           var model = $(selectorFormulario).serializeArray();
		 
$.map(model, function (objeto, i) {
                        //console.log(val);
						//console.log(objeto["value"]);
						  oSettings.oAjaxData[objeto["name"]]=objeto["value"];
						//return model.push({ "name": "nombrePropiedadoControl[" + i + "]", "value": val });
                    });
		     //aoData.push( $(selectorFormulario).serializeObject() );

  
  //console.log(aoData);
  //aoData.push( { "filtros[nombre_busqueda]": "more_data", "value": "my_value" } );				             

							 $.ajax( {
         "dataType" : 'json',
         "type" : "POST",
         "url" : url,
		 "data": oSettings.oAjaxData,
     // "data" :$.makeArray( aoData ),
         "success" : function(json) {
           /* Do whatever additional processing you want on the callback, 
             then tell DataTables */
			 if(json.tipoRespuesta==="DATOS"){
				 fnCallback(json);
			 }
           
       }
	   });
                           
				},
			
                "columns":columnas
    });
	dt.on( 'xhr', function ( e, settings, json, xhr ) {
  //console.log(e);
 if ( json === null ) {
     // custom error reporting if needed
    return true;
  }else if(json.tipoRespuesta!="DATOS"){
	//dt.preDrawCallback(false);
	//e.stopPropagation();
	//console.log("**************************");
return true;
  }
} );


    
	function buscar(){
		$(".errores").hide();
		$(".errores i").html("");
		dt.draw();
	}

	function obtenerSeleccionado(renglon) {
		var row = instancia.row(renglon); 
		return row.data();
	}
	
	
	//Inicio Return
	return {
		buscar:buscar,
		obtenerSeleccionado : obtenerSeleccionado
	};

	//Fin Return
});