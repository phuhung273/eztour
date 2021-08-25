@props(['location'])

<div class="lg:py-4">
    <div class="bg-gray-100 grid md:grid-cols-2 rounded-lg">
        <div class="md:col-span-1">
            <div class="h-64 bg-cover rounded-lg lg:h-full"
                style="background-image:url('{{ asset('storage/img/locations/' . $location->image) }}')">
            </div>
        </div>
        <div class="md:col-span-1 py-6 px-6 max-w-xl lg:max-w-5xl ">
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
                <a href="#">
                    <x-app-button scheme="success" text="Update" />
                </a>
                <x-app-button scheme="danger" text="Delete" />
            </div>
        </div>
    </div>
</div>