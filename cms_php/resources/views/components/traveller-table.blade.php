@props(['data'])

@php
$heads = ['Full Name'];
@endphp

@extends('components.datatable',[
'data' => $data,
'heads' => $heads,
])

@section('modalUpdate')
<form id="formUpdate">

    <x-forms.input-text id="updateNormalUserName" label="Full Name" />

</form>
@endsection