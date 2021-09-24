<?php

namespace App\Http\Livewire;

use App\Models\Team;
use Livewire\WithFileUploads;

use Illuminate\Support\Facades\Auth;

class DashboardPage extends BaseComponent
{
    use WithFileUploads;

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';

    public $data;

    public $viewingTeamId;

    public $name;
    public $date;
    public $image;

    protected $rules = [
        'name' => 'required|min:10',
        'date' => 'required',
        'image' => 'required',
    ];

    public function mount() {
        $teamList = Team::all();

        $this->viewingTeamId = session(config('app.viewing_team_session_key'));

        $this->data = $teamList->map(fn($e) => $this->parseRow($e, $this->viewingTeamId))->all();
        
        $this->date = date("Y-m-d");
    }

    private function parseRow($team, $viewingTeamId) {
        return [
            'id' => $team->id,
            'name' => $team->name,
            'image' => $team->image,
            'viewing' => $viewingTeamId == $team->id,
            'start_date' => $team->start_date,
        ];
    }

    public function submit(){
        $this->validate();

        $image_name = $this->image->getClientOriginalName();
        $this->image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);

        $user = Auth::user();
        $newTeam = $user->ownedTeams()->create([
            'name' => $this->name,
            'personal_team' => false,
            'start_date' => $this->date,
            'image' => $image_name,
        ]);

        $this->data[] = $this->parseRow($newTeam, $user, $this->viewingTeamId);

        $this->modalSuccess('Tour created successfully!');

        $this->resetForm();
    }

    public function changeViewingTeam(Team $team) {

        session([config('app.viewing_team_session_key') => $team->id]);
        $this->viewingTeamId = $team->id;

        $this->data = array_map(function ($row) use ($team) { 
            $row['viewing'] =  $row['id'] == $team->id;
            return $row;
        }, $this->data);

        $this->modalSuccess('Viewing tour changed!');
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
