<?php

namespace App\Http\Livewire;

use App\Models\Team;

abstract class BaseTourPage extends BaseComponent
{
    public $viewingTeam;

    public function mount() {
        $viewingTeamId = session(config('app.viewing_team_session_key'));

        if ($viewingTeamId) {
            $this->viewingTeam = Team::find($viewingTeamId);
            $this->init();
        }
    }

    abstract protected function init();
}
