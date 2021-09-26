<?php

namespace App\Http\Livewire;

use App\Models\Announcement;
use App\Models\AnnouncementCategory;


class AnnouncementPage extends BaseComponent
{
    public $content;

    public $data;
    public $category;
    public $categories;

    protected $rules = [
        'content' => 'required|min:4',
        'category' =>'required'
    ];

    public function mount() {
        $this->data = Announcement::visibleAttributes()->get()->toArray();
    
        $this->categories = AnnouncementCategory::all();
        $this->category = $this->categories[0]->id;
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $category = AnnouncementCategory::find($this->category);

        $item = $category->announcements()->create([
            'message' => $this->content,
        ]);

        $newData = [
            'id' => $item->id,
            'message' => $item->message,
            'category' => $category->name,
        ];

        $this->data[] = $newData;

        $this->resetForm();

        $this->modalSuccess('Saved!');
    }

    private function resetForm() {
        $this->reset(['content']);
    }

    public function delete(Announcement $item) {
        $item->delete();
        $this->data = array_filter($this->data, fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.announcement-page')
            ->layout('layouts.app', ['title' => 'Announcement']);;
    }
}
