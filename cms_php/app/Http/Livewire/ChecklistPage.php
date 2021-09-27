<?php

namespace App\Http\Livewire;

use App\Models\Todo;
use App\Models\TodoCategory;

class ChecklistPage extends BaseTourPage
{
    public $content;

    public $data;
    public $category;
    public $categories;

    // public $max_day;

    protected $rules = [
        'content' => 'required|min:4',
        'category' => 'required',
    ];

    // public function mount() {
    //     $this->data = Todo::visibleAttributes()->get()->toArray();

    //     $this->categories = TodoCategory::all();
    //     $this->category = $this->categories[0]->id;
    // }

    protected function init() {
        $this->data = $this->viewingTeam->todos()->get();
        // $this->max_day = $this->data->reduce(fn($last, $item) => $item->day > $last ? $item->day : $last, 0);
    }

    // public function submit()
    // {
    //     $this->validate();

    //     // Execution doesn't reach here if validation fails.

    //     $category = TodoCategory::find($this->category);

    //     $item = $category->todos()->create([
    //         'message' => $this->content,
    //     ]);

    //     $newData = [
    //         'id' => $item->id,
    //         'message' => $item->message,
    //         'category' => $category->name,
    //     ];

    //     $this->data[] = $newData;

    //     $this->resetForm();

    //     $this->modalSuccess('Saved!');
    // }

    // private function resetForm() {
    //     $this->reset(['content']);
    // }

    // public function delete(Todo $item) {
    //     $item->delete();
    //     $this->data = array_filter($this->data, fn ($e) => $e['id'] != $item->id);
    //     $this->modalSuccess('Deleted!');
    // }

    public function render()
    {
        return view('livewire.checklist-page')
            ->layout('layouts.app', ['title' => 'Checklist']);
    }
}
