<?php

namespace App\Http\Controllers;

use App\Http\Resources\DiscoveryResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Discovery;


class DiscoveryController extends Controller
{
    public function index()
    {
        $team = Auth::user()->currentTeam;
        
        $discoveries = $team->discoveries()->get();

        return [
            'locations' => DiscoveryResource::collection($discoveries),
        ];
    }
}
