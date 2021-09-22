<?php

namespace App\Http\Livewire;

use Exception;
use Livewire\WithFileUploads;

use Illuminate\Support\Facades\Auth;

class DashboardPage extends BaseComponent
{
    use WithFileUploads;

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';

    public $data;
    public $defaultTeam;

    public $date;
    public $name;
    public $image;

    protected $rules = [
        'name' => 'required|min:10',
        'date' => 'required',
        'image' => 'required',
    ];

    public function mount() {
        $user = Auth::user();
        $teamList = $user->ownedTeams()->get();
        $this->defaultTeam = $teamList->first();

        $currentTeam = null;
        try {
            $currentTeam = $user->currentTeam;
        } catch (Exception $e) {
        }

        $this->data = $teamList->map(function($item, $key) use ($currentTeam){
            return $this->parseRow($item, $currentTeam);
        });

        $this->date = date("Y-m-d");
    }

    private function parseRow($team, $currentTeam) {
        return [
            'id' => $team->id,
            'image' => $this->parseTeam($team),
            'current' => $this->parseStatus($currentTeam ? $currentTeam->id == $team->id : false),
            'start_date' => $team->start_date,
        ];
    }

    private function parseStatus($status){
        return $status
            ? '<span
                class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">
                Owned
            </span>'
            : '';
    }

    private function parseTeam($team){
        $url = asset("storage/img/locations/{$team->image}");

        return "<div class='flex items-center text-sm'>
                    <div class='w-40 mr-3 rounded-lg md:block'>
                        <img src='{$url}' />
                    </div>
                    <div class='w-60'>
                        <p class='font-semibold whitespace-normal'>{$team->name}</p>
                    </div>
                </div>";
    }

    public function submit(){
        $this->validate();

        $image_name = $this->image->getClientOriginalName();
        $this->image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);

        $user = Auth::user();
        $this->defaultTeam = $user->ownedTeams()->create([
            'name' => $this->name,
            'personal_team' => false,
            'start_date' => $this->date,
            'image' => $image_name,
        ]);

        $this->data[] = $this->defaultTeam;

        $this->modalSuccess('Tour created successfully!');

        $this->resetForm();
    }

    private function resetForm() {
        $this->reset(['name']);
    }

    public function render()
    {
        return view('livewire.dashboard-page')
        ->layout('layouts.app', ['title' => 'Dashboard']);
    }
}
