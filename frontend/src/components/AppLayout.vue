<template>
  <div class="flex h-screen bg-slate-50/50 font-sans antialiased">
    <!-- Komponen Navigasi Samping -->
    <Sidebar />

    <!-- Konten Utama Kanan -->
    <div class="flex-1 flex flex-col overflow-hidden">
      
      <!-- Top Bar / Header -->
      <header class="bg-white border-b border-slate-200/80 px-6 py-4 flex items-center justify-between z-10 shadow-sm">
        <div class="flex items-center gap-3">
          <h1 class="text-lg font-bold text-slate-900 tracking-tight">Sistem Perpustakaan Kampus</h1>
        </div>

        <!-- Sisi Kanan Header: Info Akun & Aksi -->
        <div class="flex items-center gap-5">
          <!-- Status Informasi Akun -->
          <div class="text-right hidden sm:block">
            <p class="text-sm font-semibold text-slate-800 leading-none mb-1">
              {{ auth.user?.username }}
            </p>
            <span 
              class="inline-flex text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded"
              :class="auth.user?.role === 'administrator' ? 'bg-blue-50 text-blue-700 border border-blue-100' : 'bg-emerald-50 text-emerald-700 border border-emerald-100'"
            >
              {{ auth.user?.role === 'administrator' ? 'Administrator' : 'Petugas' }}
            </span>
          </div>

          <!-- Batas Pemisah Visual -->
          <div class="h-6 w-px bg-slate-200 hidden sm:block"></div>

          <!-- Tombol Keluar Sistem -->
          <button 
            @click="handleLogout" 
            class="bg-white hover:bg-rose-50 text-slate-700 hover:text-rose-700 border border-slate-200 hover:border-rose-200 px-4 py-2 rounded-xl text-xs font-semibold tracking-wide transition-all shadow-sm active:scale-[0.98]"
          >
            Keluar Aplikasi
          </button>
        </div>
      </header>

      <!-- View Area untuk Halaman Dalam -->
      <main class="flex-1 overflow-y-auto p-4 md:p-8 custom-scrollbar">
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
  try {
    await auth.logout()
    router.push('/login')
  } catch (err) {
    console.error('Proses keluar gagal:', err)
  }
}
</script>

<style scoped>
/* Pembuatan scrollbar internal yang konsisten dengan tema halaman lainnya */
.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 3px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}
</style>