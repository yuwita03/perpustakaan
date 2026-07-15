<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold">Manajemen Dokumen</h2>
      <button @click="showModal = true" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">+ Tambah</button>
    </div>

    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full text-sm">
        <thead><tr class="bg-gray-50 text-left"><th class="p-3">ID</th><th>Judul</th><th>Nama File</th><th>Jenis</th><th>Lokasi</th><th>Versi</th><th>Diupload Oleh</th><th>Tgl Upload</th><th>Aksi</th></tr></thead>
        <tbody>
          <tr v-for="d in dokumen" :key="d.id" class="border-t">
            <td class="p-3">{{ d.id }}</td>
            <td>{{ d.judul }}</td>
            <td>{{ d.nama_file }}</td>
            <td>{{ d.jenis_file || '-' }}</td>
            <td class="max-w-xs truncate">{{ d.lokasi_file || '-' }}</td>
            <td>{{ d.versi || '-' }}</td>
            <td>{{ d.uploaded_by_name || '-' }}</td>
            <td>{{ new Date(d.tanggal_unggah).toLocaleDateString('id-ID') }}</td>
            <td>
              <button @click="handleDelete(d.id)" class="text-red-600 hover:underline">Hapus</button>
            </td>
          </tr>
        </tbody>
      </table>
      <p v-if="dokumen.length === 0" class="p-4 text-gray-400 text-center">Belum ada dokumen</p>
    </div>

    <div v-if="showModal" class="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-lg font-bold mb-4">Tambah Dokumen</h3>
        <form @submit.prevent="handleSave">
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Judul *</label><input v-model="form.judul" class="w-full border rounded px-3 py-2" required /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Nama File *</label><input v-model="form.nama_file" class="w-full border rounded px-3 py-2" required /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Jenis File</label><input v-model="form.jenis_file" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-3"><label class="block text-sm font-medium mb-1">Lokasi File</label><input v-model="form.lokasi_file" class="w-full border rounded px-3 py-2" /></div>
          <div class="mb-4"><label class="block text-sm font-medium mb-1">Versi</label><input v-model="form.versi" class="w-full border rounded px-3 py-2" /></div>
          <div class="flex justify-end gap-3">
            <button type="button" @click="showModal = false" class="px-4 py-2 border rounded">Batal</button>
            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Simpan</button>
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
  await createDokumen(form.value)
  showModal.value = false
  form.value = { judul: '', nama_file: '', jenis_file: '', lokasi_file: '', versi: '' }
  loadData()
}

async function handleDelete(id) {
  if (!confirm('Yakin hapus dokumen ini?')) return
  await deleteDokumen(id)
  loadData()
}
</script>
