<?php

namespace App\Http\Livewire;

use App\Helpers\TimeHelper;
use App\Models\Location;
use App\Models\Team;
use Livewire\WithFileUploads;

class SchedulePage extends BaseTourPage
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

    public $data;
    public $max_day;

    protected $rules = [
        'label' => 'required|min:4',
        'image' => 'image|max:1024',
        'description' => 'required|min:4',
        'day' => 'required',
        'from' => 'required',
        'to' => 'required',
    ];


    protected function init() {
        $this->data = $this->viewingTeam->locations()->get();
        $this->max_day = $this->data->reduce(fn($last, $item) => $item->day > $last ? $item->day : $last, 0);
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $image_name = $this->image->getClientOriginalName();
        $this->image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);

        $item = $this->viewingTeam->locations()->create([
            'image' => $image_name,
            'name' => $this->label,
            'description' => $this->description,
            'day' => $this->day,
            'from' => TimeHelper::gia2his($this->from),
            'to' => TimeHelper::gia2his($this->to),
        ]);

        $this->data->push($item);

        $this->max_day = $this->max_day < $this->day ? $this->day : $this->max_day;

        $this->modalSuccess('Saved!');

        $this->resetForm();
    }

    private function resetForm() {
        $this->reset(['description', 'from', 'to']);
    }

    public function delete(Location $item) {
        $item->delete();
        $this->data = $this->data->filter(fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.schedule-page')
            ->layout('layouts.app', ['title' => 'Schedule']);
    }
}
