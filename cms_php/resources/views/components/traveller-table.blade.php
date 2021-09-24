@props(['data'])

@php
$heads = ['Full Name'];
@endphp

<x-datatable :data="$data" :heads="$heads" />