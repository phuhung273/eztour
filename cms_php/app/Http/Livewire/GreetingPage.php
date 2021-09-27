<?php

namespace App\Http\Livewire;

use App\Helpers\TimeHelper;
use App\Models\Greeting;

class GreetingPage extends BaseComponent
{
    public $data;

    public $content;
    public $alarmTime;
    public $updateContent;
    public $updateAlarmTime;
    

    public function mount() {
        $this->data = Greeting::all();
        foreach ($this->data as $row) {
            $row->alarm_time = TimeHelper::his2gia($row->alarm_time);
        }
    }

    public function create($data)
    {
        $this->content = $data['content'];
        $this->alarmTime = $data['alarmTime'];
        $this->validate([
            'content' => 'required|min:4',
            'alarmTime' => 'required',
        ]);

        // Execution doesn't reach here if validation fails.

        $item = new Greeting([
            'message' => $this->content,
            'alarm_time' => TimeHelper::gia2his($this->alarmTime),
        ]);

        $item->save();

        $item->alarm_time = TimeHelper::his2gia($item->alarm_time);
        $this->data[] = $item;

        $this->modalSuccess('Saved!');

        return [
            'data' => $item,
        ];
    }

    public function update(Greeting $item, $data){
        $this->updateContent = $data['updateContent'];
        $this->updateAlarmTime = $data['updateAlarmTime'];
        $this->validate([
            'updateContent' => 'required|min:4',
            'updateAlarmTime' => 'required',
        ]);

        $item->message = $this->updateContent;
        $item->alarm_time = TimeHelper::gia2his($this->updateAlarmTime);
        $result = $item->save();

        $item->alarm_time = TimeHelper::his2gia($item->alarm_time);

        if ($result) {
            $this->data->transform(fn($row) => $row->id == $item->id ? $item : $row);

            $this->modalSuccess('Updated!');
        }

        return [
            'data' => $item
        ];
    }

    public function delete(Greeting $item) {
        $item->delete();
        $this->data = $this->data->filter(fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.greeting-page')
            ->layout('layouts.app', ['title' => 'Greeting']);
    }
}
