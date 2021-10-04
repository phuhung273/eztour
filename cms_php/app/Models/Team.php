<?php

namespace App\Models;

use App\Helpers\TimeHelper;
use Laravel\Jetstream\Events\TeamCreated;
use Laravel\Jetstream\Events\TeamDeleted;
use Laravel\Jetstream\Events\TeamUpdated;
use Laravel\Jetstream\Team as JetstreamTeam;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Uuid;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;

class Team extends JetstreamTeam
{
    use Uuid;
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'personal_team' => 'boolean',
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'name',
        'personal_team',
        'start_date',
        'image',
    ];

    /**
     * The event map for the model.
     *
     * @var array
     */
    protected $dispatchesEvents = [
        'created' => TeamCreated::class,
        'updated' => TeamUpdated::class,
        'deleted' => TeamDeleted::class,
    ];

    /**
     * The "type" of the auto-incrementing ID.
     *
     * @var string
     */
    protected $keyType = 'string';

    /**
     * Indicates if the IDs are auto-incrementing.
     *
     * @var bool
     */
    public $incrementing = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [];

    public function locations(){
        return $this->hasMany(Location::class);
    }

    public function todos(){
        return $this->hasMany(Todo::class);
    }

    public function announcements(){
        return $this->hasMany(Announcement::class);
    }

    public function discoveries(){
        return $this->belongsToMany(Discovery::class);
    }

    public function admins(){
        return $this->belongsToMany(User::class)
                    ->wherePivot('role', 'admin');
    }

    public function normalUsers(){
        return $this->belongsToMany(User::class)
                    ->wherePivotNull('role');
    }

    public function addAdmin(User $user){
        $this->users()->attach($user, ['role' => 'admin']);
    }

    public function addNormalUser(User $user){
        $this->users()->attach($user);
        $user->switchTeam($this);
    }
    
    public function overallLocations(){
        DB::statement("SET SQL_MODE=''");
        return $this->locations()
                    ->orderBy('day')
                    ->groupBy('day')
                    ->select('name', 'image', 'day')
                    ->oldest('from');
    }

    public function isTimeInvalid($from, $to, int $day, $excludeId=null){
        $existingTimes = null;

        if (isset($excludeId)) {
            $existingTimes = $this->locations()
                    ->where('day', $day)
                    ->where('id', '!=', $excludeId)
                    ->select('from', 'to')
                    ->get();
        } else {
            $existingTimes = $this->locations()
                        ->where('day', $day)
                        ->select('from', 'to')
                        ->get();
        }

        if (!isset($existingTime) || $existingTimes->isEmpty()) {
            if ($from >= $to) {
                return true;
            }
        }
        
        foreach ($existingTimes as $existingTime){
            if (!TimeHelper::isNotConflictWithHisRange($from, $to, $existingTime->from, $existingTime->to)) {
                return true;
            }
        }

        return false;
    }
}
