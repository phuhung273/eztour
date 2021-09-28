<x-base-mvc-team-page title="Edit {{ $location->name }}" :viewingTeam="$viewingTeam">

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        <div class="w-full md:w-1/2 mx-auto">

            <form action="{{ route('locations.update', $location) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <x-forms.image-upload id="image" label="Image"
                    url="{{ asset('storage/img/locations/' . $location->image) }}" />

                <x-forms.input-text id="name" label="Label" value="{{ $location->name }}" />

                <x-forms.textarea id="description" label="Description" value="{{ $location->description }}" />

                <x-forms.input-number id="day" label="Day" value="{{ $location->day }}" />

                <x-forms.time-picker id="from" label="From (hour)" />

                <x-forms.time-picker id="to" label="To (hour)" />

                <div class="text-center">
                    <x-app-button text="Save" purpose="submit" class="w-full md:w-1/2" />
                </div>

            </form>

        </div>
    </div>

    <script>
        (function() {
            document.getElementById('from').value = '{{ TimeHelper::his2gia($location->from) }}';
            document.getElementById('to').value = '{{ TimeHelper::his2gia($location->to) }}';
        })();
    </script>
</x-base-mvc-team-page>