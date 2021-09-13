<?php

namespace App\Http\Livewire;

use Livewire\Component;

class BaseComponent extends Component
{
    protected function modalSuccess($message = 'Success!'){
        $this->dispatchBrowserEvent('swal:modal', [
            'type' => 'success',  
            'message' => $message,
        ]);
    }
}
