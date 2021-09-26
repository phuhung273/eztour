<?php

namespace App\Http\Livewire;

use Livewire\Component;

class BaseComponent extends Component
{
    protected function modalSuccess($message = 'Success!'){
        $this->dispatchBrowserEvent('swal:modal', [
            'type' => 'success',
            'title' => $message,
        ]);
    }

    protected function modalFail($message = 'Failed!', $instruction = 'Contact admin for support!'){
        $this->dispatchBrowserEvent('swal:modal', [
            'type' => 'error',
            'title' => $message,
            'text' => $instruction,
        ]);
    }
}
