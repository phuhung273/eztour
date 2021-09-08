@props(['data'])

@php

$heads = ['Message'];
@endphp

<x-datatable :data="$data" :heads="$heads" />