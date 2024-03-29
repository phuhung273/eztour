<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Model;
class Todo extends Model
{

    use HasFactory;
    
    protected $fillable = ['message'];

    public function todoCategory() {
        return $this->belongsTo(TodoCategory::class);
    }

    public function team() {
        return $this->belongsTo(Team::class);
    }

    public static function visibleAttributes() {
        return (new static)::join('todo_categories', 'todo_categories.id', '=', 'todos.todo_category_id')
        ->select('todos.id', 'todos.message', 'todo_categories.name as category');
    }

}
