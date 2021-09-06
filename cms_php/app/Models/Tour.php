<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tour extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    public $timestamps = false;

    public function locations(){
        return $this->hasMany(Location::class);
    }
}
