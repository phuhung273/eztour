<?php

namespace App\Http\Resources;

use App\Models\AnnouncementCategory;
use App\Models\TodoCategory;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;

class TeamResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        $todoCategories = TodoCategory::with([
            'todos' => fn($query) => $query->where('team_id', $this->id)
        ])
        ->limit(3)->get();

        $announcementCategories = AnnouncementCategory::with([
            'announcements' => fn($query) => $query->where('team_id', $this->id)
        ])
        ->limit(3)->get();

        $max_day = $this->locations()->max('day');

        $locations = $this->overallLocations()->get();
        $locations->transform(function ($item, $key) {
            $item->image = asset(config('app.image_upload_dir') . '/' . $item->image);
            return $item;
        });

        return [
            'todo_categories' => TodoCategoryResource::collection($todoCategories),
            'announcement_categories' => AnnouncementCategoryResource::collection($announcementCategories),
            'start_date' => $this->start_date,
            'max_day' => $max_day,
            'image' => asset(config('app.image_upload_dir') . '/' . $this->image),
            'locations' => $locations,
        ];
    }
}
