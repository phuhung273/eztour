@props(['data'])

@php

$heads = ['Tour', 'Status', 'Start Date'];
@endphp

<x-datatable :data="$data" :heads="$heads" />