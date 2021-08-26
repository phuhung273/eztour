<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'image', 'day', 'tour_id', 'description', 'from', 'to'];

    public $timestamps = false;

    public static function getVisibleAttribute(){
        return (new static)::where('tour_id', 1)->get(['id', 'name', 'image', 'day', 'tour_id']);
    }
}
