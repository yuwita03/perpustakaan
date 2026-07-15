import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login as apiLogin, logout as apiLogout, getMe } from '../api'

export const useAuthStore = defineStore('auth', () => {
  const user = ref(null)

  const isLoggedIn = ref(false)

  async function login(username, password) {
    const res = await apiLogin(username, password)
    user.value = res.data.user
    isLoggedIn.value = true
    return res.data
  }

  async function logout() {
    await apiLogout()
    user.value = null
    isLoggedIn.value = false
  }

  async function checkAuth() {
    try {
      const res = await getMe()
      user.value = res.data.user
      isLoggedIn.value = true
    } catch {
      user.value = null
      isLoggedIn.value = false
    }
  }

  return { user, isLoggedIn, login, logout, checkAuth }
})
