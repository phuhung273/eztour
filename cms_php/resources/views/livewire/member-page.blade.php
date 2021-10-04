<x-base-team-page :viewingTeam="$viewingTeam">

    <div x-data="memberPage()" class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <div>
                    <form id="formCreate">

                        <x-forms.input-text id="normalUserName" label="Full Name" />

                    </form>
                    <x-app-button text="Add traveller" @click="submitCreateNormalUser" />
                </div>
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

</x-base-team-page>

@push('scripts')
<script>
    const normalUserName = document.getElementById('normalUserName');
    const updateNormalUserName = document.getElementById('updateNormalUserName');
    const formCreate = document.getElementById('formCreate');
    const formUpdate = document.getElementById('formUpdate');

    function memberPage(){
        return {
            data: @json($normalUsers),
            id: null,
            modalUpdate(id){
                this.id = id;
                const row = this.data.find(e => e.id == id);
                updateNormalUserName.value = row.name;
                this.openModal();
            },
            submitCreateNormalUser(){
                const self = this;
                const data = Object.fromEntries(new FormData(formCreate).entries())
                @this.addNormalUser(data).then(function(response){
                    if (response != null) {
                        normalUserName.value = '';
                        self.data.push(response.data);
                    }
                })
            },
            submitUpdate(){
                const self = this;
                const data = Object.fromEntries(new FormData(formUpdate).entries());
                const index = this.data.findIndex(e => e.id == this.id);
                @this.update(this.id, data).then(function(response) {
                    if (response != null) {
                        self.data[index] = response.data;
                        self.closeModal();
                    }
                })
            },
            // Modal
            isModalOpen: false,
            // trapCleanup: null,
            openModal() {
                this.isModalOpen = true;
                // this.trapCleanup = focusTrap(document.querySelector('#modal'));
            },
            closeModal() {
                this.isModalOpen = false;
                // this.trapCleanup();
            },
        }
    }
</script>
@endpush