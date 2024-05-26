<template>
  <header class="w-full fixed h-14 from-[#191c214d] to-transparent bg-gradient-to-r backdrop-blur-md text-description shadow-md z-50">
    <div class="flex gap-3 w-full h-full items-center px-10 text-2xl">
      <button @click="redirect('/')">wuthering.app</button>
      <div v-if="routePage" class="w-2 h-2 bg-white rounded-full opacity-10"></div>
      <p class="textgold">{{ currentRoute() }}</p>
    </div>
  </header>
  <main class="min-h-screen pt-28">
    <RouterView/>
  </main>
  <footer class="flex flex-col gap-1 items-center justify-center w-full h-48 bg-[#1E1E20]">
    <div class="flex flex-col items-center justify-center text-description">
      <p>wuthering.app</p>
      <p>Wuthering Waves and content are trademarks and copyright of Guangzhou Kuro Technology Co., Ltd.</p>
      <p>Design inspired by <a href="https://wutheringwaves.kurogames.com/en/">wutheringwaves.kurogames.com</a> and <a href="https://paimon.moe/">paimon.moe</a>.</p>
    </div>
    <div class="w-[50rem]">
      <Split/>
    </div>
    <div class="flex gap-3 pt-1 relative">
      <a href="https://github.com/alpharmi/wuthering.app" class="bgbutton p-1 flex gap-1 px-2">
        <svg viewBox="0 0 24 24" style=" width:1.5rem; height:1.5rem; fill:currentColor;"><path d="M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z"></path></svg>
        <p>GitHub</p>
      </a>
      <Button class="bgbutton p-1 px-2">Privacy Policy</Button>
    </div>
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
  import Split from "./components/Split.vue";

  import * as vueRouter from "vue-router"

  const router = vueRouter.useRouter()

  function redirect(route) {
      router.push({
          path: route,
      })
  }
</script>