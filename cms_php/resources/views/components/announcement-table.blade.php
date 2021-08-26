@props(['data'])

@php
$dataArray = json_decode(json_encode($data), true);

$heads = ['Message'];
@endphp

<x-datatable :data="$dataArray" :heads="$heads" />