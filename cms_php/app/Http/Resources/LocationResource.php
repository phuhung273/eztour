<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class LocationResource extends JsonResource
{
    const IMAGE_STORAGE_DIRECTORY = "/storage/img/locations/";
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            "name" => $this->name,
            "image" => self::IMAGE_STORAGE_DIRECTORY. $this->image,
            "day" => $this->day,
            "description" => $this->description,
            "from" => $this->from,
            "to" => $this->to,
        ];
    }
}
