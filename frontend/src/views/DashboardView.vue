<template>
  <div class="min-h-screen bg-slate-50/50 p-6 md:p-8">
    <!-- Header Dashboard -->
    <div class="mb-8">
      <h2 class="text-3xl font-extrabold text-slate-800 tracking-tight">Dashboard</h2>
      <p class="text-slate-500 text-sm mt-1">Selamat datang kembali! Berikut ringkasan aktivitas perpustakaan hari ini.</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex items-center justify-center py-12">
      <div class="animate-pulse flex space-x-2">
        <div class="h-3 w-3 bg-emerald-600 rounded-full"></div>
        <div class="h-3 w-3 bg-emerald-600 rounded-full animate-bounce"></div>
        <div class="h-3 w-3 bg-emerald-600 rounded-full"></div>
      </div>
      <span class="text-slate-500 text-sm ml-3 font-medium">Memuat data...</span>
    </div>

    <div v-else>
      <!-- Stats Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        
        <!-- Total Buku -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Buku</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-blue-600 tracking-tight">{{ stat.total_buku }}</span>
            <span class="p-2 bg-blue-50 text-blue-600 rounded-lg text-xs font-medium">Buku</span>
          </div>
        </div>

        <!-- Total Anggota -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Anggota</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-green-600 tracking-tight">{{ stat.total_anggota }}</span>
            <span class="p-2 bg-green-50 text-green-600 rounded-lg text-xs font-medium">Siswa</span>
          </div>
        </div>

        <!-- Peminjaman Aktif -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Peminjaman Aktif</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-amber-600 tracking-tight">{{ stat.peminjaman_aktif }}</span>
            <span class="p-2 bg-amber-50 text-amber-600 rounded-lg text-xs font-medium">Dipinjam</span>
          </div>
        </div>

        <!-- Total Peminjaman -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Peminjaman</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-purple-600 tracking-tight">{{ stat.total_peminjaman }}</span>
            <span class="p-2 bg-purple-50 text-purple-600 rounded-lg text-xs font-medium">Transaksi</span>
          </div>
        </div>

        <!-- Total Pengembalian -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Pengembalian</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-rose-600 tracking-tight">{{ stat.total_pengembalian }}</span>
            <span class="p-2 bg-rose-50 text-rose-600 rounded-lg text-xs font-medium">Kembali</span>
          </div>
        </div>

        <!-- Kategori Buku -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Kategori Buku</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-indigo-600 tracking-tight">{{ stat.total_kategori }}</span>
            <span class="p-2 bg-indigo-50 text-indigo-600 rounded-lg text-xs font-medium">Kategori</span>
          </div>
        </div>

        <!-- Dokumen -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Dokumen Digital</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-pink-600 tracking-tight">{{ stat.total_dokumen }}</span>
            <span class="p-2 bg-pink-50 text-pink-600 rounded-lg text-xs font-medium">File</span>
          </div>
        </div>

        <!-- Pengguna Sistem -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Pengguna Sistem</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-4xl font-extrabold text-teal-600 tracking-tight">{{ stat.total_users }}</span>
            <span class="p-2 bg-teal-50 text-teal-600 rounded-lg text-xs font-medium">Staff</span>
          </div>
        </div>
      </div>

      <!-- Main Layout: Table & ERD -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        <!-- Buku Terpopuler Table -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm lg:col-span-2">
          <div class="flex items-center justify-between mb-6">
            <h3 class="font-bold text-slate-800 text-lg">Buku Terpopuler</h3>
            <span class="text-xs bg-emerald-50 text-emerald-700 px-3 py-1 rounded-full font-medium">Paling Sering Dipinjam</span>
          </div>

          <div class="overflow-x-auto" v-if="topBuku.length">
            <table class="w-full text-sm text-left">
              <thead>
                <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-100">
                  <th class="pb-3 pl-2">Judul</th>
                  <th class="pb-3">Penulis</th>
                  <th class="pb-3">Kategori</th>
                  <th class="pb-3 text-right pr-2">Dipinjam</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-slate-50">
                <tr v-for="b in topBuku" :key="b.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                  <td class="py-4 pl-2 font-semibold text-slate-800 max-w-[200px] truncate">{{ b.judul }}</td>
                  <td class="py-4 text-slate-500">{{ b.penulis }}</td>
                  <td class="py-4">
                    <span class="px-2.5 py-1 bg-slate-100 text-slate-600 rounded-md text-xs font-medium">
                      {{ b.nama_kategori }}
                    </span>
                  </td>
                  <td class="py-4 text-right pr-2 font-bold text-slate-800">
                    <span class="px-2 py-1 bg-emerald-50 text-emerald-700 rounded-lg text-xs">
                      {{ b.jumlah_dipinjam }}x
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div v-else class="flex flex-col items-center justify-center py-12 text-slate-400">
            <p class="text-sm">Belum ada data buku populer</p>
          </div>
        </div>

        <!-- ERD Card -->

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getStatistik, getBukuTerpopuler } from '../api'

const stat = ref({})
const topBuku = ref([])
const loading = ref(true)

onMounted(async () => {
  try {
    const [s, t] = await Promise.all([getStatistik(), getBukuTerpopuler()])
    stat.value = s.data
    topBuku.value = t.data
  } catch (err) {
    console.error(err)
  } finally {
    loading.value = false
  }
})
</script>