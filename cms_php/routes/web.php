<?php

use App\Http\Controllers\AnnouncementController;
use App\Http\Controllers\DiscoveryController;
use App\Http\Livewire\ChecklistPage;
use App\Http\Controllers\GreetingController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\QrPdfController;
use App\Http\Controllers\TeamController;
use App\Http\Controllers\TodoController;
use App\Http\Livewire\AnnouncementPage;
use App\Http\Livewire\DashboardPage;
use App\Http\Livewire\DiscoveryPage;
use App\Http\Livewire\GreetingPage;
use App\Http\Livewire\MemberPage;
use App\Http\Livewire\QrPage;
use App\Http\Livewire\RegisterPage;
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

    Route::get('/', DashboardPage::class)->name('dashboard');
    // Route::get('/schedule', SchedulePage::class)->name('schedule');
    Route::get('/checklist', ChecklistPage::class)->name('checklist');
    Route::get('/greeting', GreetingPage::class)->name('greeting');
    Route::get('/announcement', AnnouncementPage::class)->name('announcement');
    Route::get('/member', MemberPage::class)->name('member');
    Route::get('/qr', QrPage::class)->name('qr');
    Route::get('/qrPdf/{team}', [QrPdfController::class, 'index'])->name('qrPdf');
    Route::get('/register', RegisterPage::class)->name('register')->middleware(['auth', 'register']);
});

Route::resources([
    'locations' => LocationController::class,
    'discoveries' => DiscoveryController::class,
    'greetings' => GreetingController::class,
    'todos' => TodoController::class,
    'announcements' => AnnouncementController::class,
    'teams' => TeamController::class,
]);