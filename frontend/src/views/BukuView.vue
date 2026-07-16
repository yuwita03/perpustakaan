<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8 pb-5 border-b border-slate-200/60">
      <div>
        <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Katalog Buku</h2>
        <p class="text-slate-500 text-sm mt-1">Kelola daftar buku, kategori, penulis, dan ketersediaan stok fisik perpustakaan.</p>
      </div>
      <button 
        @click="showModal = true" 
        class="bg-blue-600 text-white text-sm font-semibold px-5 py-2.5 rounded-xl hover:bg-blue-700 transition-colors shadow-sm self-start sm:self-auto"
      >
        Tambah Buku
      </button>
    </div>

    <!-- Filter & Search Bar -->
    <div class="mb-6 bg-white p-4 rounded-xl border border-slate-200/60 shadow-sm">
      <div class="w-full max-w-md relative">
        <input 
          v-model="searchQuery" 
          @input="search" 
          placeholder="Cari judul buku, penulis, atau penerbit..." 
          class="w-full bg-slate-50 border border-slate-200 text-slate-700 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all placeholder:text-slate-400" 
        />
      </div>
    </div>

    <!-- Table Container (Spacious layout, no icons) -->
    <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full text-sm text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
              <th class="py-4 px-6">ID</th>
              <th class="py-4 px-4">Judul Buku</th>
              <th class="py-4 px-4">Penulis</th>
              <th class="py-4 px-4">Kategori</th>
              <th class="py-4 px-4">Penerbit</th>
              <th class="py-4 px-4 text-center">Tahun</th>
              <th class="py-4 px-4 text-center">Stok</th>
              <th class="py-4 px-6 text-right">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-100">
            <tr v-for="b in buku" :key="b.id" class="text-slate-600 hover:bg-slate-50/50 transition-colors">
              <td class="py-4 px-6 font-mono text-xs font-semibold text-slate-400">{{ b.id }}</td>
              <td class="py-4 px-4 font-semibold text-slate-800 max-w-[220px] truncate">{{ b.judul }}</td>
              <td class="py-4 px-4 text-slate-500">{{ b.penulis || '-' }}</td>
              <td class="py-4 px-4">
                <span class="inline-flex px-2.5 py-0.5 bg-slate-100 text-slate-600 rounded text-xs font-medium">
                  {{ b.nama_kategori || '-' }}
                </span>
              </td>
              <td class="py-4 px-4 text-slate-500">{{ b.penerbit || '-' }}</td>
              <td class="py-4 px-4 text-center text-slate-500 font-medium">{{ b.tahun_terbit || '-' }}</td>
              <td class="py-4 px-4 text-center">
                <span 
                  class="font-bold text-xs px-2.5 py-1 rounded-md"
                  :class="b.stok > 0 ? 'bg-emerald-50 text-emerald-700' : 'bg-rose-50 text-rose-700'"
                >
                  {{ b.stok }} eks
                </span>
              </td>
              <td class="py-4 px-6 text-right whitespace-nowrap">
                <div class="inline-flex gap-2">
                  <button 
                    @click="editBuku(b)" 
                    class="text-xs font-medium border border-slate-200 px-3 py-1.5 rounded-lg hover:bg-slate-50 hover:text-blue-600 transition-colors"
                  >
                    Ubah
                  </button>
                  <button 
                    @click="handleDelete(b.id)" 
                    class="text-xs font-medium border border-rose-200 text-rose-600 px-3 py-1.5 rounded-lg hover:bg-rose-50 transition-colors"
                  >
                    Hapus
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="!buku.length">
              <td colspan="8" class="text-center py-12 text-slate-400 text-sm">
                Tidak ada koleksi buku yang ditemukan.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal Form (Clean Vertical Form Flow) -->
    <div v-if="showModal" class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl border border-slate-100 shadow-xl w-full max-w-md overflow-hidden animate-scale-in">
        <div class="p-6 border-b border-slate-100">
          <h3 class="text-lg font-bold text-slate-900">{{ editing ? 'Ubah Informasi' : 'Tambah' }} Buku</h3>
          <p class="text-xs text-slate-400 mt-0.5">Isi seluruh informasi katalog buku dengan teliti.</p>
        </div>
        
        <form @submit.prevent="handleSave" class="p-6 space-y-4">
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Judul Buku *</label>
            <input v-model="form.judul" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" required />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Nama Penulis</label>
            <input v-model="form.penulis" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Kategori Buku</label>
            <select v-model="form.kategori_id" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all appearance-none">
              <option value="">Pilih Kategori</option>
              <option v-for="k in kategori" :key="k.id" :value="k.id">{{ k.nama_kategori }}</option>
            </select>
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Penerbit</label>
            <input v-model="form.penerbit" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tahun Terbit</label>
              <input v-model="form.tahun_terbit" type="number" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
            </div>
            <div>
              <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Jumlah Stok</label>
              <input v-model="form.stok" type="number" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" min="0" />
            </div>
          </div>
          
          <div class="flex justify-end gap-3 pt-4 border-t border-slate-100 mt-6">
            <button 
              type="button" 
              @click="closeModal" 
              class="px-4 py-2 border border-slate-200 text-slate-600 rounded-xl text-sm font-medium hover:bg-slate-50 transition-colors"
            >
              Batal
            </button>
            <button 
              type="submit" 
              class="px-4 py-2 bg-blue-600 text-white rounded-xl text-sm font-semibold hover:bg-blue-700 transition-colors shadow-sm"
            >
              Simpan Buku
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getBuku, createBuku, updateBuku, deleteBuku, searchBuku, getKategori } from '../api'

const buku = ref([])
const kategori = ref([])
const showModal = ref(false)
const editing = ref(null)
const searchQuery = ref('')
const form = ref({ judul: '', penulis: '', kategori_id: '', penerbit: '', tahun_terbit: '', stok: 0 })

onMounted(() => { loadData(); loadKategori() })

async function loadData() {
  const res = await getBuku()
  buku.value = res.data
}

async function loadKategori() {
  const res = await getKategori()
  kategori.value = res.data
}

async function search() {
  if (!searchQuery.value) return loadData()
  const res = await searchBuku(searchQuery.value)
  buku.value = res.data
}

function editBuku(b) {
  editing.value = b.id
  form.value = { judul: b.judul, penulis: b.penulis || '', kategori_id: b.kategori_id || '', penerbit: b.penerbit || '', tahun_terbit: b.tahun_terbit || '', stok: b.stok }
  showModal.value = true
}

function closeModal() {
  showModal.value = false
  editing.value = null
  form.value = { judul: '', penulis: '', kategori_id: '', penerbit: '', tahun_terbit: '', stok: 0 }
}

async function handleSave() {
  if (editing.value) {
    await updateBuku(editing.value, form.value)
  } else {
    await createBuku(form.value)
  }
  closeModal()
  loadData()
}

async function handleDelete(id) {
  if (!confirm('Apakah Anda yakin ingin menghapus data buku ini secara permanen?')) return
  try { 
    await deleteBuku(id)
    loadData() 
  } catch (err) { 
    alert(err.response?.data?.error || 'Gagal menghapus data buku') 
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