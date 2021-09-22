<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::firstOrCreate([
            'name' => 'Admin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make(config('app.seed_pwd')),
        ]);
        
        User::firstOrCreate([
            'name' => 'Hoang Anh',
            'email' => 'hoanganh@email.com',
            'password' => Hash::make(config('app.seed_pwd')),
        ]);

        User::firstOrCreate([
            'name' => 'Phuoc Anh',
            'email' => 'phuocanh@email.com',
            'password' => Hash::make(config('app.seed_pwd')),
        ]);

        User::firstOrCreate([
            'name' => 'Son Pham',
            'email' => 'sonpham@email.com',
            'password' => Hash::make(config('app.seed_pwd')),
        ]);
    }
}
