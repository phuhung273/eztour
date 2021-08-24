@props(['label'])

<label class="block text-sm mt-4">
    @isset($label)
    <span class="text-gray-700">
        {{$label}}
    </span>
    @endisset

    {{$slot}}
</label>