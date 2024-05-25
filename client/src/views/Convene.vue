<template>
    <div class="flex w-full justify-center items-center">
        <Note message="The following page is yet to be optimised for all screen sizes and devices.,The following page still has uncompleted features."/>
    </div>
    <div class="flex px-[8%] pt-10 h-full gap-10">
        <div class="flex flex-col gap-5 w-48 min-w-48 h-auto">
            <button @click="switchBanner(bannerName)" v-for="bannerName in ['character', 'weapon', 'standard', 'beginner']" class="w-full flex justify-end shadow-md">
                <img v-if="bannerName != banner" :src="`/banners/${bannerName}.png`" class="banner relative hover:scale-[1.05] hover:brightness-125 transition-all duration-100">
                <img v-if="bannerName == banner" :src="`/banners/${bannerName}_selected.png`">
            </button>
        </div>
        <div class="w-0.5 opacity-50 h-[45rem] from-transparent via-highlight via-50% to-transparent bg-gradient-to-b"></div>
        <div class="flex flex-col w-full">
            <h1 class="capitalize textgold text-xl">{{ banner }} Convene</h1>
            <div class="flex w-full gap-5 pt-3">
                <div class="w-[19rem] flex flex-col gap-4 h-[19rem]">
                    <div class="flex justify-between items-center bgcontainer h-22 p-3">
                        <div class="ml-1 w-full">
                            <p class="text-highlight text-xl">Lifetime Convenes</p>
                            <div class="flex w-full h-8 -ml-2 item-center">
                                <p class="inlineimage text-description"><img src="/other/astrite.png" class="h-full">{{ (lifetimePulls * 160).toLocaleString() }}</p>
                            </div>
                        </div>
                        <p class="w-24 h-auto text-right pr-2 text-4xl">{{ lifetimePulls }}</p>
                    </div>
                    <div class="flex justify-between items-center bgcontainer h-22 p-3">
                        <div class="ml-1 w-full">
                            <p class="text-highlight text-xl flex">5<img src="/other/star5.png" class="w-5 h-5 mt-1 mr-1"> Pity</p>
                            <div class="flex w-full h-8 -ml-2 item-center">
                                <p class="text-description pl-2 pt-1">Guaranteed at 80</p>
                            </div>
                        </div>
                        <p class="w-24 h-auto text-right pr-2 text-4xl text text-quality5">{{ pity.quality5 }}</p>
                    </div>
                    <div class="flex justify-between items-center bgcontainer h-22 p-3">
                        <div class="ml-1 w-full">
                            <p class="text-highlight text-xl flex">4<img src="/other/star5.png" class="w-5 h-5 mt-1 mr-1"> Pity</p>
                            <div class="flex w-full h-8 -ml-2 item-center">
                                <p class="text-description pl-2 pt-1">Guaranteed at 10</p>
                            </div>
                        </div>
                        <p class="w-24 h-auto text-right pr-2 text-4xl text text-quality4">{{ pity.quality4 }}</p>
                    </div>
                </div>
                <div class="w-[38rem] h-[38rem] flex flex-col gap-10 bgcontainer p-3 pt-9">
                    <div class="flex justify-center items-center w-full h-14 gap-3">
                        <button @click="switchBanner(banner, 5)" :class="{'bg-opacity-20': filters[5]},{'bg-opacity-0': !filters[5]}" class="w-14 h-14 border rounded-lg bg-[#ffd17c] border-quality5 inlineimage pl-2 text-xl">5<img :src="`/other/star5.png`" class="h-7 pr-2"></button>
                        <button @click="switchBanner(banner, 4)" :class="{'bg-opacity-20': filters[4]},{'bg-opacity-0': !filters[4]}" class="w-14 h-14 border rounded-lg bg-[#ffabfc] border-quality4 bg-opacity-20 inlineimage pl-2 text-xl">4<img :src="`/other/star4.png`" class="h-7 pr-2"></button>
                        <button @click="switchBanner(banner, 3)" :class="{'bg-opacity-20': filters[3]},{'bg-opacity-0': !filters[3]}" class="w-14 h-14 border rounded-lg bg-[#b9c6ff] border-quality3 bg-opacity-20 inlineimage pl-2 text-xl">3<img :src="`/other/star3.png`" class="h-7 pr-2"></button>
                    </div>
                    <table class="w-full">
                        <tr class="text-highlight text-left">
                            <th class="pl-8">Date</th>
                            <th>Pity</th>
                            <th class="pl-8">Name</th>
                        </tr>
                        <tr v-for="pull in pulls" :class="`pull-${pull.quality}`" class="border-t border-[#2c3038]">
                            <th class="w-[15rem] text-description">{{ pull.date }}</th>
                            <th :style="`color: hsl(${pityColour(pull)},100%,70%)`" class="w-[2rem]">{{ pull.pity || 1 }}</th>
                            <th class="pl-8 inlineimage"><img :src="`/${pull.type}/${pull.name.replaceAll(':', '_c').toLowerCase()}.webp`" class="h-10 mr-4 scale-[1.3]">{{ pull.name.replaceAll("_", " ") }}</th>
                        </tr>
                    </table>
                </div>
            </div>
        </div> 
    </div>
</template>

<script setup>
    import Note from "../Components/Note.vue"
</script>

<script>
    export default {
        data() {
            return {
                banner: "beginner",
                lifetimePulls: 0,
                pity: { quality5: 0, quality4: 0 },
                filters: { ["5"]: true, ["4"]: true, ["3"]: true },
                pulls: null
            }
        },
        methods: {
            pityColour(pull) {
                if (pull.quality == 5) {
                    return pull.pity
                } else if (pull.quality == 4) {
                    return 80 - (pull.pity * 8)
                }
            },
            switchBanner(bannerName, filter) {
                this.banner = bannerName

                const bannerData = JSON.parse(localStorage.getItem(`${bannerName}_banner`))

                if (filter) {
                    this.filters[filter] = !this.filters[filter]
                }

                if (bannerData) {
                    this.lifetimePulls = bannerData.data.length
                    this.pity.quality5 = bannerData.pity.quality5
                    this.pity.quality4 = bannerData.pity.quality4

                    this.pulls = bannerData.data.filter(pull => this.filters[pull.quality]).slice(0, 10)
                }
            }
        },
        mounted() {
            this.switchBanner(this.banner)
        }
    }
</script>