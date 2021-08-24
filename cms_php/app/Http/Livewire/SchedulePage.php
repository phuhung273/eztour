<?php

namespace App\Http\Livewire;

use App\Models\Location;
use Livewire\Component;
use Livewire\WithFileUploads;

class SchedulePage extends Component
{
    use WithFileUploads;

    public $image;
    public $label;
    public $description;
    public $day = 0;
    public $from;
    public $to;
    
    public $locations;

    protected $rules = [
        'label' => 'required|min:5',
        'image' => 'image|max:1024',
        'description' => 'required|min:5',
        'day' => 'required|digits',
        'from' => 'required',
        'to' => 'required',
    ];

    const IMAGE_STORAGE_DIRECTORY = 'public/img/locations';

    public function mount() {
        // $this->locations = Location::all();
        $this->locations = collect([]);
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $image_name = $this->image->getClientOriginalName();
        $this->image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);

        $location = new Location([
            'image' => $this->image,
            'name' => $this->label,
            'description' => $this->description,
            'day' => $this->day,
            'from' => $this->from,
            'to' => $this->to,
        ]);

        $location->save();

        $this->locations->push($location);
    }

    public function increment()
    {
        $this->day++;
    }

    public function render()
    {
        return view('livewire.schedule-page')
            ->layout('layouts.app', ['title' => 'Schedule']);;
    }
}
