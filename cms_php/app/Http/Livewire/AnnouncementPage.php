<?php

namespace App\Http\Livewire;

use App\Models\Announcement;

class AnnouncementPage extends BaseComponent
{
    public $content;
    
    public $data;

    protected $rules = [
        'content' => 'required|min:4',
    ];

    public function mount() {
        $this->data = Announcement::all()->toArray();
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $item = new Announcement([
            'message' => $this->content,
        ]);

        $item->save();

        $newData = [
            'id' => $item->id,
            'message' => $item->message,
        ];

        $this->data[] = $newData;

        $this->modalSuccess('Saved!');

        $this->resetForm();
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
