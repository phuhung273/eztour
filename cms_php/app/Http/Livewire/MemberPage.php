<?php

namespace App\Http\Livewire;

use App\Models\User;
use Illuminate\Support\Facades\Http;

class MemberPage extends BaseTeamPage
{
    public $admins = [];
    public $adminOptions;

    public $normalUserName;
    public $updateNormalUserName;
    public $adminId;

    public $normalUsers = [];

    public $file;

    protected function init() {
        if ($this->viewingTeam) {
            $this->normalUsers = $this->viewingTeam->normalUsers()
                            ->get()
                            ->map(fn($user) => $this->parseRow($user))->all();
    
            $this->admins = $this->viewingTeam->admins()->get();
        }

        $this->adminOptions = User::admins()->get();
        $this->adminId = $this->adminOptions->first()->id;
    }

    private function parseRow($row) {
        return [
            'id' => $row->id,
            'name' => $row->name,
        ];
    }

    public function addNormalUser($data){
        $this->normalUserName = $data['normalUserName'];
        $this->validate([
            'normalUserName' => 'required|min:4',
        ]);

        $user = User::createNormalUser($this->normalUserName);
        
        if ($user) {
            $this->viewingTeam->addNormalUser($user);

            $response = Http::post(config('app.chat_server') . '/users', [
                'id' => $user->id,
                'name' => $user->name,
            ]);

            if($response->successful()){
                $newUser = $this->parseRow($user);
                $this->normalUsers[] = $newUser;
                $this->modalSuccess('Traveller added!');
        
                $this->reset(['normalUserName']);
    
                return [
                    'data' => $newUser
                ];
            }

        }
    }

    public function update(User $user, $data){
        $this->updateNormalUserName = $data['updateNormalUserName'];
        $this->validate([
            'updateNormalUserName' => 'required|min:4',
        ]);

        $user->updateNormalUser($this->updateNormalUserName);
        
        $response = Http::put(config('app.chat_server') . '/users/' . $user->id, [
            'name' => $user->name,
        ]);

        if($response->successful()){
            $updatedUser = $this->parseRow($user);
            $this->normalUsers = array_map(fn($row) => $row['id'] == $updatedUser['id'] ? $updatedUser : $row, $this->normalUsers);
            $this->modalSuccess('Traveller updated!');
    
            $this->reset(['updateNormalUserName']);

            return [
                'data' => $updatedUser
            ];
        }
    }

    public function addAdmin(){

        $this->validate([
            'adminId' => 'required',
        ]);

        $user = User::find($this->adminId);

        if ($user) {
            $this->admins[] = $user;
            $this->viewingTeam->addAdmin($user);
            $this->modalSuccess('Tour guide added!');
            $this->reset(['adminId']);
        }
    }

    public function delete(User $item) {
        $item->delete();
        $response = Http::delete(config('app.chat_server') . '/users/' . $item->id);
        if ($response->successful()) {
            $this->normalUsers = array_filter($this->normalUsers, fn ($e) => $e['id'] != $item->id);
            $this->modalSuccess('Deleted!');
        }
    }

    public function render()
    {
        return view('livewire.member-page')
        ->layout('layouts.app', ['title' => 'Member']);
    }
}
