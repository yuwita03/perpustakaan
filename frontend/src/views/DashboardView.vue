<template>
  <div class="min-h-screen bg-slate-50/50 p-4 md:p-8 font-sans antialiased">
    <!-- Header Dashboard -->
    <div class="mb-8 pb-5 border-b border-slate-200/60">
      <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Dashboard Perpustakaan</h2>
      <p class="text-slate-500 text-sm mt-1">Selamat datang kembali! Berikut ringkasan aktivitas perpustakaan hari ini.</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex flex-col items-center justify-center py-32 space-y-4">
      <div class="flex space-x-2">
        <div class="h-3 w-3 bg-emerald-600 rounded-full animate-bounce [animation-delay:-0.3s]"></div>
        <div class="h-3 w-3 bg-emerald-600 rounded-full animate-bounce [animation-delay:-0.15s]"></div>
        <div class="h-3 w-3 bg-emerald-600 rounded-full animate-bounce"></div>
      </div>
      <span class="text-slate-500 text-sm font-medium tracking-wide">Memuat data perpustakaan...</span>
    </div>

    <!-- Main Content (Layout Atas ke Bawah) -->
    <div v-else class="space-y-8 animate-fade-in">
      
      <!-- 1. Grid Statistik -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <!-- Peminjaman Aktif -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Peminjaman Aktif</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-amber-600 tracking-tight">{{ stat.peminjaman_aktif }}</span>
            <span class="px-2 py-1 bg-amber-50 text-amber-700 rounded text-xs font-medium">Buku Dipinjam</span>
          </div>
        </div>

        <!-- Total Peminjaman -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Peminjaman</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-purple-600 tracking-tight">{{ stat.total_peminjaman }}</span>
            <span class="px-2 py-1 bg-purple-50 text-purple-700 rounded text-xs font-medium">Transaksi</span>
          </div>
        </div>

        <!-- Total Pengembalian -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Pengembalian</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-rose-600 tracking-tight">{{ stat.total_pengembalian }}</span>
            <span class="px-2 py-1 bg-rose-50 text-rose-700 rounded text-xs font-medium">Selesai</span>
          </div>
        </div>

        <!-- Total Anggota -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Anggota</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-green-600 tracking-tight">{{ stat.total_anggota }}</span>
            <span class="px-2 py-1 bg-green-50 text-green-700 rounded text-xs font-medium">Siswa</span>
          </div>
        </div>

        <!-- Total Buku -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Buku</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-blue-600 tracking-tight">{{ stat.total_buku }}</span>
            <span class="px-2 py-1 bg-blue-50 text-blue-700 rounded text-xs font-medium">Eksplampar</span>
          </div>
        </div>

        <!-- Kategori Buku -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Kategori Buku</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-indigo-600 tracking-tight">{{ stat.total_kategori }}</span>
            <span class="px-2 py-1 bg-indigo-50 text-indigo-700 rounded text-xs font-medium">Kategori</span>
          </div>
        </div>

        <!-- Dokumen Digital -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Dokumen Digital</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-pink-600 tracking-tight">{{ stat.total_dokumen }}</span>
            <span class="px-2 py-1 bg-pink-50 text-pink-700 rounded text-xs font-medium">File</span>
          </div>
        </div>

        <!-- Pengguna Sistem -->
        <div class="bg-white p-6 rounded-xl border border-slate-200/60 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between">
          <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Pengguna Sistem</span>
          <div class="flex items-baseline justify-between mt-4">
            <span class="text-3xl font-extrabold text-teal-600 tracking-tight">{{ stat.total_users }}</span>
            <span class="px-2 py-1 bg-teal-50 text-teal-700 rounded text-xs font-medium">Staff</span>
          </div>
        </div>
      </div>

      <!-- 2. Tabel Buku Terpopuler (Full Width) -->
      <div class="bg-white p-6 rounded-2xl border border-slate-200/60 shadow-sm">
        <div class="flex items-center justify-between mb-6">
          <div>
            <h3 class="font-bold text-slate-900 text-lg">Buku Terpopuler</h3>
            <p class="text-xs text-slate-400 mt-0.5">Daftar buku dengan frekuensi peminjaman tertinggi oleh pengguna.</p>
          </div>
          <span class="text-[11px] bg-slate-100 text-slate-600 px-3 py-1 rounded-full font-medium tracking-wide">Data Terintegrasi</span>
        </div>

        <div class="overflow-x-auto" v-if="topBuku.length">
          <table class="w-full text-sm text-left border-collapse">
            <thead>
              <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200 pb-3">
                <th class="pb-3 pl-2">Judul Buku</th>
                <th class="pb-3">Penulis</th>
                <th class="pb-3">Kategori</th>
                <th class="pb-3 text-right pr-2">Total Peminjaman</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
              <tr v-for="b in topBuku" :key="b.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                <td class="py-4 pl-2 font-semibold text-slate-800">{{ b.judul }}</td>
                <td class="py-4 text-slate-500">{{ b.penulis }}</td>
                <td class="py-4">
                  <span class="px-2.5 py-1 bg-slate-100 text-slate-600 rounded-md text-xs font-medium">
                    {{ b.nama_kategori }}
                  </span>
                </td>
                <td class="py-4 text-right pr-2">
                  <span class="px-2.5 py-1 bg-emerald-50 text-emerald-700 rounded-md text-xs font-bold">
                    {{ b.jumlah_dipinjam }} kali
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div v-else class="text-center py-12 text-slate-400 text-sm">
          Belum ada data aktivitas buku populer saat ini.
        </div>
      </div>

      <!-- 3. Grafik Tren Peminjaman (Full Width di bagian paling bawah) -->
      <div class="bg-white p-6 rounded-2xl border border-slate-200/60 shadow-sm">
        <div class="mb-6">
          <h3 class="font-bold text-slate-900 text-lg">Grafik Analisis Buku Terpopuler</h3>
          <p class="text-xs text-slate-400 mt-0.5">Visualisasi perbandingan jumlah peminjaman antar judul buku.</p>
        </div>
        <div class="relative w-full" :style="{ height: Math.max(topBuku.length * 50, 250) + 'px' }">
          <Bar v-if="chartData.labels.length" :data="chartData" :options="chartOptions" />
          <p v-else class="text-slate-400 text-sm text-center py-12">Data grafik tidak tersedia</p>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getStatistik, getBukuTerpopuler } from '../api'
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title, Tooltip, Legend, BarElement,
  CategoryScale, LinearScale
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const stat = ref({})
const topBuku = ref([])
const loading = ref(true)

