@props(['data'])

@php

$heads = ['Message', 'Alarm time'];
@endphp

<x-datatable :data="$data" :heads="$heads" />