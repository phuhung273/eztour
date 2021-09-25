@props([
'label' => '',
'instruction' => 'Select a file'
])

<x-forms.form-group label="{{ $label }}">

    <div x-data="fileUpload()" class="w-full">
        <label
            class="w-full flex flex-col items-center px-4 py-6 bg-white rounded-lg shadow-lg border cursor-pointer hover:bg-black hover:text-white">
            <svg class="w-8 h-8" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path
                    d="M16.88 9.1A4 4 0 0 1 16 17H5a5 5 0 0 1-1-9.9V7a3 3 0 0 1 4.52-2.59A4.98 4.98 0 0 1 17 8c0 .38-.04.74-.12 1.1zM11 11h3l-4-4-4 4h3v3h2v-3z" />
            </svg>
            <span class="mt-2 text-base leading-normal" x-text="fileName"></span>
            <input {{ $attributes }} type="file" class="hidden" x-ref="file" x-on:change="changeFile" />
        </label>
    </div>

    <x-forms.error-text for="{{ $attributes->wire('model')->value() }}" />

</x-forms.form-group>

@push('scripts')
<script>
    function fileUpload(){
        return {
            fileName: '<?php echo $instruction ?>',
            changeFile(e){
                const reader = new FileReader();
                reader.onload = (e) => {
                    this.fileName = this.$refs.file.files[0].name
                };
                reader.readAsDataURL(e.target.files[0]);
            }
        }
    }
</script>
@endpush