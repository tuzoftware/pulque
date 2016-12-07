<?php

/**
 * Created by PhpStorm.
 * User: ULTRABOOK
 * Date: 07/11/2015
 * Time: 01:24 PM
 */
class BaseRepository
{
    protected $db;
    protected $filtros;
    protected $sql;

    public function __construct($db='DB')
    {
        $this->db =F3::get($db);
        $this->filtros=array();
    }


    public function obtenerInstanciaBD(){
        return $this->db;
    }

    public function obtenerInstancia($nombre_tabla){
        return new DB\SQL\Mapper($this->db,$nombre_tabla);
    }

    public function obtenerInstanciaIdValor($nombre_tabla,$id,$valor){
        $objeto=new DB\SQL\Mapper($this->db,$nombre_tabla);
        $objeto->load(array($id.'=?',$valor));
        return $objeto;
    }

    protected function actualizacion(){
        $resultados=array();
        $resultados=$this->db->exec($this->sql,$this->filtros);
        $this->filtros=array();
        if(empty($resultados)){
            return null;
        }
        return $resultados;
    }


    protected function resultado(){
        $resultados=array();
        $resultados=$this->db->exec($this->sql,$this->filtros);
        $this->filtros=array();
        if(empty($resultados)){
            return null;
        }
        return $resultados;
    }

    protected function renglon(){
        $resultados=$this->db->exec($this->sql,$this->filtros);
        $this->filtros=array();
        if(empty($resultados)){
            return null;
        }
        return $resultados[0];
    }

    protected function escalar(){
        $resultados=$this->db->exec($this->sql,$this->filtros);
        $this->filtros=array();
        if(empty($resultados)){
            return null;
        }
        return current($resultados[0]);
    }

    public function convertirArregloModelo($nombreTabla,$arreglo){
        $objeto = null;
        if($arreglo!=null || count($arreglo)!=0){
            $objeto = new DB\SQL\Mapper($this->db,$nombreTabla);
            foreach ($arreglo as $key => $value) {
                $objeto->$key = $this->limpiar($value);
            }
        }
        return $objeto;
    }

    public function guardar(&$arreglo,$nombre_tabla){
        $objeto=$this->convertirArregloModelo($nombre_tabla,$arreglo);
        $objeto->save();
        $arreglo=$objeto;
    }

    public function actualizar(&$arreglo,$nombre_tabla,$id){
        $objeto=$this->copiarPropiedades($arreglo,$nombre_tabla,$id);
        $objeto->update();
        $arreglo=$objeto;
    }

    public function guardarActualizar($arreglo,$nombre_tabla,$id){
        $objeto=null;
        if(empty($arreglo[$id])){
            $objeto=$this->convertirArregloModelo($nombre_tabla,$arreglo);
            $objeto->save();
        }else{
            $objeto=$this->copiarPropiedades($arreglo,$nombre_tabla,$id);
            $objeto->update();
        }
        return $objeto;
    }

    private function copiarPropiedades($arreglo,$nombre_tabla,$id){
        $valor=$arreglo[$id];
        $objetoOriginal=$this->obtenerInstanciaIdValor($nombre_tabla,$id,$valor);
        foreach ($arreglo as $key => $value) {
            $objetoOriginal->$key = $this->limpiar($value);
        }
        return $objetoOriginal;
    }

    private function limpiar($valor){
        if(is_string($valor) && F3::get('LIMPIAR')){
            $valor=trim($valor,"");
            switch(F3::get('CAPITALIZAR')){
                case 1:
                    $valor=strtoupper($valor);
                    break;
                case 2:
                    $valor=strtolower($valor);
                    break;
                default:
                    return $valor;
            }
        }
        return $valor;
    }


}