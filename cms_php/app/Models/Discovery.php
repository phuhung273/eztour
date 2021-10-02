<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Discovery extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'image', 'address', 'about', 'place'];

    public function teams(){
        return $this->belongsToMany(Team::class);
    }
}
