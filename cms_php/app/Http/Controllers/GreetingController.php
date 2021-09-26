<?php

namespace App\Http\Controllers;

use App\Helpers\TimeHelper;
use App\Models\Greeting;
use Illuminate\Http\Request;

class GreetingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $greetingCollection = Greeting::all();

        return [
            'greetings' => $greetingCollection
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Greeting  $greeting
     * @return \Illuminate\Http\Response
     */
    public function show(Greeting $greeting)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Greeting  $greeting
     * @return \Illuminate\Http\Response
     */
    public function edit(Greeting $greeting)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Greeting  $greeting
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Greeting $greeting)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Greeting  $greeting
     * @return \Illuminate\Http\Response
     */
    public function destroy(Greeting $greeting)
    {
        
    }
}
