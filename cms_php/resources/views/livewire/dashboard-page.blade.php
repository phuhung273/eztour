<div x-data="dashboard()">
    <x-loading-indicator />

    <div class="h-64 grid gap-y-4 gap-x-16">

        <div class="flex items-start justify-between">

            <div class="flex-1">
                @if ($defaultTeam)
                <div class="flex flex-col justify-items-center px-4 py-3 ">
                    <h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">
                        You're viewing
                    </h4>
                    {{ $defaultTeam->name }}
                </div>
                @endif
            </div>

            <x-main-action-button text="Add new tour" @click="toggleForm()">
                <x-slot name="icon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-2 -ml-1" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                </x-slot>
            </x-main-action-button>

        </div>

        <div x-show="showForm">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
                <h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">
                    Create your tour
                </h4>

                <form wire:submit.prevent="submit">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                        <div class="col-span-1">
                            <x-forms.form-group label="Image">

                                <x-forms.image-upload wire:model.defer="image" />
                                <x-forms.error-text for="image" />

                            </x-forms.form-group>
                        </div>

                        <div class="col-span-2">
                            <x-forms.form-group label="Tour name">

                                <x-forms.input-text wire:model.defer="name" />
                                <x-forms.error-text for="name" />

                            </x-forms.form-group>

                            <x-forms.form-group label="Start date">

                                <x-forms.date-picker wire:model.defer="date" />
                                <x-forms.error-text for="date" />

                            </x-forms.form-group>

                            <div class="text-center">
                                <x-app-button text="Save" @click="submit()" />
                                <x-app-button x-ref="btnSubmit" purpose="submit" class="hidden" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        @if ($defaultTeam)
        <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
            <x-tour-table :data="$data" />
        </div>
        @endif
    </div>
</div>

@push('scripts')
<script>
    function dashboard(){
        return {
            showForm: false,
            toggleForm: function(){
                this.showForm = !this.showForm
            },
            submit: function(){
                this.$refs.btnSubmit.click();
                this.showForm = false;
            }
        }
    }
</script>
@endpush