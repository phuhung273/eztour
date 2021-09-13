<?php

namespace App\Http\Livewire;

use App\Helpers\TimeHelper;
use App\Models\Greeting;

class GreetingPage extends BaseComponent
{
    const DEFAULT_TIME              = '6:00 AM';

    public $content;
    public $alarm_time = self::DEFAULT_TIME;
    
    public $data;

    protected $rules = [
        'content' => 'required|min:4',
        'alarm_time' => 'required',
    ];

    public function mount() {
        $this->data = Greeting::all()->toArray();
        foreach ($this->data as $row) {
            $row['alarm_time'] = TimeHelper::his2gia($row['alarm_time']);
        }
    }

    public function submit()
    {
        $this->validate();

        // Execution doesn't reach here if validation fails.

        $item = new Greeting([
            'message' => $this->content,
            'alarm_time' => TimeHelper::gia2his($this->alarm_time),
        ]);

        $item->save();

        $newData = [
            'id' => $item->id,
            'message' => $item->message,
            'alarm_time' => $item->alarm_time,
        ];

        $this->data[] = $newData;

        $this->modalSuccess('Saved!');

        $this->resetForm();
    }

    private function resetForm() {
        $this->reset(['content', 'alarm_time']);
    }

    public function delete(Greeting $item) {
        $item->delete();
        $this->data = array_filter($this->data, fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.greeting-page')
            ->layout('layouts.app', ['title' => 'Greeting']);
    }
}
