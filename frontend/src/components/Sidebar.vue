<template>
  <aside class="w-64 bg-slate-950 text-slate-200 flex flex-col border-r border-slate-800/60 relative">
    
    <!-- Header/Brand Logo Area -->
    <div class="p-6 border-b border-slate-800/60 flex flex-col gap-1">
      <div class="flex items-center gap-2">
        <div class="h-2.5 w-2.5 rounded-full bg-blue-500 shadow-[0_0_10px_rgba(59,130,246,0.5)] animate-pulse"></div>
        <span class="text-base font-extrabold tracking-wider text-white uppercase font-mono">LSP-LIB APP</span>
      </div>
      <span class="text-[10px] text-slate-500 font-medium tracking-normal">Sistem Manajemen Perpustakaan</span>
    </div>
    
    <!-- Kontainer Navigasi Utama -->
    <nav class="flex-1 p-4 space-y-6 overflow-y-auto custom-sidebar-scroll">
      
      <!-- Grup 1: Navigasi Utama -->
      <div class="space-y-1">
        <span class="block px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Core System</span>
        
        <!-- Menggunakan exact-active-class agar tidak selalu terpilih saat membuka rute lain -->
        <router-link 
          to="/" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          exact-active-class="active-menu"
        >
          <span class="relative z-10">Dashboard Utama</span>
          <span class="text-[11px] font-mono opacity-0 group-hover:opacity-60 transition-opacity">/</span>
        </router-link>
      </div>

      <!-- Grup 2: Master Data & Administrasi -->
      <div class="space-y-1">
        <span class="block px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Manajemen Data</span>
        
        <router-link 
          to="/anggota" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Data Anggota</span>
        </router-link>
        
        <router-link 
          to="/buku" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Katalog Buku</span>
        </router-link>
      </div>

      <!-- Grup 3: Aktivitas & Regulasi -->
      <div class="space-y-1">
        <span class="block px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Sirkulasi & Log</span>
        
        <router-link 
          to="/transaksi" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Transaksi Pinjam</span>
        </router-link>
        
        <router-link 
          to="/dokumen" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Arsip Dokumen</span>
        </router-link>
      </div>

      <!-- Grup 4: Konfigurasi Keamanan -->
      <div class="space-y-1">
        <span class="block px-4 text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-2">Pelaporan & Hak</span>
        
        <router-link 
          to="/laporan" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Analisis Laporan</span>
        </router-link>
        
        <router-link 
          to="/akses" 
          class="sidebar-link group flex items-center justify-between px-4 py-2.5 text-sm font-medium rounded-xl text-slate-400 hover:text-white hover:bg-slate-900/80 relative overflow-hidden" 
          active-class="active-menu"
        >
          <span class="relative z-10">Matriks Hak Akses</span>
        </router-link>
      </div>
    </nav>
    
    <!-- Footer Khusus -->
    <div class="p-4 border-t border-slate-900 bg-slate-950 flex flex-col gap-1 items-center justify-center">
      <div class="text-[10px] text-slate-600 font-mono tracking-wider">LSP ENGINE v1.0</div>
      <div class="text-[9px] text-slate-700 font-sans font-medium">Production Environment @ 2026</div>
    </div>
  </aside>
</template>

<script setup>
// Komponen navigasi terstruktur dengan optimasi transisi rute Vue Router
</script>

<style scoped>
/* State dasar link: border transparan disiapkan sejak awal untuk menghindari layout shifting */
.sidebar-link {
  border: 1px solid transparent;
  transition: background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease;
}

/* Desain khusus saat menu aktif terpilih (baik via active-class maupun exact-active-class) */
.active-menu {
  background-color: rgb(15 23 42 / 0.6) !important;
  color: #ffffff !important;
  font-weight: 600 !important;
  border-color: rgba(59, 130, 246, 0.2) !important;
  box-shadow: inset 0 1px 1px 0 rgba(255, 255, 255, 0.05);
}

/* Garis bar biru vertikal sebagai indikator penanda halaman aktif */
.active-menu::before {
  content: '';
  position: absolute;
  left: 0;
  top: 25%;
  height: 50%;
  width: 3px;
  background-color: #3b82f6;
  border-radius: 0 4px 4px 0;
  box-shadow: 0 0 8px #3b82f6;
}

/* Penyesuaian scrollbar internal agar serasi dengan skema warna gelap */
.custom-sidebar-scroll::-webkit-scrollbar {
  width: 4px;
}
.custom-sidebar-scroll::-webkit-scrollbar-track {
  background: transparent;
}
.custom-sidebar-scroll::-webkit-scrollbar-thumb {
  background: #1e293b;
  border-radius: 10px;
}
.custom-sidebar-scroll::-webkit-scrollbar-thumb:hover {
  background: #334155;
}
</style>