<template>
    <div class="flex flex-wrap items-center justify-center gap-5bg-white w-full h-full">
        <div class="w-full max-w-[28rem]">

        </div>
        <div class="w-full max-w-[28rem]">
            <div class="flex flex-wrap gap-3 h-auto items-stretch justify-center">
                <div v-for="title in ['characters', 'weapons', 'echos']" class="flex justify-between flex-col h-32 w-32 bgcontainer">
                    <img :src="`/other/${title}.png`" class="object-cover h-[5.9rem]">
                    <p class="w-full text-container font-[400] text-xl text-center bg-highlight h-8 content-center textshadow capitalize">{{ title }}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    import * as vueRouter from "vue-router"

    const router = vueRouter.useRouter()

    function redirect(route) {
        router.push({
            path: route,
        })
    }


    const x = "max"

    const a = `hello this is ${x}`
</script>