<template>
  <div class="bg-slate-50/50 min-h-screen p-4 md:p-8 font-sans antialiased">
    <!-- Header Page -->
    <div class="mb-8 pb-5 border-b border-slate-200/60">
      <h2 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight">Matriks Hak Akses</h2>
      <p class="text-slate-500 text-sm mt-1">Konfigurasi hak istimewa (privileges) pengguna dan pembatasan operasional pada level basis data perpustakaan.</p>
    </div>

    <!-- Alur Kerja Atas ke Bawah (Top-to-Bottom Layout) -->
    <div class="space-y-8 animate-fade-in">

      <!-- LEVEL 1: Perbandingan Hak Akses Makro -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100 bg-slate-50/50">
          <h3 class="font-bold text-slate-800 text-base">Perbandingan Hak Akses Objek</h3>
          <p class="text-xs text-slate-400 mt-0.5">Pemetaan hak operasional DML, DDL, dan utilitas antara administrator dengan petugas.</p>
        </div>
        <div class="overflow-x-auto max-h-[450px] overflow-y-auto custom-scrollbar">
          <table class="w-full text-sm text-left border-collapse">
            <thead class="sticky top-0 bg-slate-50 z-10 border-b border-slate-200">
              <tr class="text-slate-400 text-xs font-semibold uppercase tracking-wider">
                <th class="py-4 px-6 min-w-[200px]">Objek Database</th>
                <th class="py-4 px-6 text-center bg-blue-50/60 border-x border-slate-200/50 min-w-[250px]">Administrator</th>
                <th class="py-4 px-6 text-center bg-emerald-50/40 min-w-[250px]">Petugas Perpustakaan</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
              <tr v-for="row in updatedAccessMatrix" :key="row.objek" class="hover:bg-slate-50/50 transition-colors">
                <td class="py-4 px-6 font-semibold text-slate-800">{{ row.objek }}</td>
                
                <!-- Kolom Akses Admin -->
                <td class="py-4 px-6 text-center bg-blue-50/30 border-x border-slate-100">
                  <div class="flex flex-wrap gap-1.5 justify-center">
                    <span 
                      v-for="(privilege, idx) in row.admin" 
                      :key="idx" 
                      class="text-xs px-2 py-0.5 rounded font-medium"
                      :class="getBadgeClass(privilege)"
                    >
                      {{ privilege }}
                    </span>
                  </div>
                </td>

                <!-- Kolom Akses Petugas -->
                <td class="py-4 px-6 text-center bg-emerald-50/10">
                  <div class="flex flex-wrap gap-1.5 justify-center">
                    <span 
                      v-for="(privilege, idx) in row.petugas" 
                      :key="idx" 
                      class="text-xs px-2 py-0.5 rounded font-medium"
                      :class="getBadgeClass(privilege)"
                    >
                      {{ privilege }}
                    </span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- LEVEL 2: Informasi Akun Basis Data -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100">
          <h3 class="font-bold text-slate-800 text-base">User Database (MySQL)</h3>
          <p class="text-xs text-slate-400 mt-0.5">Kredensial dan definisi peran global yang terdaftar di sistem DBMS.</p>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full text-sm text-left border-collapse">
            <thead>
              <tr class="bg-slate-50 text-slate-400 text-xs font-semibold uppercase tracking-wider border-b border-slate-200">
                <th class="py-3.5 px-6">Username</th>
                <th class="py-3.5 px-6">Password</th>
                <th class="py-3.5 px-6">Scope / Role Privileges</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100 text-slate-600">
              <tr class="hover:bg-slate-50/50 transition-colors">
                <td class="py-4 px-6 font-mono font-semibold text-slate-900">admin_perpus</td>
                <td class="py-4 px-6 font-mono text-slate-500">Admin123!</td>
                <td class="py-4 px-6">
                  <span class="inline-flex items-center px-2.5 py-0.5 rounded bg-blue-50 text-blue-700 text-xs font-bold uppercase tracking-wider">
                    ALL PRIVILEGES
                  </span>
                </td>
              </tr>
              <tr class="hover:bg-slate-50/50 transition-colors">
                <td class="py-4 px-6 font-mono font-semibold text-slate-900">petugas_perpus</td>
                <td class="py-4 px-6 font-mono text-slate-500">Petugas123!</td>
                <td class="py-4 px-6">
                  <span class="inline-flex items-center px-2.5 py-0.5 rounded bg-emerald-50 text-emerald-700 text-xs font-bold uppercase tracking-wider">
                    SELECT, INSERT, UPDATE
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- LEVEL 3: Bukti dan Validasi Hak Akses (Terminal Log) -->
      <div class="bg-white rounded-2xl border border-slate-200/60 shadow-sm overflow-hidden">
        <div class="p-5 border-b border-slate-100">
          <h3 class="font-bold text-slate-800 text-base">Bukti Eksekusi & Validasi Hak Akses</h3>
          <p class="text-xs text-slate-400 mt-0.5">Pengujian perintah langsung dari klien MySQL untuk membuktikan pembatasan keamanan data.</p>
        </div>
        <div class="p-6 space-y-6">
          
          <!-- Kasus Sukses -->
          <div class="relative pl-5 border-l-2 border-emerald-500">
            <div class="flex items-center gap-2 mb-1.5">
              <span class="text-xs font-bold uppercase tracking-wide px-2 py-0.5 bg-emerald-50 text-emerald-700 rounded border border-emerald-200/40">DIIZINKAN</span>
              <p class="text-sm font-semibold text-slate-800">Petugas: Operasi DML (SELECT, INSERT, UPDATE) Berhasil</p>
            </div>
            <div class="bg-slate-900 rounded-xl p-4 font-mono text-xs text-slate-300 leading-relaxed overflow-x-auto shadow-inner">
              <span class="text-slate-500"># Login dan eksekusi manipulasi data oleh petugas</span><br/>
              mysql -u petugas_perpus -p<br/>
              <span class="text-blue-400">USE</span> perpustakaan_db;<br/>
              <span class="text-blue-400">SELECT</span> * <span class="text-blue-400">FROM</span> anggota; <span class="text-emerald-400">-- Success (Rows returned)</span><br/>
              <span class="text-blue-400">INSERT INTO</span> anggota (nama) <span class="text-blue-400">VALUES</span> (<span class="text-amber-300">'Test'</span>); <span class="text-emerald-400">-- Success (1 row affected)</span><br/>
              <span class="text-blue-400">UPDATE</span> anggota <span class="text-blue-400">SET</span> nama=<span class="text-amber-300">'Test2'</span> <span class="text-blue-400">WHERE</span> id=1; <span class="text-emerald-400">-- Success (1 row affected)</span>
            </div>
          </div>

          <!-- Kasus Ditolak (DELETE) -->
          <div class="relative pl-5 border-l-2 border-rose-500">
            <div class="flex items-center gap-2 mb-1.5">
              <span class="text-xs font-bold uppercase tracking-wide px-2 py-0.5 bg-rose-50 text-rose-700 rounded border border-rose-200/40">DITOLAK</span>
              <p class="text-sm font-semibold text-slate-800">Petugas: Perintah DELETE Dibatasi</p>
            </div>
            <div class="bg-slate-900 rounded-xl p-4 font-mono text-xs text-slate-300 leading-relaxed overflow-x-auto shadow-inner">
              <span class="text-blue-400">DELETE FROM</span> anggota <span class="text-blue-400">WHERE</span> nama=<span class="text-amber-300">'Test'</span>;<br/>
              <span class="text-rose-400">ERROR 1142 (42000): DELETE command denied to user 'petugas_perpus'@'localhost' for table 'anggota'</span>
            </div>
          </div>

          <!-- Kasus Ditolak (DDL) -->
          <div class="relative pl-5 border-l-2 border-rose-500">
            <div class="flex items-center gap-2 mb-1.5">
              <span class="text-xs font-bold uppercase tracking-wide px-2 py-0.5 bg-rose-50 text-rose-700 rounded border border-rose-200/40">DITOLAK</span>
              <p class="text-sm font-semibold text-slate-800">Petugas: Proteksi DDL (Struktur Tabel) Aktif</p>
            </div>
            <div class="bg-slate-900 rounded-xl p-4 font-mono text-xs text-slate-300 leading-relaxed overflow-x-auto shadow-inner">
              <span class="text-blue-400">DROP TABLE</span> anggota;<br/>
              <span class="text-rose-400">ERROR 1142 (42000): DROP command denied to user 'petugas_perpus'@'localhost' for table 'anggota'</span>
            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
