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

}