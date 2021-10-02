<?php

namespace App\Http\Livewire;

use Livewire\WithFileUploads;

class DiscoveryPage extends BaseTeamPage
{
    use WithFileUploads;

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';

    public $image;
    public $title;
    public $place;
    public $about;
    public $address;

    public $data;

    protected $rules = [
        'title' => 'required|min:4',
        'image' => 'image|max:1024',
        'place' => 'required|min:4',
        'about' => 'nullable',
        'address' => 'required|min:4',
    ];

    protected function init() {
        $this->data = $this->viewingTeam->discoveries()->get();
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $image_name = $this->image->getClientOriginalName().date('Ymdhis');
        $this->image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);

        $item = $this->viewingTeam->discoveries()->create([
            'image' => $image_name,
            'title' => $this->title,
            'place' => $this->place,
            'about' => $this->about,
            'address' => $this->address,
        ]);

        $this->data->push($item);

        $this->modalSuccess('Saved!');

        $this->resetForm();
    }

    public function render()
    {
        return view('livewire.discovery-page')
            ->layout('layouts.app', ['title' => 'Discovery']);
    }
}
