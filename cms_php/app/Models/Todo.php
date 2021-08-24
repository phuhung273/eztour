<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    protected $fillable = ['message', 'done'];

    public $timestamps = false;

    protected $casts = [
        'done' => 'boolean',
    ];

    use HasFactory;

}
