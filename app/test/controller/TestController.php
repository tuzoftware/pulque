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

    public function __construct(){
        parent::__construct();
        $this->usuarioRepository=new UsuarioRepository();
    }

    public function index(){
        $this->parametros['usuarios']=$this->usuarioRepository->obtenerUsuarios();
        $this->render("test.html");
    }

}