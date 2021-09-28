@props([
'label',
'id',
])

<x-forms.form-group label="{{ $label }}">

    <div class="relative text-gray-500 focus-within:text-purple-600">
        <input id="{{ $id }}" name="{{ $id }}" type="text" {{ $attributes }}
            class="block w-full mt-1 text-sm text-black focus:border-purple-400 focus:outline-none focus:shadow-outline-purple form-input" />
    </div>

    <x-forms.error-text for="{{ $id }}" />

</x-forms.form-group>