<x-base-mvc-team-page title="Create a location" :viewingTeam="$viewingTeam">

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        <div class="w-full md:w-1/2 mx-auto">

            <form action="{{ route('locations.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <x-forms.image-upload id="image" label="Image" url="{{ asset('img/placeholder-image.png') }}" />

                <x-forms.input-text id="name" label="Label" />

                <x-forms.textarea id="description" label="Description" />

                <x-forms.input-number id="day" label="Day" />

                <x-forms.time-picker id="from" label="From (hour)" />

                <x-forms.time-picker id="to" label="To (hour)" />

                <div class="text-center">
                    <x-app-button text="Save" purpose="submit" class="w-full md:w-1/2" />
                </div>

            </form>

        </div>
    </div>

</x-base-mvc-team-page>