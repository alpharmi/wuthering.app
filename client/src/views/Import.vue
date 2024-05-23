<template>
    <div class="flex flex-col h-full items-center justify-center">
        <div class="flex items-center flex-col w-auto">
            <h1 class="text-4xl textgold pb-8">Import Convenes</h1>
            <Split/>
            <div class="flex flex-col pt-10 gap-3">
                <Instruction number="1" description="Open Wuthering Waves on PC."/>
                <Instruction number="2" description="Open Convene Records and wait for pulls to load."/>
                <Instruction number="3" description="Open Windows PowerShell and run the following command."/>
                <div class="ml-10 h-auto p-5 bgcontainer flex flex-row gap-3 items-center">
                    <button @click="copytoclipboard" class="h-full">
                        <svg viewBox="0 0 24 24" style=" width:1.5rem; height:1.5rem; fill:white;" class=" svelte-1mzwbk9"><path id="copySvg" d="M19,21H8V7H19M19,5H8A2,2 0 0,0 6,7V21A2,2 0 0,0 8,23H19A2,2 0 0,0 21,21V7A2,2 0 0,0 19,5M16,1H4A2,2 0 0,0 2,3V17H4V3H16V1Z"></path></svg>
                    </button>
                    <p id="copyCommand" class="break-all">Start-Process powershell -Verb runAs -ArgumentList '-NoExit -Command "Invoke-Expression <br/> (New-Object Net.WebClient).DownloadString(\"https://raw.githubusercontent.com/alpharmi/ww/main/getGacha.ps1\")"'</p>
                </div>
                <Instruction number="4" description="Paste the Gacha Log URL into the box below."/>
                <div class="flex flex-col gap-3 ml-10">
                    <input type="text" placeholder="Please paste Gacha Log URL here." class="bg-[#191c2175] p-3 shadow-lg">
                    <Button class="bgbutton p-2 w-96 self-end textshadow">Import</Button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
    import Split from '../components/Split.vue'
    import Instruction from "../components/convene/Instruction.vue"
</script>