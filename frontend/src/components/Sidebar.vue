<template>
  <aside class="w-64 bg-blue-900 text-white flex flex-col">
    <div class="p-4 text-lg font-bold border-b border-blue-800">
      📚 Perpustakaan
    </div>
    <nav class="flex-1 p-4 space-y-2">
      <router-link to="/" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        📊 Dashboard
      </router-link>
      <router-link to="/anggota" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        👥 Anggota
      </router-link>
      <router-link to="/buku" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        📖 Buku
      </router-link>
      <router-link to="/transaksi" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        🔄 Transaksi
      </router-link>
      <router-link to="/dokumen" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        📄 Dokumen
      </router-link>
      <router-link to="/laporan" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        📈 Laporan
      </router-link>
      <router-link to="/akses" class="block px-4 py-2 rounded hover:bg-blue-800" active-class="bg-blue-700">
        🔐 Matriks Akses
      </router-link>
    </nav>
    <div class="p-4 text-xs text-blue-300 border-t border-blue-800">
      v1.0 | LSP DBA 2026
    </div>
  </aside>
</template>
