<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="mb-8 pb-5 border-b border-slate-200/60">
      <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Sirkulasi Transaksi</h2>
      <p class="text-slate-500 text-sm mt-1">Pencatatan sirkulasi peminjaman baru dan pemrosesan pengembalian buku.</p>
    </div>

    <!-- Main Content Flow (Formulir Atas ke Bawah) -->
    <div class="space-y-8 animate-fade-in">
      
      <!-- Container Dua Formulir Utama -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start">
        
        <!-- Formulir Peminjaman Baru -->
        <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
          <div class="p-5 border-b border-slate-100 bg-slate-50/50">
            <h3 class="font-bold text-slate-800 text-base">Peminjaman Baru</h3>
            <p class="text-xs text-slate-400 mt-0.5">Formulir untuk pembuatan log peminjaman buku.</p>
          </div>
          <form @submit.prevent="handlePeminjaman" class="p-6 space-y-4">
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Nama Anggota *</label>
              <select v-model="pinjam.anggota_id" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all appearance-none" required>
                <option value="">Pilih Anggota</option>
                <option v-for="a in anggotaAktif" :key="a.id" :value="a.id">{{ a.nama }}</option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Judul Buku *</label>
              <select v-model="pinjam.buku_id" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all appearance-none" required>
                <option value="">Pilih Buku</option>
                <option v-for="b in buku" :key="b.id" :value="b.id">{{ b.judul }} (Tersedia: {{ b.stok }} eks)</option>
              </select>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tanggal Pinjam</label>
                <input v-model="pinjam.tanggal_pinjam" type="datetime-local" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
              </div>
              <div>
                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Jatuh Tempo</label>
                <input v-model="pinjam.tanggal_jatuh_tempo" type="datetime-local" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
              </div>
            </div>
            <div class="pt-2">
              <button type="submit" class="w-full bg-blue-600 text-white text-sm font-semibold px-4 py-2.5 rounded-xl hover:bg-blue-700 transition-colors shadow-sm">
                Simpan Peminjaman
              </button>
            </div>
            <div v-if="pinjamMsg" class="mt-2 p-3 rounded-lg text-xs font-medium" :class="pinjamMsg.includes('Error') ? 'bg-rose-50 text-rose-700' : 'bg-emerald-50 text-emerald-700'">
              {{ pinjamMsg }}
            </div>
          </form>
        </div>

        <!-- Formulir Pengembalian Buku -->
        <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
          <div class="p-5 border-b border-slate-100 bg-slate-50/50">
            <h3 class="font-bold text-slate-800 text-base">Pengembalian Buku</h3>
            <p class="text-xs text-slate-400 mt-0.5">Formulir pemrosesan peminjaman yang sedang aktif.</p>
          </div>
          <form @submit.prevent="handlePengembalian" class="p-6 space-y-4">
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Peminjaman Aktif *</label>
              <select v-model="kembali.peminjaman_id" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all appearance-none" required>
                <option value="">Pilih Transaksi Peminjaman</option>
                <option v-for="p in peminjamanAktif" :key="p.peminjaman_id" :value="p.peminjaman_id">
                  {{ p.nama_anggota }} - {{ p.judul_buku }} ({{ p.tanggal_pinjam }})
                </option>
              </select>
            </div>
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tanggal Kembali</label>
              <input v-model="kembali.tanggal_kembali" type="datetime-local" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
            </div>
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Kondisi Buku Fisik</label>
              <select v-model="kembali.kondisi_buku" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all appearance-none">
                <option value="baik">Kondisi Baik</option>
                <option value="rusak">Kondisi Rusak</option>
                <option value="hilang">Buku Hilang</option>
              </select>
            </div>
            <div class="pt-2">
              <button type="submit" class="w-full bg-emerald-600 text-white text-sm font-semibold px-4 py-2.5 rounded-xl hover:bg-emerald-700 transition-colors shadow-sm">
                Proses Pengembalian
              </button>
            </div>
            <div v-if="kembaliMsg" class="mt-2 p-3 rounded-lg text-xs font-medium" :class="kembaliMsg.includes('Error') ? 'bg-rose-50 text-rose-700' : 'bg-emerald-50 text-emerald-700'">
              {{ kembaliMsg }}
            </div>
          </form>
        </div>
      </div>

      <!-- Riwayat Transaksi (Bagian Bawah - Full Width) -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-6 border-b border-slate-100 flex items-center justify-between">
          <div>
            <h3 class="font-bold text-slate-900 text-lg">Log Riwayat Transaksi</h3>
            <p class="text-xs text-slate-400 mt-0.5">Daftar keseluruhan mutasi sirkulasi dokumen perpustakaan.</p>
          </div>
          <span class="text-[11px] bg-slate-100 text-slate-600 px-3 py-1 rounded-full font-medium tracking-wide">Pembaruan Otomatis</span>
        </div>
        
        <div class="overflow-x-auto">
          <table class="w-full text-sm text-left border-collapse">
            <thead>
              <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
                <th class="py-4 px-6">ID</th>
                <th class="py-4 px-4">Nama Anggota</th>
                <th class="py-4 px-4">Judul Buku</th>
                <th class="py-4 px-4">Tgl Pinjam</th>
                <th class="py-4 px-4">Jatuh Tempo</th>
                <th class="py-4 px-4 text-center">Status</th>
                <th class="py-4 px-4">Tgl Kembali</th>
                <th class="py-4 px-6">Kondisi</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
              <tr v-for="r in riwayat" :key="r.peminjaman_id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                <td class="py-4 px-6 font-mono text-xs font-semibold text-slate-400">{{ r.peminjaman_id }}</td>
                <td class="py-4 px-4 font-semibold text-slate-800">{{ r.nama_anggota }}</td>
                <td class="py-4 px-4 font-medium text-slate-700 max-w-[180px] truncate">{{ r.judul_buku }}</td>
                <td class="py-4 px-4 text-slate-500 whitespace-nowrap">{{ r.tanggal_pinjam }}</td>
                <td class="py-4 px-4 text-slate-500 whitespace-nowrap">{{ r.tanggal_jatuh_tempo }}</td>
                <td class="py-4 px-4 text-center whitespace-nowrap">
                  <span 
                    class="inline-flex px-2.5 py-0.5 rounded-full text-xs font-semibold tracking-wide"
                    :class="r.status === 'dipinjam' ? 'bg-amber-50 text-amber-700' : 'bg-emerald-50 text-emerald-700'"
                  >
                    {{ r.status === 'dipinjam' ? 'Dipinjam' : 'Kembali' }}
                  </span>
                </td>
                <td class="py-4 px-4 text-slate-500 whitespace-nowrap">{{ r.tanggal_kembali || '-' }}</td>
                <td class="py-4 px-6">
                  <span 
                    v-if="r.kondisi_buku"
                    class="text-xs font-medium uppercase tracking-wider"
                    :class="r.kondisi_buku === 'baik' ? 'text-emerald-600' : 'text-rose-600'"
                  >
                    {{ r.kondisi_buku }}
                  </span>
                  <span v-else class="text-slate-400">-</span>
                </td>
              </tr>
              <tr v-if="!riwayat.length">
                <td colspan="8" class="text-center py-12 text-slate-400 text-sm">
                  Belum ada log transaksi yang tercatat.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { getAnggota, getBuku, createPeminjaman, getRiwayat, createPengembalian } from '../api'

const anggota = ref([])
const buku = ref([])
const riwayat = ref([])
const pinjam = ref({ anggota_id: '', buku_id: '', tanggal_pinjam: '', tanggal_jatuh_tempo: '' })
const kembali = ref({ peminjaman_id: '', tanggal_kembali: '', kondisi_buku: 'baik' })
const pinjamMsg = ref('')
const kembaliMsg = ref('')

const peminjamanAktif = computed(() => riwayat.value.filter(r => r.status === 'dipinjam'))
const anggotaAktif = computed(() => anggota.value.filter(a => a.status !== 'nonaktif'))

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
    pinjamMsg.value = 'Registrasi transaksi peminjaman berhasil disimpan.'
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
    kembaliMsg.value = 'Proses penutupan peminjaman selesai diproses.'
    kembali.value = { peminjaman_id: '', tanggal_kembali: '', kondisi_buku: 'baik' }
    const [resBuku, resRiwayat] = await Promise.all([getBuku(), getRiwayat()])
    buku.value = resBuku.data
    riwayat.value = resRiwayat.data
  } catch (err) {
    kembaliMsg.value = 'Error: ' + (err.response?.data?.error || err.message)
  }
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