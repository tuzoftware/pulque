<?php

class FechaUtil{

    public static function validarFecha($date, $format = 'd/m/Y'){
        $d = DateTime::createFromFormat($format, $date);
        return $d && $d->format($format) == $date;
    }

    /**
     * Convierte una fec
     * @param $fecha
     * @param string $format
     * @return false|string
     */
    public static function convertirFecha($fecha, $formatoOrigen = "d/m/Y", $formatoDestino = 'Y-m-d'){
        $fecha = DateTime::createFromFormat($formatoOrigen, $fecha);
        return $fecha->format($formatoDestino);
    }

    /**
     * Retorna un objeto DateTime a partir de un formato ya creado
     * @param $fecha
     * @param string $formatoOrigen
     * @return bool|DateTime
     */
    public static function crearFechaFormato($fecha, $formatoOrigen = "d/m/Y"){
        $fecha = DateTime::createFromFormat($formatoOrigen, $fecha);
        return $fecha;
    }

}