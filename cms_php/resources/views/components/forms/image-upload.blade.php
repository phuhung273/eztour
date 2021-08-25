<div x-data="imageUploadData" class="col-span-6 ml-2 sm:col-span-4 md:mr-3">
    <!-- Photo File Input -->
    <input {{ $attributes }} type="file" x-ref="photo" class="hidden" x-on:change="changeImage">

    <div class="text-center">
        <!-- Current Photo -->
        <div class="mt-2" x-show="!photoPreview" wire:ignore>
            <div class="w-10/12 m-auto">
                <img class="object-cover" src="{{ asset('img/placeholder-image.png') }} " />
            </div>
        </div>
        <!-- New Photo Preview -->
        <div class="mt-2" x-show="photoPreview" wire:ignore>
            <span class="block w-10/12 h-40 m-auto shadow"
                x-bind:style="'background-size: cover; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + photoPreview + '\');'"
                style="background-size: cover; background-repeat: no-repeat; background-position: center center;">
            </span>
        </div>
        <button type="button"
            class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-md font-semibold text-xs text-gray-700 uppercase tracking-widest shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-400 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150 mt-2"
            x-on:click.prevent="$refs.photo.click()">
            Select New Photo
        </button>
    </div>
</div>

@push('scripts')
<script>
    document.addEventListener('alpine:init', () => {
        Alpine.data('imageUploadData', () => ({
            photoName: null,
            photoPreview: null,
            changeImage(e){
                this.photoName = e.target.files[0].name;
                const reader = new FileReader();
                reader.onload = (e) => {
                    this.photoPreview = e.target.result;
                };
                reader.readAsDataURL(e.target.files[0]);
            }
        }))
    })
</script>
@endpush