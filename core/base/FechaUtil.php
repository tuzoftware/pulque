<?php

/**
 * Created by PhpStorm.
 * User: Solutions
 * Date: 10/10/2016
 * Time: 05:14 PM
 */
class FechaUtil
{

    static function validarFecha($date, $format = 'd/m/Y')
    {
        $d = DateTime::createFromFormat($format, $date);
        return $d && $d->format($format) == $date;
    }
}