<?php

namespace App\Http\Livewire;


class QrPage extends BaseTeamPage
{
    public $data;

    protected function init() {
        if ($this->viewingTeam) {
            $this->data = $this->viewingTeam->normalUsers()
                            ->get()
                            ->map(fn($user) => $this->parseWithoutCode($user))->all();
        }
    }

    private function parseWithoutCode($row) {
        return [
            'id' => $row->id,
            'name' => $row->name,
        ];
    }

    private function parseWithCode($row) {
        return [
            'id' => $row->id,
            'name' => $row->name,
            'code' => $row->qrEncryptedCode(),
        ];
    }

    public function generate(){
        $this->data = $this->viewingTeam->normalUsers()
                            ->get()
                            ->map(fn($user) => $this->parseWithCode($user))->all();
    }

    public function render()
    {
        return view('livewire.qr-page')->layout('layouts.app', ['title' => 'Qr Generator']);
    }
}
