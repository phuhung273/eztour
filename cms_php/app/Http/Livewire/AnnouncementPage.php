<?php

namespace App\Http\Livewire;

use App\Models\Announcement;
use App\Models\AnnouncementCategory;


class AnnouncementPage extends BaseComponent
{
    public $data;
    public $categories;

    public $content;
    public $category;
    public $updateContent;
    public $updateCategory;

    public function mount() {
        $this->data = Announcement::with('announcementCategory')->get();
    
        $this->categories = AnnouncementCategory::all();
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

        $category = AnnouncementCategory::find($this->category);

        $item = $category->announcements()->create([
            'message' => $this->content,
        ]);

        $this->data[] = $item;

        $this->modalSuccess('Saved!');

        return [
            'data' => $item,
        ];
    }

    public function update(Announcement $item, $data){
        $this->updateContent = $data['updateContent'];
        $this->updateCategory = $data['updateCategory'];
        $this->validate([
            'updateContent' => 'required|min:4',
            'updateCategory' => 'required',
        ]);

        $category = AnnouncementCategory::find($this->updateCategory);
        $item->message = $this->updateContent;
        
        $item->announcementCategory()->associate($category);
        $result = $item->save();

        if ($result) {
            $this->data->transform(fn($row) => $row->id == $item->id ? $item : $row);

            $this->modalSuccess('Updated!');
        }

        return [
            'data' => $item
        ];
    }

    public function delete(Announcement $item) {
        $item->delete();
        $this->data = $this->data->filter(fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.announcement-page')
            ->layout('layouts.app', ['title' => 'Announcement']);;
    }
}
