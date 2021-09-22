<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Model;
class Announcement extends Model
{
    use HasFactory;

    protected $fillable = ['message', 'announcement_category_id'];

    public $timestamps = false;

    public function announcementCategory() {
        return $this->belongsTo(AnnouncementCategory::class);
    }

    public static function visibleAttributes() {
        return (new static)::join('announcement_categories', 'announcement_categories.id', '=', 'announcements.announcement_category_id')
        ->select('announcements.id', 'announcements.message', 'announcement_categories.name as category');
    }

}
