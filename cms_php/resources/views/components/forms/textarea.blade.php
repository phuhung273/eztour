@props([
'label',
'id',
])

<x-forms.form-group label="{{ $label }}">

    <textarea id="{{ $id }}" name="{{ $id }}" {{ $attributes }}
        class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-textarea focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray"
        rows="10"></textarea>

    <x-forms.error-text for="{{ $id }}" />

</x-forms.form-group>