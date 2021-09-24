<div>
    <x-loading-indicator />

    <div class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="addTraveller">

                    <x-forms.input-text wire:model.defer="travellerName" label="Full Name" />

                    <x-app-button text="Add traveller" purpose="submit" />
                </form>
            </div>

            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="addTourGuide">

                    <x-forms.searchable-dropdown wire:model.defer="tourGuideId" label="Full Name"
                        :options="$tourGuideOptions" />

                    <x-app-button text="Add tour guide" purpose="submit" />
                </form>
            </div>
        </div>
        <!-- ... -->
        <div class="col-span-2">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <div class="flex flex-col justify-items-center px-4 py-3 ">
                    <h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">

                        @if ($tourGuideList && $tourGuideList->isNotEmpty())

                        Tour Guide:
                        {{ implode(', ', $tourGuideList->pluck('name')->all()) }}

                        @else
                        Please assign tour guide for this tour.
                        @endif
                    </h4>
                </div>

                <x-traveller-table :data="$travellers" />
            </div>
        </div>
    </div>
</div>