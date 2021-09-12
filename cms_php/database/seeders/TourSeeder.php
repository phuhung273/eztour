<?php

namespace Database\Seeders;

use App\Models\Tour;
use Illuminate\Database\Seeder;

class TourSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Tour::updateOrCreate(
            ['name' => 'Du Lịch Châu Âu: Pháp (Làng cổ Colmar) - Thụy Sĩ - Ý'],
            ['start_date' => '2021-09-11']
        );
    }
}