// Struktur data dibersihkan dari simbol emoji silang dan centang
const updatedAccessMatrix = [
  { objek: 'anggota', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'buku', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'kategori_buku', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'peminjaman', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'pengembalian', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'dokumen', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT', 'INSERT', 'UPDATE'] },
  { objek: 'users', admin: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], petugas: ['SELECT'] },
  { objek: 'views (laporan)', admin: ['SELECT'], petugas: ['SELECT'] },
  { objek: 'stored procedures', admin: ['EXECUTE'], petugas: ['EXECUTE'] },
  { objek: 'DDL (CREATE, DROP, ALTER)', admin: ['TERSEDIA'], petugas: ['DIBATASI'] },
  { objek: 'Backup (mysqldump)', admin: ['TERSEDIA'], petugas: ['DIBATASI'] },
]

// Fungsi helper untuk menentukan style badge teks secara presisi
function getBadgeClass(privilege) {
  switch (privilege) {
    case 'DIBATASI':
      return 'bg-rose-50 text-rose-700 border border-rose-200/40 font-bold'
    case 'TERSEDIA':
      return 'bg-emerald-50 text-emerald-700 border border-emerald-200/40 font-bold'
    case 'SELECT':
      return 'bg-slate-100 text-slate-700'
    case 'INSERT':
      return 'bg-blue-100 text-blue-700'
    case 'UPDATE':
      return 'bg-amber-100 text-amber-700'
    case 'DELETE':
      return 'bg-rose-100 text-rose-700'
    default:
      return 'bg-purple-100 text-purple-700'
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