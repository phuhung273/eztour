<?php


namespace App\Helpers;


class ArrayHelper {
    public static function pushReturn($arr, $newItem) {
        array_push($arr, $newItem);
        return $arr;
    }

    public static function unshiftReturn($arr, $newItem) {
        array_unshift($arr, $newItem);
        return $arr;
    }
}