<?php

namespace Database\Seeders;

use App\Models\AnnouncementCategory;
use Illuminate\Database\Seeder;

class AnnouncementCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        AnnouncementCategory::updateOrCreate(
            ['name' => 'Tour info']
        );

        AnnouncementCategory::updateOrCreate(
            ['name' => 'Contacts']
        );

        AnnouncementCategory::updateOrCreate(
            ['name' => 'Others']
        );
    }
}
