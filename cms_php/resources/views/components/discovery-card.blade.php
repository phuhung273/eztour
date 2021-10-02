<div class="lg:py-4">
    <div class="bg-gray-100 grid md:grid-cols-3 rounded-lg">
        <div class="md:col-span-1">
            <div class="h-full bg-center bg-cover rounded-lg"
                style="background-image:url('{{ asset('storage/img/discoveries/' . $discovery->image) }}')">
            </div>
        </div>
        <div class="md:col-span-2 py-6 px-6">
            <div>
                <h3 class="text-xl text-blue-600 font-bold inline">
                    {{ $discovery->title }}
                </h3>
            </div>
            <p class="mt-4 text-gray-600"><b>Place: </b>{{ $discovery->place }} </p>
            <p class="mt-4 text-gray-600"><b>Address: </b>{{ $discovery->address }} </p>
            @if ($discovery->about != null)
            <p class="mt-4 text-gray-600"><b>About: </b>{{ $discovery->about }} </p>
            @endif
            <div class="mt-8">
                <a href="{{ route('discoveries.edit', $discovery) }}">
                    <x-app-button scheme="success" text="Update" />
                </a>
                <x-app-button scheme="danger" text="Delete" onclick="modalDelete('{{ $discovery->id }}')" />
            </div>
        </div>
    </div>

    <form id="{{ $discovery->id }}" action="{{ route('discoveries.destroy', $discovery) }}" class="hidden" method="POST">
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