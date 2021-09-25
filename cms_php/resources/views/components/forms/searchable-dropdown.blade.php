@props([
'label' => '',
'options' => []
])

@php
$programmingLabel = str_replace(' ', '', strtolower($label));
$realId = $programmingLabel . '-select2-real';
$fakeId = $programmingLabel . '-select2-fake';
@endphp

<x-forms.form-group label="{{ $label }}">

    <input {{ $attributes }} id="{{ $realId }}" type="hidden">

    <div>
        <select id="{{ $fakeId }}"
            class=" block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray">
            @foreach($options as $key => $value)
            <option value="{{ $value->id }}">{{ $value->name }}</option>
            @endforeach
        </select>
    </div>

    <x-forms.error-text for="{{ $attributes->wire('model')->value() }}" />

</x-forms.form-group>

@push('styles')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

@endpush

@push('scripts')
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $(document).ready(function() {
        let realInput = document.getElementById('<?php echo $realId ?>')

        $('#<?php echo $fakeId ?>').select2().on('change', function (e) {
            var id = $(this).select2('data')[0]['id'];
            realInput.value = id;
            realInput.dispatchEvent(new Event('input'));
        });
    });
</script>
@endpush