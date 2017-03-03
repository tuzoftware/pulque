<?php

/**
 * Created by PhpStorm.
 * User: Solutions
 * Date: 02/03/2017
 * Time: 01:04 PM
 */
class TestRepository extends BaseRepository
{

    public function buscarTotal(){
        $this->sql="SELECT COUNT(id_test_continente) FROM test_pais ";
        return $this->escalar();
    }

    public function buscar($start,$length){
        $this->filtros["start"]=intval($start);
        $this->filtros["length"]=intval($length);
        $this->sql="SELECT id_test_continente,id_test_pais,pais FROM test_pais ";
        $this->sql= $this->sql."LIMIT :start,:length";
        return $this->resultado();
    }


}