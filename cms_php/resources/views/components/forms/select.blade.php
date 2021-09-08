@props(['options'])

<select {{ $attributes }}
    class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray">
    @foreach ($options as $key => $value)
    @if ($key == 0)
    <option value="{{ $value->id }}" selected>{{ $value->name }}</option>
    @else
    <option value="{{ $value->id }}">{{ $value->name }}</option>
    @endif
    @endforeach
</select>