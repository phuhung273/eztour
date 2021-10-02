<?php
 
namespace App\Http\Controllers;

use App\Helpers\TimeHelper;
use App\Models\Location;
use App\Models\Team;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;

class LocationController extends Controller
{

    const IMAGE_STORAGE_DIRECTORY   = 'public/img/locations';
    const MODE_UPDATE = 'update';
    const MODE_CREATE = 'create';

    private $viewingTeam;

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        $locations = $viewingTeam ? $viewingTeam->locations()->get() : collect();

        $max_day = $locations->max('day') ?? 0;

        return view('locations.index', compact('locations', 'max_day', 'viewingTeam'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        return view('locations.create', compact('viewingTeam'));
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

        $input = $this->validateInput($request, self::MODE_CREATE);

        if (!isset($input)) {
            return back()->withErrors([
                'from' => 'Invalid time',
                'to' => 'Invalid time',
            ])->withInput();
        }

        $this->viewingTeam->locations()->create($input);
            
        return redirect()->route('locations.index')
                        ->with('success','Location created successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Location  $location
     * @return \Illuminate\Http\Response
     */
    public function show(Location $location)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Location  $location
     * @return \Illuminate\Http\Response
     */
    public function edit(Location $location)
    {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        return view('locations.edit', compact('viewingTeam', 'location'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Location  $location
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Location $location)
    {
        $this->validateViewingTeam();
        $input = $this->validateInput($request, self::MODE_UPDATE, $location->id);

        if (!isset($input)) {
            return back()->withErrors([
                'from' => 'Invalid time',
                'to' => 'Invalid time',
            ])->withInput();
        }
    
        $location->update($input);
        
        return redirect()->route('locations.index')
                        ->with('success','Location updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Location  $location
     * @return \Illuminate\Http\Response
     */
    public function destroy(Location $location)
    {
        $this->validateViewingTeam();

        $location->delete();

        return redirect()->route('locations.index')
                            ->with('success', 'Location deleted');
    }

    private function validateInput(Request $request, string $mode, $id=null){
        if ($mode == self::MODE_CREATE) {
            $request->validate([
                'image' => 'required|image|max:1024',
                'name' => 'required|min:4',
                'description' => 'required|min:20',
                'day' => 'required',
                'from' => 'required',
                'to' => 'required',
            ]);

            if ($this->viewingTeam->isTimeInvalid($request->from, $request->to, $request->day)) {
                return null;
            }
        } elseif ($mode = self::MODE_UPDATE && isset($id)) {
            if (isset($id)) {
                return null;
            }
            
            $request->validate([
                'name' => 'required|min:4',
                'description' => 'required|min:20',
                'day' => 'required',
                'from' => 'required',
                'to' => 'required',
            ]);

            if ($this->viewingTeam->isTimeInvalid($request->from, $request->to, $request->day, $id)) {
                return null;
            }
        }
  
        $input = $request->all();
  
        if ($image = $request->file('image')) {
            $image_name = $image->getClientOriginalName();
            $image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);
            $input['image'] = $image_name;
        }else{
            unset($input['image']);
        }

        $input['from'] = TimeHelper::gia2his($input['from']);
        $input['to'] = TimeHelper::gia2his($input['to']);

        return $input;
    }

    private function validateViewingTeam() {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        if (!isset($viewingTeam)) {
            return redirect()->route('locations.index')
                            ->with('error', 'Please choose tour first');
        }

        $this->viewingTeam = $viewingTeam;
    }
}
