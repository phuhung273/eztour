<x-base-team-page :viewingTeam="$viewingTeam">

    <div class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="submit">

                <x-forms.image-upload wire:model.defer="image" label="Discovery" />

                    <x-forms.input-text wire:model.defer="title" label="Title" />

                    <x-forms.input-text wire:model.defer="place" label="Place" />

                    <x-forms.input-text wire:model.defer="address" label="Address" />

                    <x-forms.input-text wire:model.defer="about" label="About" />

                    <x-app-button text="Submit" purpose="submit" />
                </form>
            </div>
        </div>
        <!-- ... -->
        <div class="col-span-2">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
                <div class="container">
                    <div class="flex flex-col mx-auto p-2 text-blue-50">

                        <!-- @for ($i = 1; $i <= $max_day; $i++) <div class="flex">
                            <div class="relative">
                                {{-- Straight line --}}
                                <div class="h-full w-6 flex items-center justify-center">
                                    <div class="h-full w-1 bg-teal-800 pointer-events-none"></div>
                                </div>
                            </div>

                            <div class="flex-grow pl-4">
                                <div class="rounded-xl my-4 mr-auto">
                                    <x-timeline-tag text="Day {{ $i }}" />
                                </div>
                            </div>
                    </div> -->

                    @foreach ($data as $item)
                    <!-- @if ($item->day == $i) -->
                    <div class="flex">
                        <div class="relative">
                            {{-- Straight line --}}
                            <div class="h-full w-6 flex items-center justify-center">
                                <div class="h-full w-1 bg-teal-800 pointer-events-none"></div>
                            </div>
                            {{-- Circle --}}
                            <div class="w-6 h-6 absolute top-1/2 -mt-3 rounded-full bg-blue-500 shadow"></div>
                        </div>

                        <div class="flex-grow pl-4">
                            <x-discovery-card :discovery="$item" />
                        </div>
                    </div>
                    <!-- @endif -->
                    @endforeach
                    @endfor
                </div>
            </div>
        </div>
    </div>

</x-base-team-page>