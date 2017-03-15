<?php

class AutenticacionController extends BaseController{

  public function index(){
    echo $this->render('login.html');
  }
  public function loguear(){
      //Para la autenticacion necesita el mapeo directo
      $usuario=new DB\SQL\Mapper(F3::get('DB'),'usuario');
      $usuario->id_usuario=F3::get('POST.id');
      $usuario->contrasenia=md5(F3::get('POST.password'));
      $this->validarTipoDato($usuario);
      $this->validarLogueo($usuario);
      $this->redireccionarRol();
  }
  private function validarTipoDato($usuario){
      if(is_array($usuario->contrasenia) || is_array($usuario->id_usuario)){
          MensajeRespuesta::mensaje('Tipo de Dato incorrecto');
      }
  }
  private function validarLogueo($usuario){

      $auth=new \Auth($usuario, array('id'=>'id_usuario','pw'=>'contrasenia'));
      if($auth->login($usuario->id_usuario,$usuario->contrasenia)) {
          $usuario->load(array('id_usuario=?',$usuario->id_usuario));
          if($usuario->activo!="SI"){
              MensajeRespuesta::mensaje("Usuario Inactivo",'ERROR');
          }
          if($usuario->bloqueado!="NO"){
              MensajeRespuesta::mensaje('Usuario Bloqueado','ERROR');
          }
          //Si el soporte no es multisesion, solo permite que el usuario se loguee una vez
          if(!F3::get('MULTISESION')){
              if($usuario->logueado=="SI"){
                  MensajeRespuesta::mensaje('Usuario logueado en otro equipo','ERROR');
              }
          }
          $this->guardarAcceso($usuario);
          $this->cargarConfiguracionSesion($usuario);
      }else{
          $total=$usuario->count(array('id_usuario=?',$usuario->id_usuario));
          $this->guardarIntentosLogueo($total,$usuario);
          $this->mostrarMensajeRespuestaConfiguracion($total);
      }

  }
  private function guardarAcceso($usuario){
      $usuario->logueado="SI";
      $usuario->numero_intentos=0;
      $usuario->ultimo_acceso=date("Y-m-d H:i:s");
      $usuario->save();
  }
  private function cargarConfiguracionSesion($usuario){
      $datos=null;
	  SesionAuxiliar::subir('id_usuario', $usuario->id_usuario);
	  $permisos=F3::get('DB')->exec("SELECT rol.id_rol FROM usuario
        JOIN usuario_rol ON usuario_rol.id_usuario=usuario.id_usuario 
        JOIN rol ON rol.id_rol = usuario_rol.id_rol
        WHERE usuario.id_usuario=:id_usuario",array(':id_usuario'=>$usuario->id_usuario));
      if(empty($permisos)){
          MensajeRespuesta::mensaje('No tiene ningun permiso Asignado','ERROR');
      }
		foreach($permisos as $permiso){
			$datos[]=$permiso['id_rol'];
		}
      SesionAuxiliar::subir('permiso',$datos);
      F3::set('SESSION.tiempo',time());
  }
  private function guardarIntentosLogueo($total,$usuario){
       if(F3::get('INTENTOS_LOGUEO')>0){
           if($total>0){
               $usuario->load(array('id_usuario=?',$usuario->id_usuario));
               if($usuario->bloqueado!=0){
                   MensajeRespuesta::mensaje('Usuario Bloqueado','ERROR');
                   return;
               }
               $intentos=$usuario->numero_intentos;
               $intentos++;
               $usuario->numero_intentos=$intentos;
               if($intentos>F3::get('INTENTOS_LOGUEO')){
                   $usuario->bloqueado=1;
                   $usuario->fecha_bloqueo=date("Y-m-d H:i:s");
               }
               $usuario->save();
           }
       }
   }
  private function mostrarMensajeRespuestaConfiguracion($total){
        if(F3::get('CONFIGURACION')=='INTERNET'){
            MensajeRespuesta::mensaje('Usuario o password incorrecto','ERROR');
        }else{
            if($total==0){
                MensajeRespuesta::mensaje('El usuario no existe','ERROR');
            }else{
                MensajeRespuesta::mensaje('Password Incorrecto','ERROR');
            }
        }
    }
  private function redireccionarRol(){
        if(Seguridad::tieneAlgunPermiso(RolEnum::ADMINISTRADOR)){
            MensajeRespuesta::redireccion("test/home");
        }
  }
  public function desloguear(){
        $usuario= new DB\SQL\Mapper(F3::get('DB'),'usuario');
        if(empty(F3::get('SESSION.id_usuario'))){
            F3::clear('SESSION');
            F3::reroute("/");
            exit;
        }
        $usuario->load(array('id_usuario=?',F3::get('SESSION.id_usuario')));
        $usuario->logueado="NO";
        $usuario->save();
        F3::clear('SESSION');
        F3::reroute("/");
    }
  public function desloguearTiempoExpirado(){
	   $id_usuario=SesionAuxiliar::obtener("id_usuario");
        if(empty($id_usuario)){
            F3::clear('SESSION');
			if(F3::get('AJAX')){
				
			}else{
		      F3::reroute($this->base());
              exit;
			}
        }
        $usuario= new DB\SQL\Mapper(F3::get('DB'),'usuario');
        $usuario->load(array('id_usuario=?',$id_usuario));
        $usuario->logueado="NO";
        $usuario->save();
		if(F3::get('AJAX')){
		    $datosAdicionales=array("codigo"=>408);
			 http_response_code(408);
			 MensajeRespuesta::mensajeDatosAdicionales("Tiempo Expirado",$datosAdicionales,'ERROR',408);
		}else{
			http_response_code(408);
		    F3::error(408);
            F3::clear('SESSION');
			exit;
		}
    }

}