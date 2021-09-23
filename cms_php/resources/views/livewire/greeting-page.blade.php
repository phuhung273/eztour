<div>
    <x-loading-indicator />

    <div class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form wire:submit.prevent="submit">
                    <x-forms.form-group label="Message">

                        <x-forms.input-text wire:model.defer="content" />

                        @error('content')
                        <x-forms.error-text :error="$message" />
                        @enderror

                    </x-forms.form-group>

                    <x-forms.form-group label="Alarm time">

                        <x-forms.time-picker wire:model.defer="alarm_time" />

                        @error('alarm_time')
                        <x-forms.error-text :error="$message" />
                        @enderror

                    </x-forms.form-group>

                    <x-app-button text="Submit" purpose="submit" />
                </form>
            </div>
        </div>
        <!-- ... -->
        <div class="col-span-2">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <x-greeting-table :data="$data" />
            </div>
        </div>
    </div>
</div>