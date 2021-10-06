<?php

namespace App\Http\Livewire;

use App\Models\Todo;
use App\Models\TodoCategory;

class ChecklistPage extends BaseTeamPage
{
    public $data;
    public $categories;

    public $content;
    public $category;
    public $updateContent;
    public $updateCategory;

    protected function init() {
        if ($this->viewingTeam) {
            $this->data = $this->viewingTeam->todos()
                                            ->with('todoCategory')
                                            ->get()
                                            ->sortBy('todoCategory.name');
        }else {
            $this->data = collect();
        }
        $this->categories = TodoCategory::all();
    }

    public function create($data)
    {
        $this->validateCrudPermission();

        $this->content = $data['content'];
        $this->category = $data['category'];
        $this->validate([
            'content' => 'required|min:4',
            'category' => 'required',
        ]);

        // Execution doesn't reach here if validation fails.

        $category = TodoCategory::find($this->category);

        $item = new Todo;
        $item->message = $this->content;
        // Save multiple relationship
        $item->todoCategory()->associate($category);
        $item->team()->associate($this->viewingTeam);
        $item->save();

        $this->data[] = $item;

        $this->modalSuccess('Saved!');

        return [
            'data' => $item,
        ];
    }

    public function update(Todo $item, $data){
        $this->validateCrudPermission();

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
        $this->validateCrudPermission();
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
