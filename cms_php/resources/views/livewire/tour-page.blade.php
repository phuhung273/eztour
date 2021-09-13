<div>
    <x-loading-indicator />

    <div class="h-64 gap-y-4 gap-x-16">
        <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

            <form wire:submit.prevent="submit">

                <x-forms.form-group label="Start date">

                    {{-- <x-forms.input-text wire:model.defer="date" /> --}}
                    <x-forms.date-picker wire:model.defer="date" />

                    @error('date')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-app-button text="Submit" purpose="submit" />
            </form>
        </div>
    </div>
</div>