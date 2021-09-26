<x-base-tour-page :viewingTeam="$viewingTeam">

    <div class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="addNormalUser">

                    <x-forms.input-text wire:model.defer="normalUserName" label="Full Name" />

                    <x-app-button text="Add traveller" purpose="submit" />
                </form>

                <form wire:submit.prevent="importExcel">

                    <x-forms.file-upload wire:model.defer="file" label="Excel file" instruction="Select Excel file" />

                    <x-app-button text="Submit file" purpose="submit" scheme="success" />
                </form>
            </div>

            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="addAdmin">

                    <x-forms.searchable-dropdown wire:model.defer="adminId" label="Full Name"
                        :options="$adminOptions" />

                    <x-app-button text="Add tour guide" purpose="submit" scheme="secondary" />
                </form>
            </div>
        </div>
        <!-- ... -->
        <div class="col-span-2">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <div class="flex flex-col justify-items-center px-4 py-3 ">
                    <h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">

                        @if ($admins && $admins->isNotEmpty())

                        Tour Guide:
                        {{ implode(', ', $admins->pluck('name')->all()) }}

                        @else
                        Please assign tour guide for this tour.
                        @endif
                    </h4>
                </div>

                <x-traveller-table :data="$normalUsers" />
            </div>
        </div>
    </div>

</x-base-tour-page>