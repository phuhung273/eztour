@props([
'scheme' => null,
'text',
'purpose' => null
])

@php
$modifier = 'bg-purple-600 hover:bg-purple-700';

switch ($scheme) {
case 'secondary':
$modifier = 'bg-purple-teal-600 hover:bg-teal-700';
break;

case 'success':
$modifier = 'bg-blue-600 hover:bg-blue-700';
break;

case 'danger':
$modifier = 'bg-orange-600 hover:bg-orange-700';
break;

default:
break;
}

@endphp

<button {{ $purpose == "submit" ? "type='submit'" : "" }}
    class="{{ $modifier }} px-5 py-3 mx-auto mt-4 font-semibold leading-5 text-white transition-colors duration-150 border border-transparent rounded-lg focus:outline-none focus:shadow-outline-purple">
    {{ $text }}
</button>