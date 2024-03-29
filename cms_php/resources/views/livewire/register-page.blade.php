<div x-data="registerPage()">
    <x-loading-indicator />

    <div class="grid grid-cols-1 md:grid-cols-3 gap-y-4 gap-x-16">
        <div class="col-span-1">
            <div class="flex flex-col justify-items-center px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

                <form id="formCreate">
                    <x-forms.input-text id="name" placeholder="username" label="Tour Guide" />

                    <x-forms.input-text id="email" placeholder="email" label="Email" />

                    <x-forms.input-password id="password" label="Password" />

                </form>
                <x-app-button text="Submit" @click="submitCreate" />
            </div>
        </div>
        <!-- ... -->
        <div class="col-span-2">
            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">
                <x-register-table :data="$data" />
            </div>
        </div>
    </div>
</div>

@push('scripts')
<script>
    const name = document.getElementById('name');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const updateName = document.getElementById('updateName');
    const updateEmail = document.getElementById('updateEmail');
    const formCreate = document.getElementById('formCreate');
    const formUpdate = document.getElementById('formUpdate');
    
    function registerPage() {
        return {
            data: @json($data),
            id: null,
            modalUpdate(id){
                this.id = id
                const row = this.data.find(e => e.id == id)
                updateName.value = row.name
                updateEmail.value = row.email
                this.openModal()
            },
            submitCreate(){
                const self = this;
                const data = Object.fromEntries(new FormData(formCreate).entries())
                @this.create(data).then(function(response){
                    if (response != null) {
                        name.value = ''
                        email.value = ''
                        password.value = ''
                        self.data.push(response.data)
                    }
                })
            },
            submitUpdate(){
                const self = this;
                const data = Object.fromEntries(new FormData(formUpdate).entries())
                const index = this.data.findIndex(e => e.id == this.id)
                @this.update(this.id, data).then(function(response) {
                    if (response != null) {
                        self.data[index] = response.data;
                        self.closeModal()
                    }
                })
            },
            // Modal
            isModalOpen: false,
            trapCleanup: null,
            openModal() {
                this.isModalOpen = true
                // this.trapCleanup = focusTrap(document.querySelector('#modal'))
            },
            closeModal() {
                this.isModalOpen = false
                // this.trapCleanup()
            },
        }
    }
</script>
@endpush