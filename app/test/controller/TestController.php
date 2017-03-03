<?php

/**
 * Created by Tuzoftware.
 * User: Solutions
 * Date: 28/11/2016
 * Time: 12:17 PM
 */
class TestController extends BaseController
{

    private $usuarioRepository;
    private $testRepository;

    public function __construct(){
        parent::__construct();
        $this->usuarioRepository=new UsuarioRepository();
        $this->testRepository=new TestRepository();
    }

    public function index(){
        $this->parametros['usuarios']=$this->usuarioRepository->obtenerUsuarios();
        $this->render("test.html");
    }

    public function buscar(){
        $draw=F3::get('POST.draw');
        $start=F3::get('POST.start');
        $length=F3::get('POST.length');
        // Los filtros se deben de usar para busquedas
        //$filtros=F3::get('POST.filtros');
         $total=$this->testRepository->buscarTotal();
        if($total==0){
            MensajeRespuesta::datosJSON($draw,$total);
        }
        $paises= $this->testRepository->buscar($start,$length);
        MensajeRespuesta::datosJSON($draw,$total,$paises);
    }

}