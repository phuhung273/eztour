<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class MobileAuthController extends Controller
{
    public function login(Request $request){

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

        $team = $user->activeTeam();

        if ($team) {
            return [
                'data' => [
                    'access_token' => $user->createToken($request->device_name)->plainTextToken,
                    'tour_id' => $team->id,
                    'user_id' => $user->id,
                    'user_name' => $user->email,
                ]
            ];
        } else {
            return [
                'message' => 'Credential is correct but no active tour, contact your tour guide for support.'
            ];
        }
    
    }
}
