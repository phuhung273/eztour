<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class MobileAuthController extends Controller
{
    public function basicLogin(Request $request){

        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'device_name' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();
    
        if (! $user || ! Hash::check($request->password, $user->password)) {
            return [
                'message' => 'Incorrect credential',
                'statusCode' => '422',
            ];
        }
    
        return $this->validateTeamAndResponse($user, $request->device_name);
    }

    public function credentialLogin(Request $request){

        $request->validate([
            'credential' => 'required',
            'device_name' => 'required',
        ]);

        try {
            $credential = Crypt::decrypt($request->credential);

            $user = User::where('email', $credential['email'])->first();
    
            if (! $user || $user->name != $credential['name']) {
                return [
                    'message' => 'Incorrect credential',
                    'statusCode' => '422',
                ];
            }
        
            return $this->validateTeamAndResponse($user, $request->device_name);
            
        } catch (DecryptException $e) {
            return [
                'message' => 'Your QR Code is broken',
                'statusCode' => '422',
            ];;
        }
    
    }

    private function validateTeamAndResponse($user, $deviceName){

        $team = $user->activeTeam();

        if ($team) {
            return [
                'access_token' => $user->createToken($deviceName)->plainTextToken,
                'credential' => $user->qrEncryptedCode(),
                'user_id' => $user->id,
                'user_name' => $user->email,
                'statusCode' => '200',
            ];
        } else {
            return [
                'message' => 'Credential is correct but no active tour, contact your tour guide for support.',
                'statusCode' => '423',
            ];
        }
    }
}
