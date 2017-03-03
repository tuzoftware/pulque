<?php

// Kickstart the framework
$f3=require('lib/base.php');
require_once 'core/lib/Twig/Autoloader.php';

/*
	|--------------------------------------------------------------------------
	| Configuracion GENERAL
	|--------------------------------------------------------------------------
*/
$f3->set('ENCODING','UTF-8');
$f3->set('DEBUG',1);
if ((float)PCRE_VERSION<7.9){
    trigger_error('PCRE version is out of date');
}
/*
	|--------------------------------------------------------------------------
	| Archivos de configuracion
	|--------------------------------------------------------------------------
*/
F3::config('config.ini');
F3::config('datasource.ini');
/*
	|--------------------------------------------------------------------------
	| Configuracion de Autoload
	|--------------------------------------------------------------------------
*/
$f3->AUTOLOAD="core/lib/Autocarga/;core/lib/F3Access/;core/lib/Valitron/src/;core/base/;core/lib/eiseXLSX-master/;core/lib/error/;core/lib/excel/;";
$autocarga = new Autocarga();
$autocarga->autocargar('app');
/*
	|--------------------------------------------------------------------------
	| Conexiones a la base de datos
	|--------------------------------------------------------------------------
*/

F3::set('DB',new DB\SQL('mysql:host='.F3::get('host').';port='.F3::get('port').';dbname='.F3::get('dbname') ,F3::get('user'),F3::get('password')));

/*
	|--------------------------------------------------------------------------
	| Valitron
	|--------------------------------------------------------------------------
*/
use Valitron\Validator as V;
// always set langDir before lang.
V::langDir(__DIR__.'/core/lib/Valitron/lang');
V::lang('es');
/*
	|--------------------------------------------------------------------------
	| Configuracion de Twig Plantillas
	|--------------------------------------------------------------------------
*/
Twig_Autoloader::register();

$loader = new Twig_Loader_Filesystem($autocarga->autocargarTwig('ui/modulos'));

$twig = new Twig_Environment($loader, array(
    'cache' => $f3->get('TEMP'),
    'debug' => true,
    'auto_reload' => true
));
Twig_Autoloader::register();
$twig->addFilter('f3', new Twig_Filter_Function('F3::get'));
$twig->addGlobal('is_ajax',F3::get('AJAX'));
$twig->addGlobal("base", F3::get('BASE'));
$twig->addGlobal("debug", F3::get('DEBUG'));
$functionSeguridad = new Twig_SimpleFunction('tieneAlgunPermiso', function ($permiso) {
    return Seguridad::tieneAlgunPermiso($permiso);
});
$twig->addFunction($functionSeguridad);
$lexer = new Twig_Lexer($twig, array(
    'tag_comment'   => array('[#', '#]'),
    'tag_block'     => array('[%', '%]'),
    'tag_variable'  => array('[[', ']]'),
    'interpolation' => array('#[', ']'),
));
$twig->setLexer($lexer);
$f3->set('twig',$twig);
/*
    |--------------------------------------------------------------------------
    | Configuracion de Errores
    |--------------------------------------------------------------------------
*/
$whoops = new \Whoops\Run;
$whoops->pushHandler(function ($exception) {
    $datetime = new DateTime();
    $folio=' FOLIO '.$datetime->format('d_m_Y_h_i_s');
    $logger = new Log('folio.log');
    $mensaje=$exception->getMessage()." ".$exception->getFile()." - ".$exception->getLine().$folio;
    $errorInesperado="Ha ocurrido un Error Inseperado ".$folio;
    $datosAdicionales=array("codigo"=>500,"folio"=>$errorInesperado,"mensaje"=>$mensaje);
    $logger->write($mensaje);
    if(\Whoops\Util\Misc::isAjaxRequest()){
        //http_response_code(500);
        MensajeRespuesta::mensajeDatosAdicionales($errorInesperado,$datosAdicionales,'ERROR',500);
    }else{
	    F3::error("500",$errorInesperado."|".$mensaje);
    }
});
$whoops->register();
F3::set('ONERROR','ErrorController->index');
$f3->route('POST /error','ErrorController->indexJSON');
/*
	|--------------------------------------------------------------------------
	| Configuracion de Rutas
	|--------------------------------------------------------------------------
*/

//RUTAS GLOBALES

$f3->route('POST /loguear','AutenticacionController->loguear');
$f3->route('GET  /desloguear','AutenticacionController->desloguear');

//RUTAS LOCALES
if(F3::get('SESSION.id_usuario') == false) {
    $f3->route('GET /','AutenticacionController->index');
}else {
    if (F3::get('SESSION.tiempo') + F3::get('TIEMPO') > time()) { //Infraestructura

        //RUTAS DE TEST
        Accesso::permitir('GET /', 'TestController->index', array(RolEnum::ADMINISTRADOR,RolEnum::USUARIO));
        Accesso::permitir('GET /test/home', 'TestController->index', array(RolEnum::ADMINISTRADOR,RolEnum::USUARIO));
        Accesso::permitir('POST /test/buscar','TestController->buscar', array(RolEnum::ADMINISTRADOR,RolEnum::USUARIO));


    } else {
        $autenticacionController = new AutenticacionController();
        $autenticacionController->desloguearTiempoExpirado();
    }
}
$f3->run();
