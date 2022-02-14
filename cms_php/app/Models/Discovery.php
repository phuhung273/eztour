<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Model;
class Discovery extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'address', 'about', 'place'];

    public function images(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(Image::class,'imageable');
    }

    public function teams(){
        return $this->belongsToMany(Team::class);
    }
}
