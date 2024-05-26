<template>
    <div class="flex flex-wrap justify-center gap-5 w-full h-full ">
        <div class="w-full max-w-[28rem]">
            <div class="bgcontainer p-3">
                <p class="text-2xl">Welcome to <span class="textgold">wuthering.app</span></p>
                <p class="text-md pt-2">
                    Currently includes Convene Counter, and general game information.
                    Please note everything is still in development and some features
                    may not work as expected.
                </p>
            </div>
        </div>
        <div class="w-full max-w-[28rem] flex flex-col gap-5">
            <div class="bgcontainer p-3 flex flex-col">
                <p class="text-md pt-2">
                    Import your Convene History to view your latest and previous pulls
                    for Character, Weapon, Standard, and Beginner banners.
                </p>
                <button @click="redirect('/convene')" class="bgbutton mt-5 p-1.5 w-max px-3 inlineimage"><img class="pr-2" src="/other/radiant_tide.webp" alt="radiant tide">Convene Counter ></button>
            </div>
            <div class="bgcontainer p-3 flex flex-col">
                <p class="text-md pt-2">
                    Calculate the amount of Convenes needed to reach your next pity. 
                    Includes advanced filters to refund coral and more.
                </p>
                <button class="bgbutton mt-5 p-1.5 w-max px-3 inlineimage"><img class="pr-2" src="/other/afterglow_coral.webp" alt="afterglow coral">Coming Soon ></button>
            </div>
            <div class="relative h-[8.8rem]">
                <div class="absolute w-full h-full flex items-center justify-center z-10">
                    <p>Coming Soon.</p>
                </div>
                <div class="absolute flex flex-wrap gap-3 h-auto items-stretch justify-center blur-sm brightness-[0.2]">
                    <div v-for="title in ['characters', 'weapons', 'echos']" class="flex justify-between flex-col h-[8.8rem] w-[8.8rem] bgcontainer">
                        <img :src="`/other/${title}.webp`" class="object-cover h-[6.7rem]" :alt="`${title}`">
                        <p class="w-full text-container font-[400] text-xl text-center bg-highlight h-8 content-center textshadow capitalize">{{ title }}</p>
                    </div>
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
</script>