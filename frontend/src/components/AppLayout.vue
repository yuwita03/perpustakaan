<template>
  <div class="flex h-screen bg-gray-100">
    <Sidebar />
    <div class="flex-1 flex flex-col overflow-hidden">
      <header class="bg-white shadow-sm border-b px-6 py-4 flex items-center justify-between">
        <h1 class="text-xl font-semibold text-gray-800">Sistem Perpustakaan Kampus</h1>
        <div class="flex items-center gap-4">
          <span class="text-sm text-gray-600">
            {{ auth.user?.username }} ({{ auth.user?.role === 'administrator' ? 'Administrator' : 'Petugas' }})
          </span>
          <button @click="handleLogout" class="bg-red-500 text-white px-3 py-1.5 rounded text-sm hover:bg-red-600">
            Logout
          </button>
        </div>
      </header>
      <main class="flex-1 overflow-y-auto p-6">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import Sidebar from './Sidebar.vue'

const auth = useAuthStore()
const router = useRouter()

async function handleLogout() {
  await auth.logout()
  router.push('/login')
}
</script>
