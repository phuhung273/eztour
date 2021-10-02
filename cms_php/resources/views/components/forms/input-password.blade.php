@props([
'label',
'id',
])

<x-forms.form-group label="{{ $label }}">

    <label class="block mt-4 text-sm">
        <input id="{{ $id }}" name="{{ $id }}" {{ $attributes }}
            class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
            placeholder="********" type="password" />
    </label>

    <x-forms.error-text for="{{ $id }}" />

</x-forms.form-group>