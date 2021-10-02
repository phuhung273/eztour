<?php

namespace App\Http\Livewire;

use Livewire\Component;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class RegisterPage extends BaseComponent
{
    public $data;

    public $name;
    public $email;
    public $password;
    public $updateName;
    public $updateEmail;
    public $updatePassword;

    public function mount() {
        
        $this->data = User::tourguides()->get();
    }

    
    public function create($data)
    {
        $this->name = $data['name'];
        $this->email = $data['email'];
        $this->password = $data['password'];
        $this->validate([
            'name' => 'required|min:4',
            'email' => 'required',
            'password' => 'required|min:8'
        ]);

        // Execution doesn't reach here if validation fails.

        $tourGuide = User::createTourGuide($data);

        $tourGuide->save();

        $this->data[] = $tourGuide;

        $this->modalSuccess('Saved!');

        return [
            'data' => $tourGuide,
        ];
    }

    public function update(User $user, $data){
        $this->updateName = $data['updateName'];
        $this->updateEmail = $data['updateEmail'];
        $this->updatePassword = $data['updatePassword'];
        $this->validate([
            'updateName' => 'required|min:4',
            'updateEmail' => 'required',
            'updatePassword' => 'required|min:8'
        ]);

        $user->name = $this->updateName;
        $user->email = $this->updateEmail;
        $user->password = Hash::make($this->updatePassword);

        $result = $user->save();

        if ($result) {
            $this->data->transform(fn($row) => $row->id == $user->id ? $user : $row);

            $this->modalSuccess('Updated!');

            return [
                'data' => $user
            ];
        }

    }

    public function delete(User $user) {
        $user->delete();
        $this->data = $this->data->filter(fn ($e) => $e['id'] != $user->id);
        $this->modalSuccess('Deleted!');
    }


    public function render()
    {
        return view('livewire.register-page')
            ->layout('layouts.app', ['title' => 'Register']);
    }
}
