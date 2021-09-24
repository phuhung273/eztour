@props(['label'])

<x-forms.form-group label="{{ $label }}">

    <select {{ $attributes }}
        class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray">
        <option value='6:00 AM' selected>6:00 AM</option>
        <option value='9:00 AM'>9:00 AM</option>
        <option value='12:00 PM'>12:00 PM</option>
        <option value='3:00 PM'>3:00 PM</option>
        <option value='6:00 PM'>6:00 PM</option>
        <option value='9:00 PM'>9:00 PM</option>
    </select>

    <x-forms.error-text for="{{ $attributes->wire('model')->value() }}" />

</x-forms.form-group>