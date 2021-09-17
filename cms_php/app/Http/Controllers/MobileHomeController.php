<?php

namespace App\Http\Controllers;

use App\Http\Resources\TodoCategoryResource;
use App\Models\Announcement;
use App\Models\Greeting;
use App\Models\Location;
use App\Models\Todo;
use App\Models\TodoCategory;
use App\Models\Tour;
use Illuminate\Http\Request;

class MobileHomeController extends Controller
{
    /**
     * Provide resource for app's home page.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, Tour $tour)
    {
        $request->validate([
            'local_time' => 'required',
        ]);

        $input = $request->all();

        $local_time = strtotime($input['local_time']);

        $greeting_message = Greeting::getSuitableMessage($local_time);

        $todoCategories = TodoCategory::limit(3)->get();

        $announcements = Announcement::limit(3)->get();

        $start_date = $tour->start_date;

        $max_day = Location::max('day');

        return [
            'greeting' => $greeting_message,
            'todoCategories' => TodoCategoryResource::collection($todoCategories),
            'announcements' => $announcements,
            'start_date' => $start_date,
            'max_day' => $max_day,
        ];
    }
}
