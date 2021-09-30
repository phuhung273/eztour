<x-base-team-page :viewingTeam="$viewingTeam">

    <div class="grid grid-cols-1">
        <div class="col-span-1 flex items-start justify-between mb-4">

            <form wire:submit.prevent="generate">
                <x-main-action-button text="Generate QR Code">
                    <x-slot name="icon">
                        <svg class="w-6 h-6 mr-2 -ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 4v1m6 11h2m-6 0h-2v4m0-11v3m0 0h.01M12 12h4.01M16 20h4M4 12h4m12 0h.01M5 8h2a1 1 0 001-1V5a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1zm12 0h2a1 1 0 001-1V5a1 1 0 00-1-1h-2a1 1 0 00-1 1v2a1 1 0 001 1zM5 20h2a1 1 0 001-1v-2a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1z" />
                        </svg>
                    </x-slot>
                </x-main-action-button>
            </form>

            <div class="flex-1">
            </div>

            <a href="{{ route('qrPdf', $viewingTeam) }}">
                <x-main-action-button text="Download PDF">
                    <x-slot name="icon">
                        <svg class="h-6 w-6 mr-2 -ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                        </svg>
                    </x-slot>
                </x-main-action-button>
            </a>

        </div>
    </div>

    <div class="col-span-1 px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
        <x-qr.qr-table :data="$data" />
    </div>

</x-base-team-page>