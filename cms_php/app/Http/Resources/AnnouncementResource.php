<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class AnnouncementResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        $category = $this->whenLoaded('announcementCategory');

        return [
            'id' => $this->id,
            'message' => $this->message,
            'category' => $category->name,
        ];
    }
}
