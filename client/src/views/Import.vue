<template>
    <div class="flex flex-col h-full items-center justify-center">
        <div class="flex items-center flex-col w-auto">
            <h1 class="text-4xl textgold pb-8">Import Convenes</h1>
            <Split/>
            <div class="w-full flex pt-10 items-start gap-3">
                <button @click="method = i" v-for="i in 2" :class="{'bgbuttonUnselected': !(method == i)}" class="p-1 px-8 bgbutton">Method {{ i }}</button>
            </div>
            <div v-if="method == 1" class="flex flex-col pt-5 gap-3 w-[62rem]">
                <Instruction number="1" description="Open Wuthering Waves on PC."/>
                <Instruction number="2" description="Open Convene Records and wait for pulls to load."/>
                <Instruction number="3" description="Open Windows PowerShell and run the following command."/>
                <div class="ml-10 h-auto p-5 bgcontainer flex flex-row gap-3 items-center">
                    <button @click="copyToClipboard" class="h-full">
                        <svg v-if="!copied" viewBox="0 0 24 24" style=" width:1.5rem; height:1.5rem; fill:white;" class=" svelte-1mzwbk9"><path id="copySvg" d="M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"></path></svg>
                        <svg v-if="copied" viewBox="0 0 24 24" style=" width:1.5rem; height:1.5rem; fill:white;" class=" svelte-1mzwbk9"><path id="copySvg" d="M9,20.42L2.79,14.21L5.62,11.38L9,14.77L18.88,4.88L21.71,7.71L9,20.42Z"></path></svg>
                    </button>
                    <p id="copyCommand" class="break-all w-[55rem]">[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; Invoke-Expression (New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/alpharmi/ww/main/getGacha.ps1")</p>
                </div>
                <a href="https://github.com/alpharmi/wuthering.app/blob/main/getGacha.ps1" class="ml-10 w-min">GitHub</a>
                <div class="flex">
                    <Instruction number="4" description="Paste your game path if asked."/>
                    <div class="group">
                        <p class="ml-2 text-xs rounded-full border-2 text-center pt-0 w-5 h-5 mt-1 cursor-pointer tooltip">?<img class="absolute top-[33.5rem] left-[53rem] min-w-[650px] min-h-[224px] border-highlight border rounded-lg drop-shadow-md opacity-0 pointer-events-none" src="/other/manual_game_path.png"></p>
                    </div>
                </div>
                <Instruction number="5" description="Paste the Gacha Log URL into the box below."/>
                <div class="flex flex-col gap-3 ml-10">
                    <input ref="gachaLogURL" type="text" placeholder="Please paste Gacha Log URL here." class="bg-[#191c2175] p-3 shadow-lg">
                    <button @click="importGacha" class="bgbutton p-2 w-96 self-end">Import</button>
                </div>
            </div>
            <div v-if="method == 2" class="flex flex-col pt-5 gap-3  w-[62rem]">
                <Instruction number="1" description="Open Wuthering Waves on PC."/>
                <Instruction number="2" description="Open Convene Records and wait for pulls to load."/>
                <Instruction number="3" description="Open File Explorer and find"/>
                <div class="ml-10 h-auto p-5 bgcontainer flex flex-row gap-3 items-center text-sm">
                    <p><span class="text-highlight">Install Folder</span>\Wuthering Waves Game\Client\Binaries\Win64\ThirdParty\KrPcSdk_Global\KRSDKRes\KRSDKWebView\debug.log</p>
                </div>
                <Instruction number="4" description="Drag and drop or upload debug.log below."/>
                <div class="w-[50rem] h-32 bgcontainer relative">
                    <div class="absolute w-full h-full flex gap-1 items-center justify-center text-xl pointer-events-none">
                        <img class="w-14" src="/other/select.png">
                        <p>{{ uploadStatus }}</p>
                    </div>
                    <input @change="importGacha" type="file" class="w-full h-full cursor-pointer absolute opacity-0">
                </div>
            </div>
            <div class="flex flex-col w-full h-24 items-center justify-center text-center pt-5">
                <div v-if="importing">
                    <p class="text-2xl textgold capitalize">Importing {{ importing.replaceAll("_", " ") }} Banner</p>
                    <p>Total Convenes: <span class="text-highlight">{{ totalConvenes }}</span></p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    import Split from "../components/Split.vue"
    import Instruction from "../components/convene/Instruction.vue"

    import * as vueRouter from "vue-router"

    const router = vueRouter.useRouter()
</script>

<script>
    import standard from "../data/standard.json"

    const gachaTypes = {beginner: 5, character: 1, weapon: 2, standard: 3, choice: 6, weapon_choice: 4}
    const guaranteedGachaTypes = ["beginner", "standard", "choice", "weapon_choice"]

    export default {
        data() {
            return {
                production: true,
                copied: false,
                importing: "",
                totalConvenes: 0,
                method: 1,
                uploadStatus: "Drag and drop or select debug.log"
            }
        },
        methods: {
            async importGacha(input) {
                var gachaLogURL = undefined

                if (this.method == 1) {
                    const input = this.$refs.gachaLogURL

                    gachaLogURL = input.value
                } else {
                    const debugLog = input.target.files[0]

                    if (debugLog && debugLog.name == "debug.log") {
                        const lines = (await debugLog.text()).split("\n")

                        for (const line of lines) {
                            if (line.includes("https://aki-gm-resources-oversea.aki-game.net/aki/gacha/index.html#/record")) {
                                gachaLogURL = `${line.split(': "')[1].replace('",', "")}&wa_method=upload`
                                this.uploadStatus = "debug.log"

                                //break
                            }
                        }

                        if (!gachaLogURL) {
                            this.uploadStatus = "Unable to find Gacha Url. Please open Convene Records in game."
                            setInterval(() => {
                                this.uploadStatus = "Drag and drop or select debug.log"
                            }, 3000);
                        }
                    } else {
                        this.uploadStatus = "Incorrect file"
                        setInterval(() => {
                            this.uploadStatus = "Drag and drop or select debug.log"
                        }, 3000);
                    }
                }

                if (gachaLogURL && gachaLogURL.startsWith("https://aki-gm-resources-oversea.aki-game.net/aki/gacha/index.html#/record")) {
                    this.totalConvenes = 0

                    for (const [gachaType, gachaTypeId] of Object.entries(gachaTypes)) {
                        this.importing = gachaType

                        const url = this.production? "https://wuthering-app.vercel.app/api/importGacha?": "http://localhost:3000/api/importGacha?"
                        const quereries = Object.fromEntries(new URLSearchParams(gachaLogURL.slice(75)))

                        var gachaData = await fetch(url + new URLSearchParams({
                            resources_id: quereries.resources_id, 
                            gacha_type: gachaTypeId,
                            player_id: quereries.player_id,
                            record_id: quereries.record_id,
                            svr_id: quereries.svr_id,
                            wa_method: quereries.wa_method
                        })).then(response => response.json())

                        if (gachaData && gachaData.length > 0) {
                            const banner = {data: [], monthlyPulls: [], wins: 0, version: 1.2}
                            const conveneAmount = gachaData.length
                            const pity = {quality5: conveneAmount, quality4: conveneAmount}
                            const wins = {won: 0, lost: 0}
                            var win = true

                            this.totalConvenes += conveneAmount

                            //const cachedBanner = JSON.parse(localStorage.getItem(`${gachaType}_banner`))

                            //gachaData.splice(gachaData.map(pull => pull.time).indexOf("2024-05-24 11:52:23"))
                            //console.log(gachaData)

                            for (const [i, convene] of Object.entries(gachaData).reverse()) {
                                const conveneData = {
                                    name: convene.name.replaceAll(" ", "_"),
                                    quality: convene.qualityLevel,
                                    type: convene.resourceType.toLowerCase(),
                                    date: convene.time,
                                    win: "Won",
                                }

                                if (convene.qualityLevel >= 4) {
                                    conveneData["pity"] = pity[`quality${convene.qualityLevel}`] - i
                                    pity[`quality${convene.qualityLevel}`] = i

                                    if (convene.qualityLevel == 5) {
                                        pity.quality4 = i
                                    }
                                }

                                if (convene.qualityLevel == 5) {
                                    if (!win || guaranteedGachaTypes.includes(gachaType)) {
                                        conveneData.win = "Guaranteed"
                                        win = true
                                    } else {
                                        if (standard.includes(convene.name)) {
                                            conveneData.win = "Lost"
                                            win = false
                                            wins.lost += 1
                                        } else {
                                            wins.won += 1
                                        }
                                    }

                                    if (guaranteedGachaTypes.includes(gachaType)) {
                                        wins.won += 1
                                    }
                                }

                                banner.data.push(conveneData)
                            }

                            const quality4Pulls = banner.data.filter(pull => pull.quality == 4)
                            const quality5Pulls = banner.data.filter(pull => pull.quality == 5)

                            const quality4Average =  Math.round(quality4Pulls.reduce((a, b) => a + b.pity, 0) / quality4Pulls.length) || 0
                            const quality5Average =  Math.round(quality5Pulls.reduce((a, b) => a + b.pity, 0) / quality5Pulls.length) || 0

                            banner.data.reverse()
                            banner.pity = {quality5: Number(pity.quality5), quality4: Number(pity.quality4), average5: quality5Average, average4: quality4Average}
                            banner.wins = Math.round(((wins.won / (wins.won + wins.lost)) * 100)) || 0

                            localStorage.setItem(`${gachaType}_banner`, JSON.stringify(banner))
                        } else {
                            if (!localStorage.getItem(`${gachaType}_banner}`)) {
                                localStorage.setItem(`${gachaType}_banner`, JSON.stringify({data: [], monthlyPulls: [], wins: 0, pity: {quality5: 0, quality4: 0, average5: 0, average4: 0}, version: 1.2}))
                            }
                        }
                    }

                    setTimeout(() => {
                        this.$router.push({path: "/convene"})
                    }, 1000);

                } else {
                    input.value = ""
                    input.placeholder = "Invalid Gacha Log URL."
                    setInterval(() => {
                        input.placeholder = "Paste the Gacha Log URL into the box below."
                    }, 3000)
                }
            },
            copyToClipboard() {
                navigator.clipboard.writeText('[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; Invoke-Expression (New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/alpharmi/ww/main/getGacha.ps1")')

                this.copied = true
                setInterval(() => {
                    this.copied = false
                }, 1000)
            }
        }
    }
</script>