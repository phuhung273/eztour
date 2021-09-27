@props([
'data',
'options' => [],
])

@php

$heads = ['Message', 'Category'];
$tableData = $data->map(fn($row) => [
'id' => $row->id,
'message' => $row->message,
'category' => $row->announcementCategory->name,
])

@endphp

@extends('components.datatable',[
'data' => $tableData,
'heads' => $heads,
])

@section('modalUpdate')
<form id="formUpdate">

    <x-forms.input-text id="updateContent" label="Message" />

    <x-forms.select id="updateCategory" label="Category" :options="$options" />

</form>
@endsection