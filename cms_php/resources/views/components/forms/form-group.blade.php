@props(['label'])

<div class="font-semibold my-4">
    @isset($label)
    <div class="text-lg text-gray-600 mb-2">
        {{$label}}
    </div>
    @endisset

    {{$slot}}
</div>