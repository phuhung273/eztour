@props(['data'])


@php
function parseTeam($image, $name){
$url = asset("storage/img/locations/{$image}");

return "
<div class='flex items-center text-sm'>
    <div class='w-40 mr-3 rounded-lg md:block'>
        <img src='{$url}' />
    </div>
    <div class='w-60'>
        <p class='font-semibold whitespace-normal'>{$name}</p>
    </div>
</div>
";
}

function parseStatus($current, $viewing){
$status = '';
if ($viewing) {
$status = $status . '
<div class="my-3">
    <span
        class="px-2 py-1 font-semibold leading-tight text-purple-700 bg-purple-100 rounded-full dark:bg-purple-700 dark:text-purple-100">
        Reviewing
    </span>
</div>
';
}
if ($current) {
$status = $status . '
<div class="my-3">
    <span
        class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">
        Going
    </span>
</div>
';
}
return $status;
}

$data = array_map(fn($row) => [
'id' => $row['id'],
'team' => parseTeam($row['image'], $row['name']),
'status' => parseStatus($row['current'], $row['viewing']),
'start_date' => $row['start_date'],
], $data);

$heads = ['Tour', 'Status', 'Start Date'];
@endphp

@extends('components.datatable',[
'data' => $data,
'heads' => $heads,
])

@section('body')

@foreach ($data as $item)
<tr class="text-gray-700 dark:text-gray-400">
    @foreach ($item as $key => $value)
    @if ($key != 'id')
    <td class="px-4 py-3">
        {!! $value !!}
    </td>
    @endif
    @endforeach
    <td class="px-4 py-3">

        @php
        $id = $item['id'];
        @endphp

        <div class="flex items-center space-x-4 text-sm">

            <button wire:loading.attr="disabled" onclick="modalView('{{ $id }}')"
                class="flex items-center justify-between px-2 py-2 text-lg font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray disabled:opacity-50"
                aria-label="View">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                </svg>
            </button>

            <button wire:loading.attr="disabled" onclick="modalGo('{{ $id }}')"
                class="flex items-center justify-between px-2 py-2 text-lg font-medium leading-5 text-green-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray disabled:opacity-50"
                aria-label="Go">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path d="M9 17a2 2 0 11-4 0 2 2 0 014 0zM19 17a2 2 0 11-4 0 2 2 0 014 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
            </button>

            <button wire:loading.attr="disabled"
                class="flex items-center justify-between px-2 py-2 text-lg font-medium leading-5 text-blue-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray disabled:opacity-50"
                aria-label="Edit">
                <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                    <path
                        d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z">
                    </path>
                </svg>
            </button>

            <button wire:loading.attr="disabled" onclick="modalDelete('{{ $id }}')"
                class="flex items-center justify-between px-2 py-2 text-lg font-medium leading-5 text-orange-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray disabled:opacity-50"
                aria-label="Delete">
                <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
                        d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                        clip-rule="evenodd"></path>
                </svg>
            </button>
        </div>
    </td>
</tr>
@endforeach

@endsection

@push('scripts')
<script>
    function modalView(id){
        Swal.fire({
            title: 'Changing viewing tour',
            icon: 'question',
            text: 'You will only view, your app will not show this tour.',
            showCancelButton: true,
            confirmButtonText: 'Yes, I just want to review it'
        }).then((result) => {
            if (result.isConfirmed) {
                @this.changeViewingTeam(id);
            }
        });
    }

    function modalGo(id){
        Swal.fire({
            title: 'Changing default tour',
            icon: 'question',
            text: "If you're tour guide, your app will show this tour.",
            showCancelButton: true,
            confirmButtonText: "Yes, I'm going on it"
        }).then((result) => {
            if (result.isConfirmed) {
                @this.changeCurrentTeam(id);
            }
        });
    }
</script>
@endpush