@php
function parseQr($code){

return '
<img src="data:image/png;base64, ' . 
base64_encode(QrCode::format('png')->size(300)->generate($code)) 
.'">
';
}

$data = array_map(fn($row) => [
'name' => $row['name'],
'code' => isset($row['code']) ? parseQr($row['code']) : '',
], $data);

$heads = ['Full Name', 'QR Code'];
@endphp

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <style>
        .page_break {
            page-break-before: always;
        }
    </style>
</head>

<body>
    @foreach ($data as $item)
    <div class="">
        <table class="">
            <thead>
                <tr class="">
                    @foreach ($heads as $head)
                    <th class="">{{$head}}</th>
                    @endforeach
                </tr>
            </thead>
            <tbody class="">

                <tr class="">
                    <td class="">
                        {!! $item['name'] !!}
                    </td>
                    <td class="">
                        {!! $item['code'] !!}
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
    <div class="page_break"></div>
    @endforeach
</body>

</html>