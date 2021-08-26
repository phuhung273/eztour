<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Greeting extends Model
{
    use HasFactory;
    
    protected $fillable = ['message', 'alarm_time'];

    public $timestamps = false;

    public static function getSuitableMessage($time){
        $greetings = (new static)::orderBy('alarm_time', 'ASC')->get();

        $suitableMessage = $greetings->reduce(function($last, $item) use ($time) {
            if ($time > strtotime($item->alarm_time)) {
                return $item->message;
            }

            return $last;
        }, $greetings[0]->message);

        return $suitableMessage;
    }
}
