<template>
  <div>
    <h2 class="text-2xl font-bold mb-6">Laporan</h2>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white rounded shadow p-4">
        <h3 class="font-semibold mb-4">Buku Tersedia</h3>
        <div class="overflow-x-auto max-h-80 overflow-y-auto">
          <table class="w-full text-sm">
            <thead><tr class="bg-gray-50 text-left"><th class="p-2">Judul</th><th>Kategori</th><th>Stok Tersedia</th></tr></thead>
            <tbody>
              <tr v-for="b in bukuTersedia" :key="b.id" class="border-t"><td class="p-2">{{ b.judul }}</td><td>{{ b.nama_kategori }}</td><td>{{ b.stok_tersedia }}</td></tr>
            </tbody>
          </table>
          <p v-if="bukuTersedia.length === 0" class="p-4 text-gray-400">Data tidak tersedia</p>
        </div>
      </div>

      <div class="bg-white rounded shadow p-4">
        <h3 class="font-semibold mb-4">Buku Sedang Dipinjam</h3>
        <div class="overflow-x-auto max-h-80 overflow-y-auto">
          <table class="w-full text-sm">
            <thead><tr class="bg-gray-50 text-left"><th class="p-2">Buku</th><th>Peminjam</th><th>Jatuh Tempo</th><th>Status</th></tr></thead>
            <tbody>
              <tr v-for="b in bukuDipinjam" :key="b.peminjaman_id" class="border-t">
                <td class="p-2">{{ b.judul_buku }}</td><td>{{ b.nama_anggota }}</td><td>{{ b.tanggal_jatuh_tempo }}</td>
                <td><span :class="b.status_pinjam === 'Terlambat' ? 'text-red-600 font-bold' : 'text-green-600'">{{ b.status_pinjam }}</span></td>
              </tr>
            </tbody>
          </table>
          <p v-if="bukuDipinjam.length === 0" class="p-4 text-gray-400">Tidak ada buku dipinjam</p>
        </div>
      </div>
    </div>

    <div class="bg-white rounded shadow p-4 mt-6">
      <h3 class="font-semibold mb-4">Riwayat Peminjaman</h3>
      <div class="overflow-x-auto max-h-96 overflow-y-auto">
        <table class="w-full text-sm">
          <thead><tr class="bg-gray-50 text-left"><th class="p-2">Anggota</th><th>Buku</th><th>Pinjam</th><th>Kembali</th><th>Kondisi</th></tr></thead>
          <tbody>
            <tr v-for="r in riwayat" :key="r.peminjaman_id" class="border-t">
              <td class="p-2">{{ r.nama_anggota }}</td><td>{{ r.judul_buku }}</td><td>{{ r.tanggal_pinjam }}</td>
              <td>{{ r.tanggal_kembali || '-' }}</td><td>{{ r.kondisi_buku || '-' }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="bg-white rounded shadow p-4 mt-6">
      <h3 class="font-semibold mb-4">Filter Laporan per Periode</h3>
      <div class="flex gap-4 items-end mb-4">
        <div><label class="block text-sm mb-1">Tanggal Mulai</label><input v-model="periode.mulai" type="date" class="border rounded px-3 py-2" /></div>
        <div><label class="block text-sm mb-1">Tanggal Selesai</label><input v-model="periode.selesai" type="date" class="border rounded px-3 py-2" /></div>
        <button @click="cariPeriode" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Cari</button>
      </div>
      <div class="overflow-x-auto" v-if="laporanPeriode.length">
        <table class="w-full text-sm">
          <thead><tr class="bg-gray-50 text-left"><th class="p-2">Anggota</th><th>Buku</th><th>Pinjam</th><th>Jatuh Tempo</th><th>Status</th><th>Kembali</th></tr></thead>
          <tbody>
            <tr v-for="r in laporanPeriode" :key="r.id" class="border-t">
              <td class="p-2">{{ r.anggota }}</td><td>{{ r.buku }}</td><td>{{ r.tanggal_pinjam }}</td>
              <td>{{ r.tanggal_jatuh_tempo }}</td><td>{{ r.status }}</td><td>{{ r.tanggal_kembali || '-' }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="bg-white rounded shadow p-4 mt-6">
      <h3 class="font-semibold mb-4">Kualitas Data - Sebelum & Sesudah Perbaikan</h3>
      <div class="overflow-x-auto">
        <table class="w-full text-sm">
          <thead><tr class="bg-gray-50 text-left"><th class="p-2">Tabel</th><th>Jenis Masalah</th><th class="text-center">Sebelum</th><th class="text-center">Sesudah</th><th class="text-center">Status</th></tr></thead>
          <tbody>
            <tr v-for="d in kualitasData" :key="d.id" class="border-t">
              <td class="p-2">{{ d.tabel_terkait }}</td>
              <td>{{ d.jenis_masalah }}</td>
              <td class="text-center">{{ d.jumlah_sebelum }}</td>
              <td class="text-center">{{ d.jumlah_sesudah }}</td>
              <td class="text-center">
                <span v-if="d.jumlah_sesudah === 0" class="text-green-600 font-medium">✓ Bersih</span>
                <span v-else class="text-red-600 font-medium">✗ Bermasalah</span>
              </td>
            </tr>
          </tbody>
        </table>
        <p v-if="kualitasData.length === 0" class="p-4 text-gray-400 text-center">Belum ada data</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getBukuTersedia, getBukuDipinjam, getRiwayat, getLaporanPerPeriode, getKualitasData } from '../api'

const bukuTersedia = ref([])
const bukuDipinjam = ref([])
const riwayat = ref([])
const laporanPeriode = ref([])
const kualitasData = ref([])
const periode = ref({ mulai: '', selesai: '' })

onMounted(async () => {
  try {
    const [t, d, r, k] = await Promise.all([
      getBukuTersedia(), getBukuDipinjam(), getRiwayat(), getKualitasData(),
    ])
    bukuTersedia.value = t.data
    bukuDipinjam.value = d.data
    riwayat.value = r.data
    kualitasData.value = k.data
  } catch (err) { console.error(err) }
})

async function cariPeriode() {
  if (!periode.value.mulai || !periode.value.selesai) return
  const res = await getLaporanPerPeriode(periode.value.mulai, periode.value.selesai)
  laporanPeriode.value = res.data
}
</script>
