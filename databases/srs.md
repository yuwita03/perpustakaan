# Software Requirements Specification (SRS)
# Sistem Perpustakaan Kampus

## 1. Pendahuluan
Dokumen ini menjabarkan kebutuhan teknis per modul dan pemetaan ke 7 unit kompetensi Skema Sertifikasi Database Administrator LSP.

## 2. Pemetaan Unit Kompetensi

| No | Kode Unit | Judul Unit Kompetensi | Modul Terkait |
|----|-----------|----------------------|---------------|
| 1 | J.62DMS00.006.1 | Mendesain Basis Data | Modul 1 (Manajemen Data Master — perancangan tabel & relasi) |
| 2 | J.62DMS00.010.1 | Membuat Basis Data | Modul 1 (Manajemen Data Master — DDL, pembuatan tabel, seed data) |
| 3 | J.62DMS00.011.1 | Membuat Integrasi Data | Modul 3 (Integrasi CSV — import data anggota, verifikasi duplikat) |
| 4 | J.62DMS00.012.1 | Mengelola Kualitas Data | Modul 4 (Kualitas Data — identifikasi & perbaikan data bermasalah) |
| 5 | J.62DMS00.016.1 | Mengelola Dokumen dan Konten | Modul 5 (Manajemen Dokumen — metadata dokumen perpustakaan) |
| 6 | J.620100.020.02 | Menggunakan SQL | Modul 2 & 7 (Transaksi & Laporan — views, SP, triggers, query SQL) |
| 7 | J.620100.021.02 | Menerapkan Akses Basis Data | Modul 6 (Kontrol Akses — GRANT/REVOKE, login multi-role, matriks akses) |

## 3. Spesifikasi Fungsional per Modul

### Modul 1: Manajemen Data Master (Anggota, Buku, Kategori)
- CRUD anggota, buku, kategori_buku
- Validasi input: email format, stok >= 0, tahun terbit 4 digit
- Pencarian berdasarkan nama/judul/penulis/kategori

### Modul 2: Transaksi Peminjaman & Pengembalian
- Insert peminjaman → otomatis update status buku menjadi 'dipinjam'
- Insert pengembalian → otomatis update status peminjaman & buku
- Trigger: stok buku berkurang saat peminjaman, bertambah saat pengembalian (kondisi baik)

### Modul 3: Integrasi CSV
- Upload file CSV anggota
- Parse dan insert ke tabel anggota
- Cek duplikat berdasarkan email (jika email sudah ada, skip atau update)

### Modul 4: Kualitas Data
- Identifikasi: data ganda, data kosong, format email invalid, stok negatif
- Laporan before/after

### Modul 5: Manajemen Dokumen
- CRUD metadata dokumen (judul, nama_file, jenis_file, lokasi_file, versi, tanggal_unggah, uploaded_by)

### Modul 6: Kontrol Akses
- Login: username + password (bcrypt)
- Session: role disimpan di session
- Middleware: cek role sebelum akses endpoint
- Database: user dibuat dengan GRANT terbatas

### Modul 7: Laporan & Pencarian
- Laporan buku tersedia/dipinjam (view)
- Riwayat peminjaman per anggota
- Buku terpopuler (agregasi)
- Keterlambatan pengembalian

## 4. Spesifikasi Non-Fungsional

| Aspek | Spesifikasi |
|-------|-------------|
| Database | MySQL 8.4.3 |
| Backend Runtime | Node.js + Express 5 |
| Frontend Runtime | Vue 3 + Vite |
| Koneksi DB | mysql2 (pool connection) |
| Autentikasi | Session-based (express-session) |
| Password Hashing | bcrypt |
| CSS Framework | Tailwind CSS 3 |
| Chart | Chart.js via vue-chartjs |
| HTTP Client | Axios |
