<?php

namespace App\Http\Controllers;

use App\Helpers\TimeHelper;
use App\Models\Location;
use Illuminate\Http\Request;

class LocationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $locations = Location::getVisibleAttribute();

        $days = array_map(fn($location) => $location->day, $locations->all());

        $max_day = empty($days) ? 0 : max($days);

        return [
            'locations' => $locations,
            'max_day' => $max_day,
        ];
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|min:5',
            'description' => 'required|min:5',
            'day' => 'required',
            'from' => 'required',
            'to' => 'required',
        ]);

        $input = $request->all();

        if ($request->hasFile('image')) {
            $destination_path = 'public/img/locations';
            $image = $request->file('image');
            $image_name = $image->getClientOriginalName();
            $request->file('image')->storeAs($destination_path, $image_name);

            $input['image'] = $image_name;
        }

        $input['tour_id'] = 1;
        $input['from'] = TimeHelper::gia2his($input['from']);
        $input['to'] = TimeHelper::gia2his($input['to']);

        Location::create($input);

        return back();
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
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Location  $location
     * @return \Illuminate\Http\Response
     */
    public function destroy(Location $location)
    {
        $location->delete();

        return back();
    }
}
