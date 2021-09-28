<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Model;
class Location extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'image', 'day', 'description', 'from', 'to'];

    public $timestamps = false;

    public function team(){
        return $this->belongsTo(Team::class);
    }
}
