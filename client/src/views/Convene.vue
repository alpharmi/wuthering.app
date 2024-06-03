<template>
    <div class="flex w-full justify-center items-center">
        <Note message="The following page is yet to be optimised for all screen sizes and devices.,The following page still has uncompleted features."/>
    </div>
    <div class="flex px-[8%] pt-10 h-full gap-10">
        <div class="flex flex-col gap-5 w-48 min-w-48 h-auto">
            <button @click="amount = 10; switchBanner(bannerName)" v-for="bannerName in ['character', 'weapon', 'standard', 'beginner', 'choice', 'weapon_choice']" class="w-full flex justify-end shadow-md">
                <img v-if="bannerName != banner" :src="`/banners/${bannerName}.png`" class="banner relative hover:scale-[1.05] hover:brightness-125 transition-all duration-100">
                <img v-if="bannerName == banner" :src="`/banners/${bannerName}_selected.png`">
            </button>
        </div>
        <div class="w-0.5 opacity-50 h-[45rem] from-transparent via-highlight via-50% to-transparent bg-gradient-to-b"></div>
        <div class="flex flex-col w-full">
            <div :class="{'blur-sm brightness-[0.2]': pulls == null}" class="flex flex-col w-full">
                <h1 class="capitalize textgold text-xl">{{ banner.replaceAll("_", " ") }} Convene</h1>
                <div class="flex flex-wrap w-full gap-5 pt-3">
                    <div class="flex gap-5 convene-break:flex-row flex-col">
                        <div class="w-[19rem] flex flex-col gap-3 h-[19rem]">
                            <div class="flex justify-between items-center bgcontainer h-22 p-4">
                                <div class="ml-1 w-full">
                                    <p class="text-highlight text-xl">Lifetime Convenes</p>
                                    <div class="flex w-full h-8 -ml-2 item-center">
                                        <p class="inlineimage text-description"><img src="/other/astrite.png" class="h-full">{{ (lifetimePulls * 160).toLocaleString() }}</p>
                                    </div>
                                </div>
                                <p class="w-24 h-auto text-right pr-2 text-4xl">{{ lifetimePulls }}</p>
                            </div>
                            <div class="flex justify-between items-center bgcontainer h-22 p-4">
                                <div class="ml-1 w-full">
                                    <p class="text-highlight text-xl flex">5<img src="/other/star5.png" class="w-5 h-5 mt-1 mr-1"> Pity</p>
                                    <div class="flex w-full h-8 -ml-2 item-center">
                                        <p class="text-description pl-2 pt-1">Guaranteed at 80</p>
                                    </div>
                                </div>
                                <p class="w-24 h-auto text-right pr-2 text-4xl text text-quality5">{{ pity.quality5 }}</p>
                            </div>
                            <div class="flex justify-between items-center bgcontainer h-22 p-4">
                                <div class="ml-1 w-full">
                                    <p class="text-highlight text-xl flex">4<img src="/other/star5.png" class="w-5 h-5 mt-1 mr-1"> Pity</p>
                                    <div class="flex w-full h-8 -ml-2 item-center">
                                        <p class="text-description pl-2 pt-1">Guaranteed at 10</p>
                                    </div>
                                </div>
                                <p class="w-24 h-auto text-right pr-2 text-4xl text text-quality4">{{ pity.quality4 }}</p>
                            </div>
                        </div>
                        <div class="w-[19rem] h-[19rem]">
                            <div v-if="version == 1.2" class="bgcontainer w-full h-full p-5">
                                <div class="flex h-20 gap-5">
                                    <div class="h-[10rem] text-sm w-full">
                                        <p class="text-xl flex justify-between text-quality5">5 Star</p>
                                        <div>
                                            <p class="flex w-full justify-between">Average Pity: <span class="text-quality5">{{ pity.average5 }}</span></p>
                                            <p class="flex w-full justify-between">Win 50:50: <span class="text-quality5">{{ wins }}%</span></p>
                                        </div>
                                    </div>
                                    <div class="h-[10rem] text-sm w-full">
                                        <p class="text-xl flex justify-between text-quality4">4 Star</p>
                                        <div>
                                            <p class="flex w-full justify-between">Average Pity: <span class="text-quality4">{{ pity.average4 }}</span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="flex flex-wrap content-start gap-3 h-full">
                                    <div v-if="pulls" v-for="pull in pulls.filter(pull => pull.quality == 5)" class="w-max h-5 flex">
                                        <div class="h-5 flex items-center bg-highlight gap-1 px-1 rounded-md">
                                            <p class="text-container textshadow">{{ pull.pity }}</p>
                                            <p class="text-[#282c33] textshadow text-center">{{ pull.name.replaceAll("_", " ") }}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="w-[39rem] h-min flex flex-col bgcontainer p-3 pt-9">
                        <div class="flex justify-center items-center w-full h-14 gap-3">
                            <button @click="switchBanner(banner, 5)" :class="{'bg-opacity-20': filters[5]},{'bg-opacity-0': !filters[5]}" class="w-14 h-14 border rounded-lg bg-[#ffd17c] border-quality5 inlineimage pl-2 text-xl">5<img :src="`/other/star5.png`" class="h-7 pr-2"></button>
                            <button @click="switchBanner(banner, 4)" :class="{'bg-opacity-20': filters[4]},{'bg-opacity-0': !filters[4]}" class="w-14 h-14 border rounded-lg bg-[#ffabfc] border-quality4 inlineimage pl-2 text-xl">4<img :src="`/other/star4.png`" class="h-7 pr-2"></button>
                            <button @click="switchBanner(banner, 3)" :class="{'bg-opacity-20': filters[3]},{'bg-opacity-0': !filters[3]}" class="w-14 h-14 border rounded-lg bg-[#b9c6ff] border-quality3 inlineimage pl-2 text-xl">3<img :src="`/other/star3.png`" class="h-7 pr-2"></button>
                        </div>
                        <table class="w-full mt-10">
                            <tr class="text-highlight text-left">
                                <th class="pl-8">Date</th>
                                <th>Pity</th>
                                <th class="pl-8">Name</th>
                            </tr>
                            <tr v-if="pulls" v-for="pull in pulls.filter(pull => filters[pull.quality]).slice(0, amount)" :class="`pull-${pull.quality}`" class="border-t border-[#2c3038]">
                                <th class="w-[15rem] text-description">{{ pull.date }}</th>
                                <th :style="`color: hsl(${pityColour(pull)},100%,70%)`" class="w-[2rem]">{{ pull.pity || 1 }}</th>
                                <th class="pl-8 inlineimage"><img :src="`/${pull.type}/${pull.name.replaceAll(':', '_c').toLowerCase()}.webp`" class="h-10 mr-4 scale-[1.3]">{{ pull.name.replaceAll("_", " ") }}</th>
                                <th v-if="version >= 1.1 && pull.quality == 5" class="tooltip"><img :src="`/other/${pull.win.toLowerCase()}.webp`" class="w-4"><p class="absolute opacity-0 translate-x-5 -translate-y-7 bg-container p-2 rounded-md">{{ pull.win }}<span v-if="pull.win != 'Guaranteed'"> 50:50</span></p></th>
                            </tr>
                        </table>
                        <button @click="amount = 100; switchBanner(banner)" class="mt-2 textshadow">˅</button>
                    </div>
                </div>
                <button @click="redirect('/convene/import')" class="bgbutton p-2 px-10 self-center mt-5">Import Convene History</button>
            </div>
            <div v-if="!pulls" class="absolute flex flex-col left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 items-center justify-center gap-2">
                <p class="text-xl">You currently have no Convene History.</p>
                <button @click="redirect('/convene/import')" class="bgbutton p-2 px-10">Import Convene History</button>
            </div>
        </div> 
    </div>
</template>

<script setup>
    import Note from "../components/Note.vue"

    import * as vueRouter from "vue-router"

    const router = vueRouter.useRouter()

    function redirect(route) {
        router.push({
            path: route,
        })
    }
</script>

<script>
    export default {
        data() {
            return {
                banner: "character",
                lifetimePulls: 0,
                pity: { quality5: 0, quality4: 0 },
                wins: 0,
                filters: { ["5"]: true, ["4"]: true, ["3"]: true },
                amount: 10,
                pulls: null,
                version: 1.0,
            }
        },
        methods: {
            pityColour(pull) {
                if (pull.quality == 5) {
                    return 80 - pull.pity
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
                    this.pity = bannerData.pity
                    this.wins = bannerData.wins
                    this.version = bannerData.version
                    this.pulls = bannerData.data
                } else {
                    if (localStorage.getItem("character_banner")) {
                        this.pulls = null
                    }
                }
            }
        },
        mounted() {
            this.switchBanner(this.banner, 10)
        }
    }
</script>