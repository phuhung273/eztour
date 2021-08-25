<?php

namespace App\Http\Livewire;

use App\Helpers\TimeHelper;
use App\Models\Location;
use Livewire\Component;
use Livewire\WithFileUploads;



class SchedulePage extends Component
{
    use WithFileUploads;

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';
    const DEFAULT_DAY               = 1;
    const DEFAULT_FROM              = '6:00 AM';
    const DEFAULT_TO                = '9:00 AM';

    public $image;
    public $label;
    public $description;
    public $day = self::DEFAULT_DAY;
    public $from = self::DEFAULT_FROM;
    public $to = self::DEFAULT_TO;
    
    public $locations;

    protected $rules = [
        'label' => 'required|min:5',
        'image' => 'image|max:1024',
        'description' => 'required|min:5',
        'day' => 'required',
        'from' => 'required',
        'to' => 'required',
    ];


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
            'image' => $image_name,
            'name' => $this->label,
            'description' => $this->description,
            'day' => $this->day,
            'from' => TimeHelper::gia2his($this->from),
            'to' => TimeHelper::gia2his($this->to),
            'tour_id' => 1
        ]);

        $location->save();

        $this->locations->push($location);
    }

    public function changeImage($imageName){
        $this->image = $imageName;
    }

    public function render()
    {
        return view('livewire.schedule-page')
            ->layout('layouts.app', ['title' => 'Schedule']);;
    }
}
