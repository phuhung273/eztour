<?php

namespace App\Http\Livewire;

use App\Models\Announcement;
use Livewire\Component;

class AnnouncementPage extends Component
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

        $this->data->push($item);

        $this->resetForm();
    }

    private function resetForm() {
        $this->content = null;
    }

    public function render()
    {
        return view('livewire.announcement-page')
            ->layout('layouts.app', ['title' => 'Announcement']);;
    }
}
