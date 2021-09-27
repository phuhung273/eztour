<?php

namespace Database\Seeders;

use App\Models\Greeting;
use Illuminate\Database\Seeder;

class GreetingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Greeting::updateOrCreate(
            ['alarm_time' => '06:00:00'],
            ['message' => 'Good morning']
        );

        Greeting::updateOrCreate(
            ['alarm_time' => '12:00:00'],
            ['message' => 'Have a good lunch']
        );

        Greeting::updateOrCreate(
            ['alarm_time' => '15:00:00'],
            ['message' => 'Good afternoon']
        );

        Greeting::updateOrCreate(
            ['alarm_time' => '18:00:00'],
            ['message' => 'Good evening']
        );

        Greeting::updateOrCreate(
            ['alarm_time' => '21:00:00'],
            ['message' => 'Good night']
        );
    }
}
