@props(['text'])

<div {{ $attributes }}>
    <button
        class="flex items-center justify-between px-5 py-3 font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
        {{ $icon ?? ''}}
        <span>{{ $text }}</span>
    </button>
</div>