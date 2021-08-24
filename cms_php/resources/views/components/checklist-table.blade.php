@props(['data'])

@php
$dataArray = json_decode(json_encode($data), true);
$final = array_map(function($row){
$row['done'] = $row['done'] ? '
<span
    class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">
    Done
</span>
'
: '';
return $row;
}, $dataArray);

$heads = ['Message', 'Done'];
@endphp

<x-datatable :data="$final" :heads="$heads" />