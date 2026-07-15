<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold">Data Buku</h2>
      <button @click="showModal = true" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">+ Tambah</button>
    </div>

    <div class="mb-4">
      <input v-model="searchQuery" @input="search" placeholder="Cari buku..." class="border rounded px-3 py-2 w-full max-w-md" />
    </div>

    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full text-sm">
        <thead><tr class="bg-gray-50 text-left"><th class="p-3">ID</th><th>Judul</th><th>Penulis</th><th>Kategori</th><th>Penerbit</th><th>Tahun</th><th>Stok</th><th>Aksi</th></tr></thead>
        <tbody>
          <tr v-for="b in buku" :key="b.id" class="border-t">
            <td class="p-3">{{ b.id }}</td>
            <td>{{ b.judul }}</td>
            <td>{{ b.penulis || '-' }}</td>
            <td>{{ b.nama_kategori || '-' }}</td>
            <td>{{ b.penerbit || '-' }}</td>
            <td>{{ b.tahun_terbit || '-' }}</td>
            <td>{{ b.stok }}</td>
            <td>
              <button @click="editBuku(b)" class="text-blue-600 hover:underline mr-2">Edit</button>
              <button @click="handleDelete(b.id)" class="text-red-600 hover:underline">Hapus</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div v-if="showModal" class="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-lg font-bold mb-4">{{ editing ? 'Edit' : 'Tambah' }} Buku</h3>
        <form @submit.prevent="handleSave">
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Judul *</label><input v-model="form.judul" class="w-full border rounded px-3 py-2" required /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Penulis</label><input v-model="form.penulis" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Kategori</label>
            <select v-model="form.kategori_id" class="w-full border rounded px-3 py-2">
              <option value="">-- Pilih --</option>
              <option v-for="k in kategori" :key="k.id" :value="k.id">{{ k.nama_kategori }}</option>
            </select>
          </div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Penerbit</label><input v-model="form.penerbit" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Tahun Terbit</label><input v-model="form.tahun_terbit" type="number" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-4"><label class="block text-sm font-medium mb-1">Stok</label><input v-model="form.stok" type="number" class="w-full border rounded px-3 py-2" /></div>
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
import { getBuku, createBuku, updateBuku, deleteBuku, searchBuku, getKategori, createKategori } from '../api'

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
  if (!confirm('Yakin hapus?')) return
  try { await deleteBuku(id); loadData() }
  catch (err) { alert(err.response?.data?.error || 'Gagal menghapus') }
}
</script>
