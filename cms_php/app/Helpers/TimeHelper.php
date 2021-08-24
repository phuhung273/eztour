<?php


namespace App\Helpers;

use DateTime;

class TimeHelper {
    public static function gia2his($timeGia) {
        $dateTimeGia = DateTime::createFromFormat('g:i a', $timeGia);
        return $dateTimeGia->format('H:i:s');
    }
}