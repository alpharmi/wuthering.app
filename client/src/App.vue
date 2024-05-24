<template>
  <header class="w-full fixed h-14 from-[#191c214d] to-transparent bg-gradient-to-r backdrop-blur-md text-stone-400 shadow-md z-50">
    <div class="flex gap-3 w-full h-full items-center px-10 text-2xl">
      <h1>placeholder</h1>
      <div v-if="routePage" class="w-2 h-2 bg-white rounded-full opacity-10"></div>
      <p class="textgold">{{ currentRoute() }}</p>
    </div>
  </header>
  <main class="h-[calc(100vh)] pt-10">
    <RouterView/>
  </main>
  <footer class="w-full h-40 bg-white">

  </footer>
</template>

<script>
  export default {
    data() {
      return {
        routePage: false
      }
    },
    methods: {
      currentRoute() {
        const route = this.$router.currentRoute.value.fullPath.split("/").at(-1)

        if (route) {
          this.routePage = true
        }

        return route
      }
    }
  }
</script>

<script setup>
  import * as vueRouter from "vue-router"

  const router = vueRouter.useRouter()
</script>