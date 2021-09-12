<?php

namespace Database\Seeders;

use App\Models\TodoCategory;
use Illuminate\Database\Seeder;

class TodoCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TodoCategory::updateOrCreate(
            ['name' => 'Travel Documents']
        );

        TodoCategory::updateOrCreate(
            ['name' => 'Clothing Essentials']
        );
    }
}
