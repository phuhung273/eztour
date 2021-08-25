<?php


namespace App\Helpers;

use DateTime;

class TimeHelper {
    public static function gia2his($before) {
        $after = DateTime::createFromFormat('g:i a', $before);
        return $after->format('H:i:s');
    }

    public static function his2gia($before) {
        $after = DateTime::createFromFormat('H:i:s', $before);
        return $after->format('g:i a');
    }
}