<?php
class Autocarga {
	
	function autocargar($dir=null){		
	  $listaDirectorio=glob($dir."/*",GLOB_ONLYDIR);
	  if(count($listaDirectorio)==0){
	   F3::set('AUTOLOAD',F3::get('AUTOLOAD').';'.$dir.'/');
	   return;
	  }
	  foreach($listaDirectorio as $file){
	    $this->autocargar($file);
     }
   }
   
   
	function autocargarTwig($dir=null,$rutas=null){		
	  $listaDirectorio=glob($dir."/*",GLOB_ONLYDIR);
	  if($rutas==null){
		  $rutas=array();
	  }
	  if(count($listaDirectorio)==0){
         $esHtml = strpos($dir,"html");
		 if($esHtml!==false){		
		   $rutas[]=$dir;
		 }		 
	   return $rutas;
	  }
	  foreach($listaDirectorio as $file){
	    $rutas=$this->autocargarTwig($file,$rutas);
     }
	  return $rutas;
   }
	
}