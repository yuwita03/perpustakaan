<template>
  <div class="min-h-screen flex items-center justify-center bg-slate-50/50 p-4 font-sans antialiased">
    <div class="bg-white p-8 rounded-2xl border border-slate-200/60 shadow-xl w-full max-w-md animate-fade-in">
      <!-- Header Form -->
      <div class="text-center mb-8">
        <h1 class="text-2xl font-bold text-slate-900 tracking-tight">Login Sistem Perpustakaan</h1>
        <p class="text-slate-400 text-sm mt-1">Masukkan kredensial database Anda untuk melanjutkan</p>
      </div>

      <form @submit.prevent="handleLogin" class="space-y-5">
        <!-- Input Username -->
        <div>
          <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Username</label>
          <input 
            v-model="username" 
            type="text" 
            class="w-full bg-white border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-700 focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all placeholder:text-slate-300"
            placeholder="Masukkan username Anda"
            required 
          />
        </div>

        <!-- Input Password -->
        <div>
          <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Password</label>
          <input 
            v-model="password" 
            type="password" 
            class="w-full bg-white border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-700 focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all placeholder:text-slate-300"
            placeholder="••••••••"
            required 
          />
        </div>

        <!-- Alert Error Teks Polos -->
        <div 
          v-if="error" 
          class="bg-rose-50 text-rose-700 border border-rose-200/50 rounded-xl p-3.5 text-sm font-medium"
        >
          Gagal: {{ error }}
        </div>

        <!-- Tombol Submit -->
        <button 
          type="submit" 
          class="w-full bg-blue-600 text-white text-sm font-semibold py-3 rounded-xl hover:bg-blue-700 active:bg-blue-800 disabled:bg-slate-200 disabled:text-slate-400 disabled:cursor-not-allowed transition-all shadow-sm flex justify-center items-center h-[46px]"
          :disabled="loading"
        >
          <span v-if="loading" class="inline-flex items-center gap-2">
            <svg class="animate-spin h-4 w-4 text-slate-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Memproses Autentikasi...
          </span>
          <span v-else>Masuk ke Dashboard</span>
        </button>
      </form>

      <!-- Seksi Instant Login -->
      <div class="mt-8 pt-6 border-t border-slate-100">
        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider text-center mb-3">Instant Login (Akses Cepat)</p>
        <div class="grid grid-cols-2 gap-3">
          <button 
            @click="instantLogin('admin')"
            type="button"
            class="px-3 py-2 text-xs font-semibold text-blue-700 bg-blue-50 hover:bg-blue-100 border border-blue-200/60 rounded-xl transition-colors text-center"
            :disabled="loading"
          >
            Sebagai Admin
          </button>
          <button 
            @click="instantLogin('petugas1')"
            type="button"
            class="px-3 py-2 text-xs font-semibold text-emerald-700 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200/60 rounded-xl transition-colors text-center"
            :disabled="loading"
          >
            Sebagai Petugas 1
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const auth = useAuthStore()
const router = useRouter()
const username = ref('')
const password = ref('')
const error = ref('')
const loading = ref(false)

async function handleLogin() {
  error.value = ''
  loading.value = true
  try {
    await auth.login(username.value, password.value)
    router.push('/')
  } catch (err) {
    error.value = err.response?.data?.error || 'Kombinasi sandi atau akun salah'
  } finally {
    loading.value = false
  }
}

// Fungsi Instant Login disesuaikan dengan nilai admin dan petugas1
async function instantLogin(selectedUser) {
  username.value = selectedUser
  password.value = 'password123'
  await handleLogin()
}
</script>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.4s ease-out forwards;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>