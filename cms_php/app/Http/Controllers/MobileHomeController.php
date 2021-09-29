<?php

namespace App\Http\Controllers;

use App\Http\Resources\TeamResource;
use App\Models\Greeting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MobileHomeController extends Controller
{
    /**
     * Provide resource for app's home page.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $request->validate([
            'local_time' => 'required',
        ]);

        $team = Auth::user()->currentTeam;

        $input = $request->all();

        $local_time = strtotime($input['local_time']);

        $greeting_message = Greeting::getSuitableMessage($local_time);

        $teamResource = new TeamResource($team);

        return [
            'greeting' => $greeting_message,
            'tour' => $teamResource,
        ];
    }
}
