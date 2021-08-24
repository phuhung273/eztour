<?php

namespace App\Http\Livewire\Forms;

use Livewire\Component;

class InputNumber extends Component
{
    public $value = 0;

    public function increment(){
        $this->value++;
    }

    public function render()
    {
        return view('livewire.forms.input-number');
    }
}
