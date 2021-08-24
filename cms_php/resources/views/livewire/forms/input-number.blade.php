<div class="custom-number-input h-10 w-32">
    <div class="grid grid-cols-3 h-10 w-full rounded-lg relative bg-transparent mt-1">
        <div data-action="decrement"
            class="col-span-1 bg-gray-300 text-center text-2xl font-thin text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full rounded-l cursor-pointer outline-none">
            -
        </div>
        <input type="number" wire:model="value"
            class="col-span-1 outline-none focus:outline-none text-center w-full bg-gray-300 font-semibold text-md hover:text-black focus:text-black  md:text-basecursor-default flex items-center text-gray-700  outline-none"
            name="custom-input-number"></input>
        <div data-action="increment" x-on:click="$wire.increment()"
            class="col-span-1 bg-gray-300 text-center text-2xl font-thin text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full rounded-r cursor-pointer">
            +
        </div>
    </div>
</div>

@push('styles')

<style>
    input[type='number']::-webkit-inner-spin-button,
    input[type='number']::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    .custom-number-input input:focus {
        outline: none !important;
    }

    .custom-number-input button:focus {
        outline: none !important;
    }
</style>
@endpush