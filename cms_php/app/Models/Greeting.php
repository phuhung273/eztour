<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Model;
class Greeting extends Model
{
    use HasFactory;
    
    protected $fillable = ['message', 'alarm_time'];

    public $timestamps = false;

    public static function getSuitableMessage($time){
        $greetings = (new static)::orderBy('alarm_time', 'ASC')->get();
        $length = count($greetings);

        $suitableMessage = $greetings[$length - 1]->message;

        for ($i=0; $i < $length; $i++) { 
            if ($time >= strtotime($greetings[$i]->alarm_time)) {
                $suitableMessage = $greetings[$i]->message;
            } else {
                return $suitableMessage;
            }
        }

        return $suitableMessage;
    }
}
