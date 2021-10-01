@php
function parseQr($code){

return '
<img src="data:image/png;base64, ' . 
base64_encode(QrCode::format('png')->size(300)->margin(3)->generate($code)) 
.'">
';
}

$data = array_map(fn($row) => [
'id' => $row['id'],
'name' => $row['name'],
'code' => isset($row['code']) ? parseQr($row['code']) : '',
], $data);

$heads = ['Full Name', 'QR Code'];
@endphp

@extends('components.datatable',[
'data' => $data,
'heads' => $heads,
'showActions' => false,
])

@section('body')

@foreach ($data as $item)
<tr class="text-gray-700 dark:text-gray-400">
    @foreach ($item as $key => $value)

    @if (substr($key, -2) != 'id' && $key != 'update_url')

    <td class="px-4 py-3">
        {!! $value !!}
    </td>

    @endif

    @endforeach
</tr>
@endforeach

@endsection