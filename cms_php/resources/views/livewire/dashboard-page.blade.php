<div x-data="dashboard()">
    <x-loading-indicator />

    <div class="grid grid-cols-1">

        <div class="col-span-1 flex items-start justify-between mb-4">

            <div class="flex-1">
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

        <div class="col-span-1" x-show="showForm">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
                <form wire:submit.prevent="submit">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                        <div class="col-span-1">

                            <x-forms.image-upload wire:model.defer="image" label="Image" />

                        </div>

                        <div class="col-span-2">

                            <x-forms.input-text wire:model.defer="name" label="Tour name" />

                            <x-forms.date-picker wire:model.defer="date" label="Start date" />

                            <div class="text-center">
                                <x-app-button text="Save" @click="submit()" />
                                <x-app-button x-ref="btnSubmit" purpose="submit" class="hidden" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-span-1 px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
            <x-tour-table :data="$data" />
        </div>
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