<div class="h-64 grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
    <div class="col-span-1">
        <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

            <form wire:submit.prevent="submit">
                <x-forms.form-group label="Message">

                    <x-forms.input-text wire:model="content" />

                    @error('content')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group>

                    <x-forms.checkbox wire:model="done" label="Done" />

                </x-forms.form-group>

                <x-forms.btn-submit text="Submit" />
            </form>
        </div>
    </div>
    <!-- ... -->
    <div class="col-span-2">
        <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

            <x-checklist-table :data="$todos" />
        </div>
    </div>
</div>