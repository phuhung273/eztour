@props(['viewingTeam'])

<div>
    <x-loading-indicator />

    @if ($viewingTeam)

    {{ $slot }}

    @else

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        <div class="flex flex-col justify-items-center px-4 py-3 ">
            <h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">
                No tour selected. Navigate to Dashboard to choose tour.
            </h4>
        </div>

    </div>

    @endif

</div>