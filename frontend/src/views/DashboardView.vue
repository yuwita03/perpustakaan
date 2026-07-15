<template>
  <div>
    <h2 class="text-2xl font-bold mb-6">Dashboard</h2>

    <div v-if="loading" class="text-gray-500">Memuat data...</div>

    <div v-else class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 mb-8">
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-blue-600">{{ stat.total_buku }}</div>
        <div class="text-gray-600 text-sm">Total Buku</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-green-600">{{ stat.total_anggota }}</div>
        <div class="text-gray-600 text-sm">Total Anggota</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-yellow-600">{{ stat.peminjaman_aktif }}</div>
        <div class="text-gray-600 text-sm">Peminjaman Aktif</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-purple-600">{{ stat.total_peminjaman }}</div>
        <div class="text-gray-600 text-sm">Total Peminjaman</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-red-600">{{ stat.total_pengembalian }}</div>
        <div class="text-gray-600 text-sm">Total Pengembalian</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-indigo-600">{{ stat.total_kategori }}</div>
        <div class="text-gray-600 text-sm">Kategori Buku</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-pink-600">{{ stat.total_dokumen }}</div>
        <div class="text-gray-600 text-sm">Dokumen</div>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <div class="text-3xl font-bold text-teal-600">{{ stat.total_users }}</div>
        <div class="text-gray-600 text-sm">Pengguna Sistem</div>
      </div>
    </div>

    <div class="bg-white p-4 rounded shadow mb-6">
      <h3 class="font-semibold mb-4">Buku Terpopuler</h3>
      <table class="w-full text-sm" v-if="topBuku.length">
        <thead><tr class="text-left border-b"><th class="py-2">Judul</th><th>Penulis</th><th>Kategori</th><th>Dipinjam</th></tr></thead>
        <tbody>
          <tr v-for="b in topBuku" :key="b.id" class="border-b">
            <td class="py-2">{{ b.judul }}</td>
            <td>{{ b.penulis }}</td>
            <td>{{ b.nama_kategori }}</td>
            <td>{{ b.jumlah_dipinjam }}</td>
          </tr>
        </tbody>
      </table>
      <p v-else class="text-gray-400 text-sm">Belum ada data</p>
    </div>

    <div class="bg-white p-4 rounded shadow">
      <h3 class="font-semibold mb-4">Entity Relationship Diagram (ERD)</h3>
      <p class="text-gray-400 text-sm italic">Letakkan file erd.png di folder frontend/public/ untuk menampilkan ERD.</p>
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
