<?php

namespace App\Http\Livewire;

use App\Imports\NormalUserImport;
use App\Models\User;
use Livewire\WithFileUploads;
use Maatwebsite\Excel\Facades\Excel;
class MemberPage extends BaseTourPage
{
    use WithFileUploads;

    public $admins;
    public $adminOptions;

    public $normalUserName;
    public $adminId;

    public $normalUsers;

    public $file;

    protected function init() {
        $this->normalUsers = $this->viewingTeam->normalUsers()
                        ->get()
                        ->map(fn($user) => $this->parseRow($user))->all();

        $this->admins = $this->viewingTeam->admins()->get();

        $this->adminOptions = User::admins()->get();
        $this->adminId = $this->adminOptions->first()->id;
    }

    private function parseRow($row) {
        return [
            'id' => $row->id,
            'name' => $row->name,
        ];
    }

    public function addNormalUser(){

        $this->validate([
            'normalUserName' => 'required',
        ]);

        $user = User::createNormalUser($this->normalUserName);
        $this->viewingTeam->addNormalUser($user);

        if ($user) {
            $this->normalUsers[] = $this->parseRow($user);
            $this->modalSuccess('Traveller added!');
    
            $this->reset(['normalUserName']);
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

    public function importExcel(){

        $this->validate([
            'file' => 'required',
        ]);

        // Output: ['Nguyễn Văn A', 'Quách Thị B']
        $names = Excel::toCollection(new NormalUserImport, $this->file)->first();

        $users = User::bulkCreateNormalUser($names);

        if ($users) {
            $this->viewingTeam->bulkAddNormalUser($users);
            $users = $users->map(fn($user) => $this->parseRow($user));
            $this->normalUsers = [...$this->normalUsers, ...$users];
            $this->modalSuccess('Travellers added!');
            $this->reset(['file']);
        }
    }

    public function delete(User $item) {
        $item->delete();
        $this->normalUsers = array_filter($this->normalUsers, fn ($e) => $e['id'] != $item->id);
        $this->modalSuccess('Deleted!');
    }

    public function render()
    {
        return view('livewire.member-page')
        ->layout('layouts.app', ['title' => 'Member']);
    }
}
