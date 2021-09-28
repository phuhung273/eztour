<?php

namespace App\Http\Livewire;

use App\Models\Team;
use Exception;
use Livewire\WithFileUploads;

use Illuminate\Support\Facades\Auth;

class DashboardPage extends BaseComponent
{
    use WithFileUploads;

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';

    public $data;

    public $currentTeam;
    public $viewingTeamId;

    public $name;
    public $date;
    public $image;

    public function mount() {
        $user = Auth::user();
        $teamList = Team::all();

        try {
            $this->currentTeam = $user->currentTeam;
        } catch (Exception $e) {
        }

        $this->viewingTeamId = session(config('app.viewing_team_session_key'));

        $this->data = $teamList->map(fn($e) => $this->parseRow($e, $user, $this->viewingTeamId))->all();
        
        $this->date = date("Y-m-d");
    }

    private function parseRow($team, $user, $viewingTeamId) {
        return [
            'id' => $team->id,
            'name' => $team->name,
            'image' => $team->image,
            'current' => $this->currentTeam ? $user->isCurrentTeam($team) : false,
            'viewing' => $viewingTeamId == $team->id,
            'start_date' => $team->start_date,
        ];
    }

    public function create($data){
        $this->name = $data['name'];
        $this->date = empty($data['date']) ? date("Y-m-d") : $data['date'];
        $this->validate([
            'name' => 'required|min:10',
            'date' => 'required',
            'image' => 'required',
        ]);

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

        return [
            "data" => $newTeam
        ];
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

    public function changeCurrentTeam(Team $team) {
        $user = Auth::user();

        if ($user->isTeamMember($team)) {

            if ($user->switchTeam($team)) {
            
                $this->data = array_map(function ($row) use ($team) { 
                    $row['current'] = $row['id'] == $team->id;
                    return $row;
                }, $this->data);
    
                $this->modalSuccess('Default tour changed!');
            }
        } else {
            $this->modalFail("You're not tour guide", "Go to Member Page to make yourself tour guide");
        }
    }

    public function render()
    {
        return view('livewire.dashboard-page')
        ->layout('layouts.app', ['title' => 'Dashboard']);
    }
}
