<?php

/**
 * Created by PhpStorm.
 * User: Solutions
 * Date: 12/12/2016
 * Time: 06:09 PM
 */
class ValidadorUtil{

    private $validador;
    private $arreglo;

    public function __construct($arreglo){
        $this->arreglo=$arreglo;
        $this->validador=new Valitron\Validator($arreglo);
    }


    public function validarTexto($campo,$requerido,$longitudMinima,$longitudMaxima,$expresionRegular=''){
        $this->validarRequerido($campo,$requerido);
        $this->validador->rule('lengthBetween',$campo, $longitudMinima,$longitudMaxima);
        if(!empty($expresionRegular)){
            $this->validador->rule('regex',$expresionRegular);
        }
    }

    public function validarCorreoElectronico($campo,$requerido,$longitudMinima,$longitudMaxima,$expresionRegular=''){
        $this->validarRequerido($campo,$requerido);
        $this->validador->rule('lengthBetween',$campo, $longitudMinima,$longitudMaxima);
        $this->validador->rule('email',$campo);
        if(!empty($expresionRegular)){
            $this->validador->rule('regex',$expresionRegular);
        }
    }

    public function validarNumeroEntero($campo,$requerido,$valorMinimo,$valorMaximo){
        $this->validarRequerido($campo,$requerido);
        $this->validador->rule("integer",$campo);
        $this->validador->rule('between', $campo, array($valorMinimo, $valorMaximo));
    }

    public function validarNumero($campo,$requerido,$valorMinimo,$valorMaximo){
        $this->validarRequerido($campo,$requerido);
        $this->validador->rule("numeric",$campo);
        $this->validador->rule('between', $campo, array($valorMinimo, $valorMaximo));
    }

    public function validarNumeroIdForaneo($campo,$requerido,$valorMinimo=1){
        $this->validarRequerido($campo,$requerido);
        $this->validador->rule("numeric",$campo);
        $this->validador->rule('min', $campo,$valorMinimo);
    }

    private function validarRequerido($campo,$requerido){
        if($requerido){
            $this->validador->rule("required",$campo);
        }
    }

    public function validarArregloSimple($requerido,$label){
        if($requerido){
            $this->validador->addRule('arregloRequerido', function($arreglo) {
                if(is_empty($arreglo)){
                    return true;
                }else{
                    return false;
                }
            })->message("El campo $label es requerido");
            $this->validador->rule('arregloRequerido',$this->arreglo);
        }
    }

}