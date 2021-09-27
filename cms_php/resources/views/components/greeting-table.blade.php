@props(['data'])

@php

$heads = ['Message', 'Alarm time'];
$tableData = $data->map(fn($row) => [
'id' => $row->id,
'message' => $row->message,
'alarm_time' => $row->alarm_time,
])
@endphp

@extends('components.datatable',[
'data' => $tableData,
'heads' => $heads,
])

@section('modalUpdate')
<form id="formUpdate">

    <x-forms.input-text id="updateContent" label="Message" />

    <x-forms.time-picker id="updateAlarmTime" label="Alarm time" />

</form>
@endsection