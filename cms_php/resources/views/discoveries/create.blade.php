<x-base-mvc-team-page title="Add an interesting place" :viewingTeam="$viewingTeam">

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        <div class="w-full md:w-1/2 mx-auto">

            <form action="{{ route('discoveries.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="w-full inline-flex">
                    @for($i = 0; $i<=3; $i++)
                        <x-forms.image-upload id="image[{{$i}}]" label="Image {{$i+1}}" url="{{ asset('img/placeholder-image.png') }}" />
                    @endfor
                </div>

                <x-forms.input-text id="title" label="Title" value="{{ old('title') }}" />

                <x-forms.input-text id="place" label="Place" value="{{ old('place') }}" />

                <x-forms.input-text id="address" label="Address" value="{{ old('address') }}" />

                <x-forms.textarea id="about" label="About" value="{{ old('about') }}" />

                <div class="text-center">
                    <x-app-button text="Save" purpose="submit" class="w-full md:w-1/2" />
                </div>

            </form>

        </div>
    </div>

</x-base-mvc-team-page>
