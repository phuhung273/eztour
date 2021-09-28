<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Discovery extends Model
{
    use HasFactory;

    public function images(){
        return $this->hasMany(Image::class);
    }

    public function teams(){
        return $this->belongsToMany(Team::class);
    }
}
