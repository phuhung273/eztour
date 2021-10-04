<x-base-mvc-team-page title="Discovery" :viewingTeam="$viewingTeam">

    <div class="flex mb-4">

        <div class="flex-1">
        </div>

        <a href="{{ route('discoveries.create') }}">
            <x-main-action-button text="Add an interesting place">
                <x-slot name="icon">
                    <svg class="w-4 h-4 mr-2 -ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                </x-slot>
            </x-main-action-button>
        </a>

    </div>

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
        <div class="container">
            @foreach ($discoveries as $discovery)
                <div class="flex">
                    <div class="relative">
                        {{-- Straight line --}}
                        <div class="h-full w-6 flex items-center justify-center">
                            <div class="h-full w-1 bg-teal-800 pointer-events-none"></div>
                        </div>
                        <div class="w-6 h-6 absolute top-1/2 -mt-3 rounded-full bg-blue-500 shadow"></div>
                    </div>
                        <div class="flex-grow pl-4">
                            <x-discovery-card :discovery="$discovery" />
                        </div>
                </div>
            @endforeach
        </div>
    </div>

</x-base-mvc-team-page>
