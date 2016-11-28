<?php

/**
 * Created by Tuzoftware.
 * User: Solutions
 * Date: 28/11/2016
 * Time: 12:30 PM
 */
class UsuarioRepository extends BaseRepository {

    public function obtenerUsuarios(){
        $this->sql='SELECT id_usuario,activo FROM usuario';
        return $this->resultado();
    }

}