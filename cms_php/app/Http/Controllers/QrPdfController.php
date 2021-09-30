<?php

namespace App\Http\Controllers;

use App\Models\Team;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PDF;

class QrPdfController extends Controller
{
    public function index(Request $request, Team $team){
        $team = null;
        try {
            $team = Auth::user()->currentTeam;
        } catch (Exception $e) {
            return [
                'message' => "You're not tour guide or admin",
            ];
        }

        $data = $team->normalUsers()->get()->map(fn($user) => [
            'id' => $user->id,
            'name' => $user->name,
            'code' => $user->qrEncryptedCode(),
        ])->all();

        $pdf = PDF::loadView('components.qr.qr-pdf', compact('data'));

        return $pdf->download('traveller-qr.pdf');
        // return view('components.qr.qr-pdf', compact('data'));
    }
}
