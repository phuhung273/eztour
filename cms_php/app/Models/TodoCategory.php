<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TodoCategory extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    public $timestamps = false;

    public function todos(){
        return $this->hasMany(Todo::class);
    }
}
