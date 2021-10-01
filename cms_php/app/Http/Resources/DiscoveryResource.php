<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DiscoveryResource extends JsonResource
{
    const IMAGE_STORAGE_DIRECTORY = "storage/img/discoveries/";
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
            'title' => $this->title,
            'address' => $this->address,
            'image' => asset(self::IMAGE_STORAGE_DIRECTORY. $this->image),
            'about' => $this->about,
            'place' => $this->place,
        ];
    }
}
