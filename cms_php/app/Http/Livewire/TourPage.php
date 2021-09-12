<?php

namespace App\Http\Livewire;

use App\Models\Tour;
use Livewire\Component;

class TourPage extends Component
{
    public $date;

    public $tour;

    protected $rules = [
        'date' => 'required',
    ];

    public function mount() {
        $this->tour = Tour::find(1);
        $this->date = $this->tour->start_date;
    }

    public function submit(){
        $this->validate();

        $this->tour->start_date = $this->date;
        $this->tour->save();

        $this->dispatchBrowserEvent('swal:modal', [
            'type' => 'success',  
            'message' => 'Success!',
            'text' => 'Update successfully!', 
        ]);
    }

    public function render()
    {
        return view('livewire.tour-page')
        ->layout('layouts.app', ['title' => 'Tour']);
    }
}
