import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import './assets/style.css'

const app = createApp(App)
const pinia = createPinia()
app.use(pinia)

import { useAuthStore } from './stores/auth'
const auth = useAuthStore()
auth.checkAuth().finally(() => {
  app.use(router)
  app.mount('#app')
})
