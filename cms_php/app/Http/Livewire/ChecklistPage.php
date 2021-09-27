<?php

namespace App\Http\Livewire;

use App\Models\Todo;
use App\Models\TodoCategory;

class ChecklistPage extends BaseComponent
{
    public $data;
    public $categories;

    public $content;
    public $category;
    public $updateContent;
    public $updateCategory;

    public function mount() {
        $this->data = Todo::with('todoCategory')->get();

        $this->categories = TodoCategory::all();
    }

    public function create($data)
    {
        $this->content = $data['content'];
        $this->category = $data['category'];
        $this->validate([
            'content' => 'required|min:4',
            'category' => 'required',
        ]);

        // Execution doesn't reach here if validation fails.

        $category = TodoCategory::find($this->category);

        $item = $category->todos()->create([
            'message' => $this->content,
        ]);

        $this->data[] = $item;

        $this->modalSuccess('Saved!');

        return [
            'data' => $item,
        ];
    }

    public function update(Todo $item, $data){
        $this->updateContent = $data['updateContent'];
        $this->updateCategory = $data['updateCategory'];
        $this->validate([
            'updateContent' => 'required|min:4',
            'updateCategory' => 'required',
        ]);

        $category = TodoCategory::find($this->updateCategory);
        $item->message = $this->updateContent;
        
        $item->todoCategory()->associate($category);
        $result = $item->save();

        if ($result) {
            $this->data->transform(fn($row) => $row->id == $item->id ? $item : $row);

            $this->modalSuccess('Updated!');
        }

        return [
            'data' => $item
        ];
    }

    public function delete(Todo $item) {
        $item->delete();
        $this->data = $this->data->filter(fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.checklist-page')
            ->layout('layouts.app', ['title' => 'Checklist']);
    }
}
