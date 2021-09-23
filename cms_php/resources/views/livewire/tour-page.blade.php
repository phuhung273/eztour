<div>
    <x-loading-indicator />

    <div class="">
        <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

            <form wire:submit.prevent="submit">

                <x-forms.form-group label="Start date">

                    <x-forms.date-picker wire:model.defer="date" />
                    <x-forms.error-text for="date" />

                </x-forms.form-group>

                <x-app-button text="Submit" purpose="submit" />
            </form>
        </div>
    </div>
</div>