<?php

class BaseController
{
     private $twig;
     protected $parametros;
	 protected $data;


	 public function __construct()
     {
         $this->twig = $GLOBALS['twig'];//global $twig;
         $this->parametros=array();
     }

     public function render($vistahtml){
         echo $this->twig->render($vistahtml,$this->parametros);
         exit;
     }
   

    public function afterRoute(){
        if(F3::get('EXTENDER_TIEMPO') && F3::get('SESSION.id_usuario')){
            F3::set('SESSION.tiempo',time());
        }

        if(F3::get('BITACORA')){
            if(F3::get('SESSION.id_usuario') && F3::get('AUDITABLE')){
                //var_dump(F3::hive());
                //var_dump(current(current(current(F3::get('ROUTES')[F3::get('PATTERN')]))));
                //var_dump(F3::get('ROUTES')[F3::get('PATTERN')][3][F3::get('VERB')]);
                $peticion=F3::get('VERB');
                $parametros = implode(",",F3::get($peticion));
                $ip=F3::get('IP');
                //$servicio=current(current(current(F3::get('ROUTES')[F3::get('PATTERN')])));
                $metodo=F3::get('PATTERN');
                $bitacora=new Bitacora();
                $bitacora->id_usuario=F3::get('SESSION.id_usuario');
                //$bitacora->servicio=$servicio;
                $bitacora->parametros=$parametros;
                //$bitacora->direccionip=$ip;
                $bitacora->save();
                F3::set('AUDITABLE',true);
            }
        }

    }
	


}