<?php

namespace App\Http\Livewire;

use App\Models\Todo;
use Livewire\Component;

class ChecklistPage extends Component
{
    public $content;
    public $done;
    
    public $data;

    protected $rules = [
        'content' => 'required|min:4',
    ];

    public function mount() {
        $this->data = Todo::all();
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $item = new Todo([
            'message' => $this->content,
            'done' => isset($this->done),
        ]);

        $item->save();

        $this->data->push($item);

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
