@props(['label'])

<label class="inline-flex items-center mt-6">
    <input {{ $attributes }} type="checkbox" class="form-checkbox h-5 w-5 text-green-600" checked><span
        class="ml-2 text-gray-700">{{$label}}</span>
</label>