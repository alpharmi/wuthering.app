<template>
    <div class="flex px-40 pt-20 h-full">
        <div class="flex flex-col gap-5 w-72 h-full">
            <button @click="banner = bannerName" v-for="bannerName in ['character', 'weapon', 'standard']" class="w-full flex justify-end">
                <img v-if="bannerName != banner" :src="`/banners/${bannerName}.png`" class="banner relative hover:scale-[1.15] hover:brightness-125 transition-all duration-100">
                <img v-if="bannerName == banner" :src="`/banners/${bannerName}_selected.png`">
            </button>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                banner: "character"
            }
        },
        methods: {
            
        }
    }
</script>