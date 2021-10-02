<?php

namespace App\Http\Controllers;

use App\Http\Resources\DiscoveryResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Discovery;
use App\Models\Team;

class DiscoveryController extends Controller
{

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/discoveries';
    const MODE_UPDATE = 'update';
    const MODE_CREATE = 'create';

    private $viewingTeam;

    
    public function mobileIndex()
    {
        $team = Auth::user()->currentTeam;
        
        $discoveries = $team->discoveries()->get();

        return DiscoveryResource::collection($discoveries)->response();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        $discoveries = $viewingTeam ? $viewingTeam->discoveries()->get() : collect();

        return view('discoveries.index', compact('discoveries', 'viewingTeam'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        return view('discoveries.create', compact('viewingTeam'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validateViewingTeam();

        $input = $this->validateInput($request);

        $this->viewingTeam->discoveries()->create($input);
            
        return redirect()->route('discoveries.index')
                        ->with('success','Discovery created successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Discovery  $discovery
     * @return \Illuminate\Http\Response
     */
    public function show(Discovery $discovery)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Discovery  $discovery
     * @return \Illuminate\Http\Response
     */
    public function edit(Discovery $discovery)
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        return view('discoveries.edit', compact('viewingTeam', 'discovery'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Discovery  $discovery
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Discovery $discovery)
    {
        $this->validateViewingTeam();
        $input = $this->validateInput($request);
    
        $discovery->update($input);
        
        return redirect()->route('discoveries.index')
                        ->with('success','Discovery updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Discovery  $discovery
     * @return \Illuminate\Http\Response
     */
    public function destroy(Discovery $discovery)
    {
        $this->validateViewingTeam();

        $discovery->delete();

        return redirect()->route('discoveries.index')
                            ->with('success', 'Discovery deleted');
    }

    private function validateInput(Request $request){
        $request->validate([
            'image' => 'required|min:4',
            'title' => 'required|min:4',
            'address' => 'required|min:4',
            'place' => 'required|min:4',
        ]);
  
        $input = $request->all();
        return $input;
    }

    private function validateViewingTeam() {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        if (!isset($viewingTeam)) {
            return redirect()->route('discoveries.index')
                            ->with('error', 'Please choose tour first');
        }

        $this->viewingTeam = $viewingTeam;
    }
}
