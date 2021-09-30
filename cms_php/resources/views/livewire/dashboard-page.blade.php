<div x-data="dashboard()">
    <x-loading-indicator />

    <div class="grid grid-cols-1">

        <div class="col-span-1 flex items-start justify-between mb-4">

            <div class="flex-1">
            </div>

            <x-main-action-button text="Add new tour" @click="toggleForm()">
                <x-slot name="icon">
                    <svg class="w-4 h-4 mr-2 -ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                </x-slot>
            </x-main-action-button>

        </div>

        <div class="col-span-1" x-show="showForm">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form id="formCreate" onsubmit="event.preventDefault()">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                        <div class="col-span-1">

                            <x-forms.image-upload id="image" label="Image" />

                        </div>

                        <div class="col-span-2">

                            <x-forms.input-text id="name" label="Tour name" />

                            <x-forms.date-picker-livewire id="date" label="Start date" />

                            <div class="text-center">
                                <x-app-button text="Save" @click="submitCreate()" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-span-1 px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
            <x-dashboard.team-table :data="$data" />
        </div>
    </div>

</div>

@push('scripts')
<script>
    const image = document.getElementById('image');
    const name = document.getElementById('name');
    const date = document.getElementById('date');
    const formCreate = document.getElementById('formCreate');

    function dashboard(){
        return {
            showForm: false,
            modalUpdate(id){
                this.id = id;
                const row = this.data.find(e => e.id == id);
                name.value = row.name;
                date.value = row.date;
                this.openModal();
            },
            submitCreate(){
                const self = this;
                // Upload a file:
                const data = {
                    name: name.value,
                    date: date.value,
                }
                @this.upload('image', image.files[0], (uploadedFilename) => {
                    @this.create(data).then(function(response){
                        if (response != null) {
                            name.value = '';
                            self.showForm = false;
                        }
                    })
                }, () => {
                    // Error callback.
                }, (event) => {
                    // Progress callback.
                    // event.detail.progress contains a number between 1 and 100 as the upload progresses.
                })

            },
            toggleForm: function(){
                this.showForm = !this.showForm;
            },
        }
    }
</script>
@endpush