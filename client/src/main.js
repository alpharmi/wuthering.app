import { createApp } from 'vue'
//import { inject } from '@vercel/analytics'
import * as VueRouter from 'vue-router'
import App from './App.vue'
import './assets/tailwind.css'

import Home from "./views/Home.vue"
import Convene from "./views/Convene.vue"
import Import from './views/Import.vue'

const routes = [
    { path: "", component: Home },
    { path: "/convene", component: Convene },
    { path: "/convene/import", component: Import }
]

const router = VueRouter.createRouter({
    history: VueRouter.createWebHistory(),
    scrollBehavior() {return { top: 0 }},
    routes
})

const app = createApp(App)
app.use(router)
app.mount("#app")
//inject()