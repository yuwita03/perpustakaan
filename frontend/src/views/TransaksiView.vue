<template>
  <div>
    <h2 class="text-2xl font-bold mb-6">Transaksi Peminjaman & Pengembalian</h2>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Peminjaman -->
      <div class="bg-white rounded shadow p-4">
        <h3 class="font-semibold mb-4">Peminjaman Baru</h3>
        <form @submit.prevent="handlePeminjaman">
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Anggota</label>
            <select v-model="pinjam.anggota_id" class="w-full border rounded px-3 py-2" required>
              <option value="">-- Pilih Anggota --</option>
              <option v-for="a in anggota" :key="a.id" :value="a.id">{{ a.nama }}</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Buku</label>
            <select v-model="pinjam.buku_id" class="w-full border rounded px-3 py-2" required>
              <option value="">-- Pilih Buku --</option>
              <option v-for="b in buku" :key="b.id" :value="b.id">{{ b.judul }} (stok: {{ b.stok }})</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Tgl Pinjam</label>
            <input v-model="pinjam.tanggal_pinjam" type="date" class="w-full border rounded px-3 py-2" />
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium mb-1">Tgl Jatuh Tempo</label>
            <input v-model="pinjam.tanggal_jatuh_tempo" type="date" class="w-full border rounded px-3 py-2" />
          </div>
          <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Simpan Peminjaman</button>
        </form>
        <p v-if="pinjamMsg" class="mt-3 text-sm" :class="pinjamMsg.includes('Error') ? 'text-red-500' : 'text-green-600'">{{ pinjamMsg }}</p>
      </div>

      <!-- Pengembalian -->
      <div class="bg-white rounded shadow p-4">
        <h3 class="font-semibold mb-4">Pengembalian Buku</h3>
        <form @submit.prevent="handlePengembalian">
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Peminjaman Aktif</label>
            <select v-model="kembali.peminjaman_id" class="w-full border rounded px-3 py-2" required>
              <option value="">-- Pilih --</option>
              <option v-for="p in peminjamanAktif" :key="p.peminjaman_id" :value="p.peminjaman_id">
                {{ p.nama_anggota }} - {{ p.judul_buku }} ({{ p.tanggal_pinjam }})
              </option>
            </select>
          </div>
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Tgl Kembali</label>
            <input v-model="kembali.tanggal_kembali" type="date" class="w-full border rounded px-3 py-2" />
          </div>
          <div class="mb-4">
            <label class="block text-sm font-medium mb-1">Kondisi Buku</label>
            <select v-model="kembali.kondisi_buku" class="w-full border rounded px-3 py-2">
              <option value="baik">Baik</option>
              <option value="rusak">Rusak</option>
              <option value="hilang">Hilang</option>
            </select>
          </div>
          <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Simpan Pengembalian</button>
        </form>
        <p v-if="kembaliMsg" class="mt-3 text-sm" :class="kembaliMsg.includes('Error') ? 'text-red-500' : 'text-green-600'">{{ kembaliMsg }}</p>
      </div>
    </div>

    <!-- Riwayat -->
    <div class="bg-white rounded shadow p-4 mt-6">
      <h3 class="font-semibold mb-4">Riwayat Transaksi</h3>
      <div class="overflow-x-auto">
        <table class="w-full text-sm">
          <thead><tr class="bg-gray-50 text-left"><th class="p-2">ID</th><th>Anggota</th><th>Buku</th><th>Tgl Pinjam</th><th>Jatuh Tempo</th><th>Status</th><th>Tgl Kembali</th><th>Kondisi</th></tr></thead>
          <tbody>
            <tr v-for="r in riwayat" :key="r.peminjaman_id" class="border-t">
              <td class="p-2">{{ r.peminjaman_id }}</td>
              <td>{{ r.nama_anggota }}</td>
              <td>{{ r.judul_buku }}</td>
              <td>{{ r.tanggal_pinjam }}</td>
              <td>{{ r.tanggal_jatuh_tempo }}</td>
              <td><span :class="r.status === 'dipinjam' ? 'text-yellow-600' : 'text-green-600'">{{ r.status }}</span></td>
              <td>{{ r.tanggal_kembali || '-' }}</td>
              <td>{{ r.kondisi_buku || '-' }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { getAnggota, getBuku, getPeminjaman, createPeminjaman, getRiwayat, createPengembalian } from '../api'

const anggota = ref([])
const buku = ref([])
const riwayat = ref([])
const pinjam = ref({ anggota_id: '', buku_id: '', tanggal_pinjam: '', tanggal_jatuh_tempo: '' })
const kembali = ref({ peminjaman_id: '', tanggal_kembali: '', kondisi_buku: 'baik' })
const pinjamMsg = ref('')
const kembaliMsg = ref('')

const peminjamanAktif = computed(() => riwayat.value.filter(r => r.status === 'dipinjam'))

onMounted(async () => {
  const [resAnggota, resBuku, resRiwayat] = await Promise.all([getAnggota(), getBuku(), getRiwayat()])
  anggota.value = resAnggota.data
  buku.value = resBuku.data
  riwayat.value = resRiwayat.data
})

async function handlePeminjaman() {
  pinjamMsg.value = ''
  try {
    await createPeminjaman(pinjam.value)
    pinjamMsg.value = 'Peminjaman berhasil'
    pinjam.value = { anggota_id: '', buku_id: '', tanggal_pinjam: '', tanggal_jatuh_tempo: '' }
    const [resBuku, resRiwayat] = await Promise.all([getBuku(), getRiwayat()])
    buku.value = resBuku.data
    riwayat.value = resRiwayat.data
  } catch (err) {
    pinjamMsg.value = 'Error: ' + (err.response?.data?.error || err.message)
  }
}

async function handlePengembalian() {
  kembaliMsg.value = ''
  try {
    await createPengembalian(kembali.value)
    kembaliMsg.value = 'Pengembalian berhasil'
    kembali.value = { peminjaman_id: '', tanggal_kembali: '', kondisi_buku: 'baik' }
    const [resBuku, resRiwayat] = await Promise.all([getBuku(), getRiwayat()])
    buku.value = resBuku.data
    riwayat.value = resRiwayat.data
  } catch (err) {
    kembaliMsg.value = 'Error: ' + (err.response?.data?.error || err.message)
  }
}
</script>
