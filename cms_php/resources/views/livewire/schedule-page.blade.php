<div class="h-64 grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
    <div class="col-span-1">
        <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

            <form wire:submit.prevent="submit" enctype="multipart/form-data">
                <x-forms.form-group label="Location">

                    <x-forms.image-upload wire:model.defer="image" />
                    @error('image')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group label="Location">

                    <x-forms.input-text wire:model.defer="label" />

                    @error('label')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group label="Description">

                    <x-forms.input-text wire:model.defer="description" />

                    @error('description')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group label="Day">

                    <x-forms.input-number wire:model.defer="day" />

                    @error('day')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group label="From (hour)">

                    <x-forms.time-picker wire:model.defer="from" />

                    @error('from')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.form-group label="To (hour)">

                    <x-forms.time-picker wire:model.defer="to" />

                    @error('to')
                    <x-forms.error-text :error="$message" />
                    @enderror

                </x-forms.form-group>

                <x-forms.btn-submit text="Submit" />
            </form>
        </div>
    </div>
    <!-- ... -->
    <div class="col-span-2">
        <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        </div>
    </div>
</div>