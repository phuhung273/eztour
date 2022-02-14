<?php

namespace App\Http\Controllers;

use App\Http\Resources\DiscoveryResource;
use App\Models\Image;
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

        $request->validate([
//            'image' => 'required|image|max:1024',
            'title' => 'required|min:4',
            'address' => 'required|min:4',
            'place' => 'required|min:4',
        ]);

        $input = $request->all();

        $team = $this->viewingTeam->discoveries()->create($input);

        foreach ($request->file('image') as $key=>$value){
            if ($image = $value) {
                $image_name = date("Ymdhys")."_".$image->getClientOriginalName();
                $image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);
                $input['image'] = $image_name;
            }else{
                unset($input['image']);
            }
            $img['src'] = $input['image'];
            $team->images()->save(new Image($img));
        }
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
//        dd($request->all());

        $this->validateViewingTeam();

        $request->validate([
            'title' => 'required|min:4',
            'place' => 'required|min:4',
            'address' => 'required|min:4',
        ]);

//        $input = $this->validateInput($request);
        $input = $request->all();
        $discovery->update($input);

        if ($images = $request->file('images')) {
            foreach ($images as $key=>$image){
                $image_name = date("Ymdhys")."_".$image->getClientOriginalName();
                $image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);
                $discovery_image = $discovery->images()->find($key);
                $discovery_image->src = $image_name;
                $discovery_image->save();
            }
        }
        if($images = $request->file('new_images')){
//            dd('new');
            foreach ($images as $image){
                $image_name = date("Ymdhys")."_".$image->getClientOriginalName();
                $image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);
                $img['src'] = $image_name;
                $discovery->images()->save(new Image($img));
            }
        }
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

    private function validateViewingTeam() {
        $viewingTeam = Team::find(session(config('app.viewing_team_session_key')));

        if (!isset($viewingTeam)) {
            return redirect()->route('discoveries.index')
                            ->with('error', 'Please choose tour first');
        }

        $this->viewingTeam = $viewingTeam;
    }

//    private function validateInput(Request $request){
//
//        $input = $request->all();
//
//        if ($image = $request->file('images')) {
//            $image_name = date("Ymdhys")."_".$image->getClientOriginalName();
//            $image->storeAs(self::IMAGE_STORAGE_DIRECTORY, $image_name);
//            $input['image'] = $image_name;
//        }else{
//            unset($input['image']);
//        }
//
//        return $input;
//    }
}
