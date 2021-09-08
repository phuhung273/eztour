@props(['data'])

@php

$heads = ['Message', 'Category'];
@endphp

<x-datatable :data="$data" :heads="$heads" />