@props([
'data' => collect(),
])

@php

$heads = ['Tour Guide', 'Email'];
$tableData = $data->map(fn($row) => [
'id' => $row->id,
'name' => $row->name,
'email' => $row->email,
])
@endphp

@extends('components.datatable',[
'data' => $tableData,
'heads' => $heads,
])

@section('modalUpdate')
<form id="formUpdate">

    <x-forms.input-text id="updateName" label="Tour Guide" />

    <x-forms.input-text id="updateEmail" label="Email" />

</form>
@endsection