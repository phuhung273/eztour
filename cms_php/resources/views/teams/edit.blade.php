<x-base-mvc-page title="Tour {{ $team->name }}">

    <div class="w-full md:w-1/2 mx-auto">

        <form action="{{ route('teams.update', $team) }}" method="POST" enctype="multipart/form-data">

            @csrf
            @method('PUT')

            <x-forms.image-upload id="image" label="Image" url="{{ asset('storage/img/locations/' . $team->image) }}" />

            <x-forms.input-text id="name" label="Tour name" value="{{ $team->name }}" />

            <x-forms.date-picker id="date" label="Start date" value="{{ $team->start_date }}" />

            <div class="text-center">
                <x-app-button text="Save" purpose="submit" class="w-full md:w-1/2" />
            </div>

        </form>

    </div>


</x-base-mvc-page>