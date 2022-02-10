<x-base-mvc-team-page title="Edit {{ $discovery->title }}" :viewingTeam="$viewingTeam">

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        <div class="w-full md:w-1/2 mx-auto">

            <form action="{{ route('discoveries.update', $discovery) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <x-forms.image-upload id="image" label="Image"
                    url="{{ asset('storage/img/discoveries/' . $discovery->image()->first()['src']) }}" />

                <x-forms.input-text id="title" label="Title" placeholder="At least 4 characters"
                    value="{{ $discovery->title }}" />

                <x-forms.input-text id="place" label="Place" placeholder="At least 4 characters"
                    value="{{ $discovery->place }}" />

                <x-forms.input-text id="address" label="Address" placeholder="At least 4 characters"
                    value="{{ $discovery->address }}" />

                <x-forms.textarea id="about" label="About" value="{{ $discovery->about }}" />

                <div class="text-center">
                    <x-app-button text="Save" purpose="submit" class="w-full md:w-1/2" />
                </div>

            </form>

        </div>
    </div>
</x-base-mvc-team-page>
