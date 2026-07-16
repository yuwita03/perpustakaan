<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="mb-8 pb-5 border-b border-slate-200/60">
      <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Pusat Analisis & Laporan</h2>
      <p class="text-slate-500 text-sm mt-1">Pemantauan ketersediaan buku, status sirkulasi aktif, ringkasan berkala, serta audit integritas data.</p>
    </div>

    <!-- Alur Atas ke Bawah (Top-to-Bottom Layout) -->
    <div class="space-y-8 animate-fade-in">
      
      <!-- LEVEL 1: Ringkasan Status Buku Saat Ini (Grid Dua Kolom Sejajar) -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start">
        <!-- Tabel Buku Tersedia -->
        <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
          <div class="p-5 border-b border-slate-100 bg-slate-50/50">
            <h3 class="font-bold text-slate-800 text-base">Katalog Buku Tersedia</h3>
            <p class="text-xs text-slate-400 mt-0.5">Daftar buku dengan unit fisik siap pinjam di rak perpustakaan.</p>
          </div>
          <div class="overflow-x-auto max-h-80 overflow-y-auto custom-scrollbar">
            <table class="w-full text-sm text-left border-collapse">
              <thead class="sticky top-0 bg-slate-50 z-10 border-b border-slate-200">
                <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider">
                  <th class="py-3.5 px-6">Judul Buku</th>
                  <th class="py-3.5 px-4">Kategori</th>
                  <th class="py-3.5 px-6 text-center">Stok</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-slate-100">
                <tr v-for="b in bukuTersedia" :key="b.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                  <td class="py-3.5 px-6 font-semibold text-slate-800">{{ b.judul }}</td>
                  <td class="py-3.5 px-4 text-slate-500">{{ b.nama_kategori }}</td>
                  <td class="py-3.5 px-6 text-center">
                    <span class="inline-flex px-2.5 py-0.5 bg-blue-50 text-blue-700 rounded text-xs font-bold">
                      {{ b.stok_tersedia }} eks
                    </span>
                  </td>
                </tr>
                <tr v-if="bukuTersedia.length === 0">
                  <td colspan="3" class="text-center py-8 text-slate-400 text-sm">Data tidak tersedia</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Tabel Buku Sedang Dipinjam -->
        <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
          <div class="p-5 border-b border-slate-100 bg-slate-50/50">
            <h3 class="font-bold text-slate-800 text-base">Buku Sedang Dipinjam</h3>
            <p class="text-xs text-slate-400 mt-0.5">Daftar sirkulasi keluar yang sedang dipegang oleh anggota perpustakaan.</p>
          </div>
          <div class="overflow-x-auto max-h-80 overflow-y-auto custom-scrollbar">
            <table class="w-full text-sm text-left border-collapse">
              <thead class="sticky top-0 bg-slate-50 z-10 border-b border-slate-200">
                <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider">
                  <th class="py-3.5 px-6">Judul Buku</th>
                  <th class="py-3.5 px-4">Peminjam</th>
                  <th class="py-3.5 px-4">Jatuh Tempo</th>
                  <th class="py-3.5 px-6 text-center">Status</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-slate-100">
                <tr v-for="b in bukuDipinjam" :key="b.peminjaman_id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                  <td class="py-3.5 px-6 font-medium text-slate-800 max-w-[150px] truncate">{{ b.judul_buku }}</td>
                  <td class="py-3.5 px-4 text-slate-600 font-medium">{{ b.nama_anggota }}</td>
                  <td class="py-3.5 px-4 text-slate-500 whitespace-nowrap">{{ b.tanggal_jatuh_tempo }}</td>
                  <td class="py-3.5 px-6 text-center whitespace-nowrap">
                    <span 
                      class="text-xs px-2.5 py-0.5 rounded-full font-semibold"
                      :class="b.status_pinjam === 'Terlambat' ? 'bg-rose-50 text-rose-700' : 'bg-amber-50 text-amber-700'"
                    >
                      {{ b.status_pinjam }}
                    </span>
                  </td>
                </tr>
                <tr v-if="bukuDipinjam.length === 0">
                  <td colspan="4" class="text-center py-8 text-slate-400 text-sm">Tidak ada buku yang sedang dipinjam</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- LEVEL 2: Riwayat Peminjaman Menyeluruh -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100">
          <h3 class="font-bold text-slate-800 text-base">Riwayat Peminjaman Global</h3>
          <p class="text-xs text-slate-400 mt-0.5">Log catatan pengembalian buku lengkap beserta kondisi fisik dokumen.</p>
        </div>
        <div class="overflow-x-auto max-h-80 overflow-y-auto custom-scrollbar">
          <table class="w-full text-sm text-left border-collapse">
            <thead class="sticky top-0 bg-slate-50 z-10 border-b border-slate-200">
              <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider">
                <th class="py-3.5 px-6">Nama Anggota</th>
                <th class="py-4 px-4">Judul Buku</th>
                <th class="py-4 px-4">Tgl Pinjam</th>
                <th class="py-4 px-4">Tgl Kembali</th>
                <th class="py-4 px-6">Kondisi Buku</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
              <tr v-for="r in riwayat" :key="r.peminjaman_id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                <td class="py-3.5 px-6 font-semibold text-slate-800">{{ r.nama_anggota }}</td>
                <td class="py-3.5 px-4 font-medium text-slate-700 max-w-[200px] truncate">{{ r.judul_buku }}</td>
                <td class="py-3.5 px-4 text-slate-500">{{ r.tanggal_pinjam }}</td>
                <td class="py-3.5 px-4 text-slate-500">{{ r.tanggal_kembali || '-' }}</td>
                <td class="py-3.5 px-6">
                  <span 
                    v-if="r.kondisi_buku"
                    class="text-xs font-semibold uppercase tracking-wider"
                    :class="r.kondisi_buku === 'baik' ? 'text-emerald-600' : 'text-rose-600'"
                  >
                    {{ r.kondisi_buku }}
                  </span>
                  <span v-else class="text-slate-400">-</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- LEVEL 3: Filter Laporan Berdasarkan Periode Waktu -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100">
          <h3 class="font-bold text-slate-800 text-base">Filter Laporan per Periode</h3>
          <p class="text-xs text-slate-400 mt-0.5">Penarikan data sirkulasi berdasarkan batas penanggalan tertentu.</p>
        </div>
        <div class="p-6">
          <div class="flex flex-col sm:flex-row gap-4 items-end mb-6 bg-slate-50 p-4 rounded-xl border border-slate-200/50">
            <div class="w-full sm:w-auto">
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tanggal Mulai</label>
              <input v-model="periode.mulai" type="date" class="w-full bg-white border border-slate-200 rounded-xl px-3.5 py-2 text-sm text-slate-700 focus:outline-none focus:border-blue-500 transition-all" />
            </div>
            <div class="w-full sm:w-auto">
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tanggal Selesai</label>
              <input v-model="periode.selesai" type="date" class="w-full bg-white border border-slate-200 rounded-xl px-3.5 py-2 text-sm text-slate-700 focus:outline-none focus:border-blue-500 transition-all" />
            </div>
            <button @click="cariPeriode" class="w-full sm:w-auto bg-blue-600 text-white text-sm font-semibold px-5 py-2 rounded-xl hover:bg-blue-700 transition-colors shadow-sm h-[38px]">
              Cari Data
            </button>
          </div>

          <div class="overflow-x-auto border border-slate-100 rounded-xl" v-if="laporanPeriode.length">
            <table class="w-full text-sm text-left border-collapse">
              <thead>
                <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
                  <th class="py-3 px-4">Anggota</th>
                  <th class="py-3 px-4">Buku</th>
                  <th class="py-3 px-4">Tgl Pinjam</th>
                  <th class="py-3 px-4">Jatuh Tempo</th>
                  <th class="py-3 px-4 text-center">Status</th>
                  <th class="py-3 px-4">Tgl Kembali</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-slate-100">
                <tr v-for="r in laporanPeriode" :key="r.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                  <td class="py-3 px-4 font-semibold text-slate-800">{{ r.anggota }}</td>
                  <td class="py-3 px-4 text-slate-700">{{ r.buku }}</td>
                  <td class="py-3 px-4 text-slate-500">{{ r.tanggal_pinjam }}</td>
                  <td class="py-3 px-4 text-slate-500">{{ r.tanggal_jatuh_tempo }}</td>
                  <td class="py-3 px-4 text-center">
                    <span class="inline-flex px-2 py-0.5 bg-slate-100 text-slate-600 rounded text-xs font-medium uppercase">{{ r.status }}</span>
                  </td>
                  <td class="py-3 px-4 text-slate-500">{{ r.tanggal_kembali || '-' }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- LEVEL 4: Audit Kualitas Data (Data Quality Integrity) -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100">
          <h3 class="font-bold text-slate-800 text-base">Kualitas Data - Sebelum dan Sesudah Perbaikan</h3>
          <p class="text-xs text-slate-400 mt-0.5">Matriks validasi data anomali atau *orphan data* untuk menjaga konsistensi database perpustakaan.</p>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full text-sm text-left border-collapse">
            <thead>
              <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
                <th class="py-4 px-6">Tabel Entitas</th>
                <th class="py-4 px-4">Jenis Masalah Kontaminasi</th>
                <th class="py-4 px-4 text-center">Sebelum</th>
                <th class="py-4 px-4 text-center">Sesudah</th>
                <th class="py-4 px-6 text-center">Status Data</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
              <tr v-for="d in kualitasData" :key="d.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
                <td class="py-4 px-6 font-semibold text-slate-800">{{ d.tabel_terkait }}</td>
                <td class="py-4 px-4 text-slate-500">{{ d.jenis_masalah }}</td>
                <td class="py-4 px-4 text-center text-slate-600 font-mono font-medium">{{ d.jumlah_sebelum }}</td>
                <td class="py-4 px-4 text-center text-slate-600 font-mono font-medium">{{ d.jumlah_sesudah }}</td>
                <td class="py-4 px-6 text-center whitespace-nowrap">
                  <span 
                    class="text-xs font-bold px-3 py-1 rounded-md tracking-wider uppercase inline-block min-w-[80px]"
                    :class="d.jumlah_sesudah === 0 ? 'bg-emerald-50 text-emerald-700 border border-emerald-200/50' : 'bg-rose-50 text-rose-700 border border-rose-200/50'"
                  >
                    {{ d.jumlah_sesudah === 0 ? 'Bersih' : 'Bermasalah' }}
                  </span>
                </td>
              </tr>
              <tr v-if="kualitasData.length === 0">
                <td colspan="5" class="text-center py-12 text-slate-400 text-sm">Belum ada metrik kualitas data yang dicatat.</td>
              </tr>
            </tbody>
          </table>
        </div>
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
  } catch (err) { 
    console.error(err) 
  }
})

async function cariPeriode() {
  if (!periode.value.mulai || !periode.value.selesai) return
  try {
    const res = await getLaporanPerPeriode(periode.value.mulai, periode.value.selesai)
    laporanPeriode.value = res.data
  } catch (err) {
    console.error(err)
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

/* Custom minimal scrollbar styling untuk tabel yang di-scroll secara internal */
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