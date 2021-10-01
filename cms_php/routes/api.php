<?php

use App\Http\Controllers\AnnouncementController;
use App\Http\Controllers\Auth\MobileAuthController;
use App\Http\Controllers\DiscoveryController;
use App\Http\Controllers\GreetingController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\MobileHomeController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\TodoController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->group(function(){
    Route::get('/user', fn(Request $request) => $request->user);

    Route::name('api.')->group(function() {

        Route::name('locations.')->group(function() {
            Route::prefix('locations')->group(function() {
                Route::get('/', [ScheduleController::class, 'index'])->name('index');
            });
        });

        Route::name('discoveries.')->group(function() {
            Route::prefix('discoveries')->group(function() {
                Route::get('/', [DiscoveryController::class, 'index'])->name('index');
            });
        });
    
        Route::name('greetings.')->group(function() {
            Route::prefix('greetings')->group(function() {
                Route::get('/', [GreetingController::class, 'index'])->name('index');
            });
        });
    
        Route::name('todos.')->group(function() {
            Route::prefix('todos')->group(function() {
                Route::get('/', [TodoController::class, 'index'])->name('index');
            });
        });
    
        Route::name('announcements.')->group(function() {
            Route::prefix('announcements')->group(function() {
                Route::get('/', [AnnouncementController::class, 'index'])->name('index');
            });
        });
    
        Route::name('home.')->group(function() {
            Route::prefix('home')->group(function() {
                Route::post('/', [MobileHomeController::class, 'index'])->name('index');
            });
        });
    });

});

Route::name('api.')->group(function() {

    Route::post('/login', [MobileAuthController::class, 'login'])->name('login');
});