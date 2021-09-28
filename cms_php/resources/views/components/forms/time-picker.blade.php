@props(['label', 'id'])

<x-forms.form-group label="{{ $label }}">

    <select {{ $attributes }} id="{{ $id }}" name="{{ $id }}" class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select
        focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray">
        <option value='6:00 am' selected>6:00 AM</option>
        <option value='9:00 am'>9:00 AM</option>
        <option value='12:00 pm'>12:00 PM</option>
        <option value='3:00 pm'>3:00 PM</option>
        <option value='6:00 pm'>6:00 PM</option>
        <option value='9:00 pm'>9:00 PM</option>
    </select>

    <x-forms.error-text for="{{ $id }}" />

</x-forms.form-group>