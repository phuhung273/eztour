<?php

namespace App\Http\Livewire;

use App\Models\Team;
use App\Models\User;

class MemberPage extends BaseComponent
{
    public $viewingTeam;
    public $tourGuideList;
    public $tourGuideOptions;

    public $travellerName;
    public $tourGuideId;

    public $travellers;


    public function mount() {
        $viewingTeamId = session(config('app.viewing_team_session_key'));

        if ($viewingTeamId) {
            $this->viewingTeam = Team::find($viewingTeamId);
            $this->travellers = $this->viewingTeam->travellers()
                            ->get()
                            ->map(fn($user) => $this->parseRow($user))->all();

            $this->tourGuideList = $this->viewingTeam->admins()->get();
        }

        $this->tourGuideOptions = User::admins()->get();
    }

    private function parseRow($user) {
        return [
            'id' => $user->id,
            'name' => $user->name,
        ];
    }

    public function addTourGuide(){

        $user = User::find($this->tourGuideId);
        $this->tourGuideList[] = $user;
        $this->viewingTeam->addAdmin($user);

        $this->modalSuccess('Tour guide added!');

        $this->reset(['tourGuideId']);
    }

    public function render()
    {
        return view('livewire.member-page')
        ->layout('layouts.app', ['title' => 'Member']);
    }
}
