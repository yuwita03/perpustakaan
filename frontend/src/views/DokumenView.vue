<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8 pb-5 border-b border-slate-200/60">
      <div>
        <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Manajemen Dokumen</h2>
        <p class="text-slate-500 text-sm mt-1">Kelola arsip berkas, pelacakan versi berkas, dan riwayat unggahan dokumen internal.</p>
      </div>
      <button 
        @click="showModal = true" 
        class="bg-blue-600 text-white text-sm font-semibold px-5 py-2.5 rounded-xl hover:bg-blue-700 transition-colors shadow-sm self-start sm:self-auto"
      >
        Tambah Dokumen
      </button>
    </div>

    <!-- Table Container -->
    <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full text-sm text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
              <th class="py-4 px-6">ID</th>
              <th class="py-4 px-4">Judul Dokumen</th>
              <th class="py-4 px-4">Nama File</th>
              <th class="py-4 px-4 text-center">Jenis</th>
              <th class="py-4 px-4">Lokasi Berkas</th>
              <th class="py-4 px-4 text-center">Versi</th>
              <th class="py-4 px-4">Pengunggah</th>
              <th class="py-4 px-4">Tanggal Unggah</th>
              <th class="py-4 px-6 text-right">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-100">
            <tr v-for="d in dokumen" :key="d.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
              <td class="py-4 px-6 font-mono text-xs font-semibold text-slate-400">{{ d.id }}</td>
              <td class="py-4 px-4 font-semibold text-slate-800 max-w-[200px] truncate">{{ d.judul }}</td>
              <td class="py-4 px-4 text-slate-500 max-w-[150px] truncate">{{ d.nama_file }}</td>
              <td class="py-4 px-4 text-center">
                <span class="inline-flex px-2 py-0.5 bg-slate-100 text-slate-600 rounded text-xs font-medium uppercase">
                  {{ d.jenis_file || '-' }}
                </span>
              </td>
              <td class="py-4 px-4 text-slate-500 max-w-xs truncate font-mono text-xs">{{ d.lokasi_file || '-' }}</td>
              <td class="py-4 px-4 text-center text-slate-700 font-medium">v{{ d.versi || '1.0' }}</td>
              <td class="py-4 px-4 text-slate-600 font-medium">{{ d.uploaded_by_name || '-' }}</td>
              <td class="py-4 px-4 text-slate-500 whitespace-nowrap">
                {{ new Date(d.tanggal_unggah).toLocaleDateString('id-ID', { year: 'numeric', month: 'short', day: 'numeric' }) }}
              </td>
              <td class="py-4 px-6 text-right whitespace-nowrap">
                <button 
                  @click="handleDelete(d.id)" 
                  class="text-xs font-medium border border-rose-200 text-rose-600 px-3 py-1.5 rounded-lg hover:bg-rose-50 transition-colors"
                >
                  Hapus
                  </button>
              </td>
            </tr>
            <tr v-if="dokumen.length === 0">
              <td colspan="9" class="text-center py-12 text-slate-400 text-sm">
                Belum ada dokumen yang diarsipkan dalam basis data.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal Form (Clean Vertical Flow) -->
    <div v-if="showModal" class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl border border-slate-100 shadow-xl w-full max-w-md overflow-hidden animate-scale-in">
        <div class="p-6 border-b border-slate-100">
          <h3 class="text-lg font-bold text-slate-900">Tambah Dokumen Baru</h3>
          <p class="text-xs text-slate-400 mt-0.5">Entri meta data arsip dokumen ke peladen penyimpanan.</p>
        </div>
        
        <form @submit.prevent="handleSave" class="p-6 space-y-4">
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Judul Dokumen *</label>
            <input v-model="form.judul" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" required />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Nama File Fisik *</label>
            <input v-model="form.nama_file" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" required />
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Jenis File</label>
              <input v-model="form.jenis_file" placeholder="Contoh: PDF, DOCX" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all placeholder:text-slate-300" />
            </div>
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Versi Rilis</label>
              <input v-model="form.versi" placeholder="1.0.0" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all placeholder:text-slate-300" />
            </div>
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Lokasi Direktori File</label>
            <input v-model="form.lokasi_file" placeholder="/uploads/documents/" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all placeholder:text-slate-300 font-mono" />
          </div>
          
          <div class="flex justify-end gap-3 pt-4 border-t border-slate-100 mt-6">
            <button 
              type="button" 
              @click="showModal = false" 
              class="px-4 py-2 border border-slate-200 text-slate-600 rounded-xl text-sm font-medium hover:bg-slate-50 transition-colors"
            >
              Batal
            </button>
            <button 
              type="submit" 
              class="px-4 py-2 bg-blue-600 text-white rounded-xl text-sm font-semibold hover:bg-blue-700 transition-colors shadow-sm"
            >
              Simpan Dokumen
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getDokumen, createDokumen, deleteDokumen } from '../api'

const dokumen = ref([])
const showModal = ref(false)
const form = ref({ judul: '', nama_file: '', jenis_file: '', lokasi_file: '', versi: '' })

onMounted(() => loadData())

async function loadData() {
  const res = await getDokumen()
  dokumen.value = res.data
}

async function handleSave() {
  try {
    await createDokumen(form.value)
    showModal.value = false
    form.value = { judul: '', nama_file: '', jenis_file: '', lokasi_file: '', versi: '' }
    loadData()
  } catch (err) {
    alert(err.response?.data?.error || 'Gagal menyimpan dokumen baru')
  }
}

async function handleDelete(id) {
  if (!confirm('Apakah Anda yakin ingin menghapus arsip dokumen ini secara permanen?')) return
  try {
    await deleteDokumen(id)
    loadData()
  } catch (err) {
    alert(err.response?.data?.error || 'Gagal menghapus berkas dokumen')
  }
}
</script>

<style scoped>
.animate-scale-in {
  animation: scaleIn 0.2s ease-out forwards;
}
@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.98); }
  to { opacity: 1; transform: scale(1); }
}
</style>