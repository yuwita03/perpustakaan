<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8 pb-5 border-b border-slate-200/60">
      <div>
        <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Data Anggota</h2>
        <p class="text-slate-500 text-sm mt-1">Kelola dan pantau seluruh data siswa yang terdaftar di perpustakaan.</p>
      </div>
      <button 
        @click="showModal = true" 
        class="bg-blue-600 text-white text-sm font-semibold px-5 py-2.5 rounded-xl hover:bg-blue-700 transition-colors shadow-sm self-start sm:self-auto"
      >
        Tambah Anggota
      </button>
    </div>

    <!-- Filter & Search Bar -->
    <div class="mb-6 bg-white p-4 rounded-xl border border-slate-200/60 shadow-sm">
      <div class="w-full max-w-md relative">
        <input 
          v-model="searchQuery" 
          @input="search" 
          placeholder="Cari berdasarkan nama atau ID anggota..." 
          class="w-full bg-slate-50 border border-slate-200 text-slate-700 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all placeholder:text-slate-400" 
        />
      </div>
    </div>

    <!-- Table Container -->
    <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full text-sm text-left border-collapse">
          <thead>
            <tr class="bg-slate-50/75 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
              <th class="py-4 px-6">ID</th>
              <th class="py-4 px-4">Nama Lengkap</th>
              <th class="py-4 px-4">Alamat</th>
              <th class="py-4 px-4">Kontak</th>
              <th class="py-4 px-4">Tanggal Daftar</th>
              <th class="py-4 px-4 text-center">Status</th>
              <th class="py-4 px-6 text-right">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-100">
            <tr 
              v-for="a in anggota" 
              :key="a.id" 
              class="text-slate-600 hover:bg-slate-50/50 transition-colors"
              :class="a.status === 'nonaktif' ? 'opacity-60 bg-slate-50/30' : ''"
            >
              <td class="py-4 px-6 font-mono text-xs font-semibold text-slate-400">{{ a.id }}</td>
              <td class="py-4 px-4 font-semibold text-slate-800">{{ a.nama }}</td>
              <td class="py-4 px-4 max-w-[200px] truncate text-slate-500">{{ a.alamat || '-' }}</td>
              <td class="py-4 px-4 text-slate-500">
                <div class="flex flex-col">
                  <span class="font-medium text-slate-700">{{ a.no_telepon || '-' }}</span>
                  <span class="text-xs text-slate-400">{{ a.email || '-' }}</span>
                </div>
              </td>
              <td class="py-4 px-4 text-slate-500">{{ a.tanggal_daftar || '-' }}</td>
              <td class="py-4 px-4 text-center">
                <span 
                  class="inline-flex px-2.5 py-1 rounded-full text-xs font-semibold tracking-wide"
                  :class="a.status === 'aktif' || !a.status ? 'bg-emerald-50 text-emerald-700' : 'bg-rose-50 text-rose-700'"
                >
                  {{ a.status === 'nonaktif' ? 'Nonaktif' : 'Aktif' }}
                </span>
              </td>
              <td class="py-4 px-6 text-right whitespace-nowrap">
                <div class="inline-flex gap-2">
                  <button 
                    v-if="a.status === 'aktif' || !a.status" 
                    @click="editAnggota(a)" 
                    class="text-xs font-medium border border-slate-200 px-3 py-1.5 rounded-lg hover:bg-slate-50 hover:text-blue-600 transition-colors"
                  >
                    Ubah
                  </button>
                  <span 
                    v-else 
                    class="text-xs text-slate-400 border border-slate-100 bg-slate-50 px-3 py-1.5 rounded-lg select-none"
                  >
                    Terkunci
                  </span>
                  <button 
                    @click="handleToggleStatus(a)" 
                    class="text-xs font-medium border px-3 py-1.5 rounded-lg transition-colors"
                    :class="a.status === 'nonaktif' 
                      ? 'border-emerald-200 text-emerald-600 hover:bg-emerald-50' 
                      : 'border-rose-200 text-rose-600 hover:bg-rose-50'"
                  >
                    {{ a.status === 'nonaktif' ? 'Aktifkan' : 'Nonaktifkan' }}
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="!anggota.length">
              <td colspan="7" class="text-center py-12 text-slate-400 text-sm">
                Tidak ada data anggota ditemukan.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal Form (Struktur Atas ke Bawah) -->
    <div v-if="showModal" class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-2xl border border-slate-100 shadow-xl w-full max-w-md overflow-hidden animate-scale-in">
        <div class="p-6 border-b border-slate-100">
          <h3 class="text-lg font-bold text-slate-900">{{ editing ? 'Ubah Data' : 'Tambah' }} Anggota</h3>
          <p class="text-xs text-slate-400 mt-0.5">Lengkapi formulir di bawah ini dengan informasi yang valid.</p>
        </div>
        
        <form @submit.prevent="handleSave" class="p-6 space-y-4">
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Nama Lengkap *</label>
            <input v-model="form.nama" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" required />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Alamat Tempat Tinggal</label>
            <input v-model="form.alamat" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Nomor Telepon</label>
            <input v-model="form.no_telepon" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Alamat Email</label>
            <input v-model="form.email" type="email" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
          </div>
          <div>
            <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1.5">Tanggal Pendaftaran</label>
            <input v-model="form.tanggal_daftar" type="date" class="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2 text-sm focus:outline-none focus:border-blue-500 focus:bg-white transition-all" />
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
              Simpan Data
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getAnggota, createAnggota, updateAnggota, toggleStatusAnggota, searchAnggota } from '../api'
import { useAuthStore } from '../stores/auth'

const auth = useAuthStore()
const anggota = ref([])
const showModal = ref(false)
const editing = ref(null)
const searchQuery = ref('')
const form = ref({ nama: '', alamat: '', no_telepon: '', email: '', tanggal_daftar: '' })

onMounted(() => loadData())

async function loadData() {
  const res = await getAnggota()
  anggota.value = res.data
}

async function search() {
  if (!searchQuery.value) return loadData()
  const res = await searchAnggota(searchQuery.value)
  anggota.value = res.data
}

function editAnggota(a) {
  editing.value = a.id
  form.value = { nama: a.nama, alamat: a.alamat || '', no_telepon: a.no_telepon || '', email: a.email || '', tanggal_daftar: a.tanggal_daftar || '' }
  showModal.value = true
}

function closeModal() {
  showModal.value = false
  editing.value = null
  form.value = { nama: '', alamat: '', no_telepon: '', email: '', tanggal_daftar: '' }
}

async function handleSave() {
  if (editing.value) {
    await updateAnggota(editing.value, form.value)
  } else {
    await createAnggota(form.value)
  }
  closeModal()
  loadData()
}

async function handleToggleStatus(a) {
  const action = a.status === 'aktif' ? 'Menonaktifkan' : 'Mengaktifkan';
  if (!confirm(`Apakah Anda yakin ingin ${action.toLowerCase()} anggota ini?`)) return
  try {
    await toggleStatusAnggota(a.id)
    loadData()
  } catch (err) {
    alert(err.response?.data?.error || 'Gagal mengubah status status anggota')
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