const chartData = ref({ labels: [], datasets: [{ label: 'Jumlah Dipinjam', backgroundColor: '#10b981', borderRadius: 6, data: [] }] })
const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  indexAxis: 'y',
  plugins: { 
    legend: { display: false },
    tooltip: {
      padding: 12,
      backgroundColor: '#1e293b',
      titleFont: { size: 12, weight: 'bold' },
      bodyFont: { size: 12 }
    }
  },
  scales: {
    x: { 
      beginAtZero: true, 
      ticks: { stepSize: 1, color: '#94a3b8' },
      grid: { color: '#f1f5f9' }
    },
    y: {
      ticks: {
        color: '#475569',
        font: { weight: '500' }
      },
      grid: { display: false }
    }
  }
}

onMounted(async () => {
  try {
    const [s, t] = await Promise.all([getStatistik(), getBukuTerpopuler()])
    stat.value = s.data
    topBuku.value = t.data

    chartData.value = {
      labels: t.data.map(b => b.judul),
      datasets: [{ 
        label: 'Jumlah Dipinjam', 
        backgroundColor: '#10b981', 
        hoverBackgroundColor: '#059669',
        borderRadius: 6, 
        barThickness: 18,
        data: t.data.map(b => b.jumlah_dipinjam) 
      }]
    }
  } catch (err) {
    console.error(err)
  } finally {
    loading.value = false
  }
})
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