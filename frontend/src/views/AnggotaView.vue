<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold">Data Anggota</h2>
      <button @click="showModal = true" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">+ Tambah</button>
    </div>

    <div class="mb-4">
      <input v-model="searchQuery" @input="search" placeholder="Cari anggota..." class="border rounded px-3 py-2 w-full max-w-md" />
    </div>

    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full text-sm">
        <thead><tr class="bg-gray-50 text-left"><th class="p-3">ID</th><th>Nama</th><th>Alamat</th><th>Telepon</th><th>Email</th><th>Tgl Daftar</th><th>Status</th><th>Aksi</th></tr></thead>
        <tbody>
          <tr v-for="a in anggota" :key="a.id" class="border-t" :class="a.status === 'nonaktif' ? 'opacity-50' : ''">
            <td class="p-3">{{ a.id }}</td>
            <td>{{ a.nama }}</td>
            <td>{{ a.alamat || '-' }}</td>
            <td>{{ a.no_telepon || '-' }}</td>
            <td>{{ a.email || '-' }}</td>
            <td>{{ a.tanggal_daftar || '-' }}</td>
            <td><span :class="a.status === 'aktif' ? 'text-green-600' : 'text-red-600'">{{ a.status || 'aktif' }}</span></td>
            <td>
              <button v-if="a.status === 'aktif'" @click="editAnggota(a)" class="text-blue-600 hover:underline mr-2">Edit</button>
              <span v-else class="text-gray-400 mr-2">Tidak bisa diedit</span>
              <button @click="handleToggleStatus(a)" :class="a.status === 'nonaktif' ? 'text-green-600 hover:underline' : 'text-red-600 hover:underline'">{{ a.status === 'nonaktif' ? 'Aktifkan' : 'Nonaktifkan' }}</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-lg font-bold mb-4">{{ editing ? 'Edit' : 'Tambah' }} Anggota</h3>
        <form @submit.prevent="handleSave">
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Nama *</label><input v-model="form.nama" class="w-full border rounded px-3 py-2" required /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Alamat</label><input v-model="form.alamat" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Telepon</label><input v-model="form.no_telepon" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Email</label><input v-model="form.email" type="email" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-4"><label class="block text-sm font-medium mb-1">Tgl Daftar</label><input v-model="form.tanggal_daftar" type="date" class="w-full border rounded px-3 py-2" /></div>
          <div class="flex justify-end gap-3">
            <button type="button" @click="closeModal" class="px-4 py-2 border rounded">Batal</button>
            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Simpan</button>
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
  const action = a.status === 'aktif' ? 'Nonaktifkan' : 'Aktifkan';
  if (!confirm(`${action} anggota ini?`)) return
  try {
    await toggleStatusAnggota(a.id)
    loadData()
  } catch (err) {
    alert(err.response?.data?.error || 'Gagal mengubah status')
  }
}
</script>
