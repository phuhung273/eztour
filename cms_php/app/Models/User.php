<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Foundation\Auth\User as Authenticatable;
use GoldSpecDigital\LaravelEloquentUUID\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Fortify\TwoFactorAuthenticatable;
use Laravel\Jetstream\HasProfilePhoto;
use Laravel\Jetstream\HasTeams;
use Laravel\Sanctum\HasApiTokens;

use App\Helpers\StringHelper;
use Exception;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Collection as SupportCollection;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class User extends Authenticatable
{
    use HasApiTokens;
    use HasFactory;
    use HasProfilePhoto;
    use HasTeams;
    use Notifiable;
    use TwoFactorAuthenticatable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'is_tourguide'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'two_factor_recovery_codes',
        'two_factor_secret',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'is_admin' => 'boolean',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'profile_photo_url',
    ];

    public static function admins() {
        return (new static)::where('is_admin', true);
    }

    public static function tourguides() {
        return (new static)::where('is_tourguide', true);
    }

    public static function findByName(string $name) {
        return (new static)::where('name', $name)->firstOrFail();
    }

    public static function createNormalUser(string $name) {
        $programmingStr = StringHelper::vietnameseToProgrammingString($name);
        $email =  $programmingStr . '@email.com';
        $password = $programmingStr . '13579';
        
        return (new static)::create([
            'name' => $name,
            'email' => $email,
            'password' => Hash::make($password),
            'is_tourguide' => false,
        ]);
    }

    public static function createTourGuide($data) {
        return (new static)::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'is_tourguide' => true,
        ]);
    }

    public static function bulkCreateNormalUser(SupportCollection $names):Collection {
        $data = $names->map(function($row) {
            $name = $row->first();
            $programmingStr = StringHelper::vietnameseToProgrammingString($name);
            $email =  $programmingStr . '@email.com';
            $password = $programmingStr . '13579';
            $now = now();
            
            return [
                'id' => Str::uuid(),
                'name' => $name,
                'email' => $email,
                'password' => Hash::make($password),
                'is_admin' => false,
                'created_at' => $now,
                'updated_at' => $now,
            ];
        })->all();

        User::insert($data);

        return User::hydrate($data);
    }

    public function isTeamMember(Team $team):bool {
        return $this->belongsToMany(Team::class)
                    ->wherePivot('team_id', $team->id)
                    ->exists();
    }

    public function isTeamAdmin(Team $team):bool {
        return $this->belongsToMany(Team::class)
                    ->wherePivot('team_id', $team->id)
                    ->wherePivot('role', 'admin')
                    ->exists();
    }

    public function activeTeam(){
        try {
            return $this->currentTeam;
        } catch (Exception $e) {
            // User is not going on any tour
            return null;
        }
    }

    public function qrEncryptedCode() {
        return Crypt::encrypt([
            'email' => $this->email,
            'name' => $this->name,
        ]);
    }
}
