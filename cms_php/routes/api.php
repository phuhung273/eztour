<?php

use App\Http\Controllers\AnnouncementController;
use App\Http\Controllers\GreetingController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\MobileHomeController;
use App\Http\Controllers\TodoController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;

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

    Route::name('locations.')->group(function() {
        Route::prefix('locations')->group(function() {
            Route::get('/', [LocationController::class, 'index'])->name('index');
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

Route::post('/login', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    return [
        'access_token' => $user->createToken($request->device_name)->plainTextToken,
        'user_id' => $user->id,
        'user_name' => $user->email,
    ];
});