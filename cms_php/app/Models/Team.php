<?php

namespace App\Models;

use Laravel\Jetstream\Events\TeamCreated;
use Laravel\Jetstream\Events\TeamDeleted;
use Laravel\Jetstream\Events\TeamUpdated;
use Laravel\Jetstream\Team as JetstreamTeam;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Uuid;
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

    public function admins(){
        return $this->belongsToMany(User::class)
                    ->wherePivot('role', 'admin');
    }

    public function travellers(){
        return $this->belongsToMany(User::class)
                    ->wherePivotNull('role');
    }

    public function addAdmin(User $user){
        $this->users()->attach($user, ['role' => 'admin']);
    }
}
