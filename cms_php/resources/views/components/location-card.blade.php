<div class="lg:py-4">
    <div class="bg-gray-100 grid md:grid-cols-3 rounded-lg">
        <div class="md:col-span-1">
            <div class="h-full bg-center bg-cover rounded-lg"
                style="background-image:url('{{ asset('storage/img/locations/' . $location->image) }}')">
            </div>
        </div>
        <div class="md:col-span-2 py-6 px-6">
            <div>
                <h3 class="text-xl text-blue-600 font-bold inline">
                    {{ $location->name }}
                </h3>
                -
                <span class="text-gray-800">
                    {{ TimeHelper::his2gia($location->from) }}
                    :
                    {{ TimeHelper::his2gia($location->to) }}</span></span>
            </div>
            <p class="mt-4 text-gray-600">{{ $location->description }} </p>
            <div class="mt-8">
                <a href="{{ route('locations.edit', $location) }}">
                    <x-app-button scheme="success" text="Update" />
                </a>    
                <x-app-button scheme="danger" text="Delete" onclick="modalDelete('{{ $location->id }}')" />
            </div>
        </div>
    </div>

    <form id="{{ $location->id }}" action="{{ route('locations.destroy', $location) }}" class="hidden" method="POST">
        @csrf
        @method('DELETE')
    </form>
</div>

@once
@push('scripts')
<script>
    function modalDelete(id){
            Swal.fire({
                title: 'Are you sure?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#e74c3c',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.getElementById(id);
                    form.submit();
                }
            });
        }
</script>
@endpush
@endonce