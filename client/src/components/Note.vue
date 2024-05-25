<template>
    <div class="flex bgcontainer w-max h-18 items-center gap-3 p-3 whitespace-pre-line text-description">
        <img src="/other/note_sticker.png" class="h-12">
        <p>{{ `• ${message.replace(",", "\n•")}` }}</p>
    </div>
</template>

<script>
    export default {
        props: {
            message: String
        }
    }
</script>