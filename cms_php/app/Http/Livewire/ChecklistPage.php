<?php

namespace App\Http\Livewire;

use App\Models\Todo;
use Livewire\Component;

class ChecklistPage extends Component
{
    public $content;
    public $done;
    
    public $todos;

    protected $rules = [
        'content' => 'required|min:5',
    ];

    public function mount() {
        $this->todos = Todo::all();
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $todo = new Todo([
            'message' => $this->content,
            'done' => isset($this->done),
        ]);

        $todo->save();

        $this->todos->push($todo);

        $this->resetForm();
    }

    private function resetForm() {
        $this->content = null;
        $this->done = null;
    }

    public function render()
    {
        return view('livewire.checklist-page')
            ->layout('layouts.app', ['title' => 'Checklist']);
    }
}
