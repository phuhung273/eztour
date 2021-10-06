<?php

namespace App\Http\Livewire;

use App\Models\Announcement;
use App\Models\AnnouncementCategory;


class AnnouncementPage extends BaseTeamPage
{
    public $data;
    public $categories;

    public $content;
    public $category;
    public $updateContent;
    public $updateCategory;

    protected function init() {
        if ($this->viewingTeam) {
            $this->data = $this->viewingTeam->announcements()
                                            ->with('announcementCategory')
                                            ->get()
                                            ->sortBy('announcementCategory.name');
        }else {
            $this->data = collect();
        }
        $this->categories = AnnouncementCategory::all();
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

        $category = AnnouncementCategory::find($this->category);

        $item = new Announcement;
        $item->message = $this->content;
        // Save multiple relationship
        $item->announcementCategory()->associate($category);
        $item->team()->associate($this->viewingTeam);
        $item->save();

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
