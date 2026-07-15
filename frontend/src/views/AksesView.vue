<template>
  <div>
    <h2 class="text-2xl font-bold mb-6">Matriks Hak Akses</h2>

    <div class="bg-white rounded shadow p-4 mb-6">
      <h3 class="font-semibold mb-4">Perbandingan Hak Akses</h3>
      <div class="overflow-x-auto">
        <table class="w-full text-sm border">
          <thead>
            <tr class="bg-gray-50">
              <th class="p-3 text-left">Objek Database</th>
              <th class="p-3 text-center bg-blue-50">Administrator</th>
              <th class="p-3 text-center bg-green-50">Petugas Perpustakaan</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="row in accessMatrix" :key="row.objek" class="border-t">
              <td class="p-3 font-medium">{{ row.objek }}</td>
              <td class="p-3 text-center bg-blue-50">
                <span v-for="(v, i) in row.admin" :key="i" :class="v ? 'bg-green-100 text-green-700 px-2 py-0.5 rounded text-xs mr-1' : 'bg-red-100 text-red-700 px-2 py-0.5 rounded text-xs mr-1'">{{ v ? v : '❌' }}</span>
              </td>
              <td class="p-3 text-center bg-green-50">
                <span v-for="(v, i) in row.petugas" :key="i" :class="v ? 'bg-green-100 text-green-700 px-2 py-0.5 rounded text-xs mr-1' : 'bg-red-100 text-red-700 px-2 py-0.5 rounded text-xs mr-1'">{{ v ? v : '❌' }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="bg-white rounded shadow p-4 mb-6">
      <h3 class="font-semibold mb-4">User Database (MySQL)</h3>
      <table class="w-full text-sm">
        <thead><tr class="bg-gray-50 text-left"><th class="p-2">Username</th><th>Password</th><th>Role</th></tr></thead>
        <tbody>
          <tr class="border-t"><td class="p-2">admin_perpus</td><td>Admin123!</td><td>Administrator (ALL PRIVILEGES)</td></tr>
          <tr class="border-t"><td class="p-2">petugas_perpus</td><td>Petugas123!</td><td>Petugas (SELECT, INSERT, UPDATE)</td></tr>
        </tbody>
      </table>
    </div>

    <div class="bg-white rounded shadow p-4">
      <h3 class="font-semibold mb-4">Bukti Perbedaan Hak Akses</h3>
      <div class="space-y-4 text-sm">
        <div class="border-l-4 border-green-500 pl-4">
          <p class="font-medium">✅ Petugas: SELECT, INSERT, UPDATE berhasil</p>
          <code class="block bg-gray-100 p-2 mt-1 rounded">mysql -u petugas_perpus -p<br/>USE perpustakaan_db;<br/>SELECT * FROM anggota; -- OK<br/>INSERT INTO anggota (nama) VALUES ('Test'); -- OK<br/>UPDATE anggota SET nama='Test2' WHERE id=1; -- OK</code>
        </div>
        <div class="border-l-4 border-red-500 pl-4">
          <p class="font-medium">❌ Petugas: DELETE ditolak</p>
          <code class="block bg-gray-100 p-2 mt-1 rounded">DELETE FROM anggota WHERE nama='Test';<br/>-- ERROR: DELETE command denied to user 'petugas_perpus'@'localhost'</code>
        </div>
        <div class="border-l-4 border-red-500 pl-4">
          <p class="font-medium">❌ Petugas: DDL ditolak</p>
          <code class="block bg-gray-100 p-2 mt-1 rounded">DROP TABLE anggota;<br/>-- ERROR: DROP command denied to user 'petugas_perpus'@'localhost'</code>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const accessMatrix = [
  { objek: 'anggota', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'buku', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'kategori_buku', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'peminjaman', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'pengembalian', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'dokumen', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'users', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT'] },
  { objek: 'views (laporan)', admin: ['SELECT'], petugas: ['SELECT'] },
  { objek: 'stored procedures', admin: ['EXECUTE'], petugas: ['EXECUTE'] },
  { objek: 'DDL (CREATE, DROP, ALTER)', admin: ['✅'], petugas: ['❌'] },
  { objek: 'Backup (mysqldump)', admin: ['✅'], petugas: ['❌'] },
]
</script>
