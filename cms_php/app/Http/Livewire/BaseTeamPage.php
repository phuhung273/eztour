<?php

namespace App\Http\Livewire;

use App\Models\Team;
use Illuminate\Support\Facades\Auth;

abstract class BaseTeamPage extends BaseComponent
{
    public $viewingTeam;

    public function mount() {
        $viewingTeamId = session(config('app.viewing_team_session_key'));

        if ($viewingTeamId) {
            $this->viewingTeam = Team::find($viewingTeamId);
            $this->init();
        }
    }

    protected function validateCrudPermission(){
        $user = Auth::user();

        if (!$user->is_admin || !$user->isTeamAdmin($this->viewingTeam)) {
            $this->modalFail("You're not tour guide", "Go to Member Page to make yourself tour guide");
            return;
        }
    }

    abstract protected function init();
}
