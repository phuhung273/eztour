<?php

use App\Http\Livewire\ChecklistPage;
use App\Http\Livewire\SchedulePage;
use App\Http\Controllers\GreetingController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\TodoController;
use App\Http\Livewire\AnnouncementPage;
use App\Http\Livewire\GreetingPage;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::group(['middleware' => ['auth:sanctum', 'verified']], function () {

    Route::view('/', 'dashboard')->name('dashboard');
    Route::get('/schedule', SchedulePage::class)->name('schedule');
    Route::get('/todo', ChecklistPage::class)->name('todo');
    Route::get('/greeting', GreetingPage::class)->name('greeting');
    Route::get('/announcement', AnnouncementPage::class)->name('announcement');
    
});

Route::resources([
    'locations' => LocationController::class,
    'greetings' => GreetingController::class,
    'todos' => TodoController::class,
    'announcements' => AnnouncementController::class,
]);