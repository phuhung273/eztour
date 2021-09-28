@props(['title'])

<x-app-layout title="{{ $title }}">

    <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md">

        {{ $slot }}

    </div>

</x-app-layout>