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

    public static function isHisStringBetweenHis($time, $from, $to) {
        $timeHis = (new static)::gia2his($time);
        return $timeHis >= $from && $timeHis <= $to;
    }

    public static function isNotConflictWithHisRange($inputFrom, $inputTo, $from, $to) {
        if ($inputFrom == $inputTo) {
            return false;
        }

        $fromHis = (new static)::gia2his($inputFrom);
        $toHis = (new static)::gia2his($inputTo);

        if ($fromHis >= $to || $toHis <= $from) {
            return true;
        }

        return false;
    }
}