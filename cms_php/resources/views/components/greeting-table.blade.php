@props(['data'])

@php
// $dataArray = json_decode(json_encode($data), true);
// $final = array_map(function($row){
// $row['alarm_time'] = TimeHelper::his2gia($row['alarm_time']);
// return $row;
// }, $dataArray);

$heads = ['Message', 'Alarm time'];
@endphp

<x-datatable :data="$data" :heads="$heads" />