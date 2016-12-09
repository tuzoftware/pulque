<?php

/**
 * Created by PhpStorm.
 * User: tuz0ftware
 * Date: 10/10/2016
 * Time: 05:14 PM
 */
class FechaUtil{

    static function validarFecha($date, $format = 'd/m/Y')
    {
        $d = DateTime::createFromFormat($format, $date);
        return $d && $d->format($format) == $date;
    }

    /**
     * Convierte una fec
     * @param $fecha
     * @param string $format
     * @return false|string
     */
    static function convertirFecha($fecha, $format='Y-m-d'){
        return date($format,strtotime($fecha));
    }

}