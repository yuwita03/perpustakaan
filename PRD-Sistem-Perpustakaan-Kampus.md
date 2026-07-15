# Product Requirements Document (PRD)
# Sistem Perpustakaan Kampus

**Konteks Proyek**: Proyek ini dibuat untuk memenuhi tugas proyek singkat/kegiatan terstruktur pada Skema Sertifikasi Administrator Basis Data (Database Administrator), Nomor Skema: SKM-2025-60102-19, yang diselenggarakan oleh Lembaga Sertifikasi Profesi (LSP).

---

## 1. Latar Belakang

Perpustakaan kampus saat ini mengelola data anggota, buku, peminjaman, pengembalian, dan dokumen perpustakaan menggunakan beberapa file terpisah yang tidak terintegrasi. Kondisi ini menimbulkan beberapa permasalahan:

- Data anggota dan buku mengalami duplikasi karena tidak ada sumber data tunggal (single source of truth).
- Kesalahan pencatatan stok buku akibat pembaruan data yang tidak konsisten antar file.
- Sulit mengetahui status buku (tersedia/sedang dipinjam) secara real-time.
- Sulit menghasilkan laporan (misalnya laporan peminjaman per periode, buku terpopuler, keterlambatan pengembalian).
- Dokumen pendukung perpustakaan (surat, arsip, laporan) tidak memiliki pencatatan metadata yang terstruktur.

## 2. Tujuan Proyek

Merancang dan membangun basis data serta sistem pendukung untuk Sistem Perpustakaan Kampus yang mampu:

1. Mengelola data anggota dan buku secara terpusat.
2. Mencatat transaksi peminjaman dan pengembalian buku.
3. Mengintegrasikan data anggota dari sumber eksternal (file CSV).
4. Memeriksa dan memperbaiki kualitas data (data ganda, kosong, tidak valid).
5. Mengelola metadata dokumen perpustakaan.
6. Menjalankan operasi basis data menggunakan perintah SQL.
7. Menerapkan kontrol akses basis data berbasis peran (role-based access).

## 3. Target Pengguna

| Peran | Deskripsi |
|---|---|
| **Administrator** | Petugas dengan akses penuh — dapat mengelola seluruh data (anggota, buku, kategori, peminjaman, pengembalian, dokumen, dan akun pengguna sistem). |
| **Petugas Perpustakaan** | Staf operasional harian — dapat mengelola transaksi peminjaman/pengembalian dan melihat data anggota/buku, namun tidak memiliki akses untuk menghapus data master (anggota, buku, kategori). |

Catatan: Anggota perpustakaan (mahasiswa/dosen peminjam buku) **bukan** pengguna langsung sistem ini — sistem ini adalah alat kerja internal bagi Administrator dan Petugas Perpustakaan.

## 4. Ruang Lingkup Fitur

### 4.1 Manajemen Data Master
- Tambah, lihat, ubah, hapus data anggota
- Tambah, lihat, ubah, hapus data buku
- Tambah, lihat, ubah, hapus data kategori buku

### 4.2 Transaksi Peminjaman & Pengembalian
- Mencatat transaksi peminjaman buku oleh anggota, termasuk tanggal pinjam dan tanggal jatuh tempo
- Mencatat transaksi pengembalian buku, termasuk kondisi buku saat dikembalikan
- Pembaruan otomatis status ketersediaan buku (tersedia/dipinjam) setelah transaksi

### 4.3 Integrasi Data (CSV)
- Impor data anggota dari file CSV eksternal ke dalam basis data
- Verifikasi hasil integrasi untuk memastikan tidak terjadi duplikasi data saat impor ulang

### 4.4 Kualitas Data
- Identifikasi data ganda, data kosong, format data yang tidak sesuai, dan nilai stok yang tidak valid
- Perbaikan data yang teridentifikasi bermasalah
- Laporan perbandingan kualitas data sebelum dan sesudah perbaikan

### 4.5 Manajemen Dokumen Perpustakaan
- Penyimpanan metadata dokumen: judul, nama file, jenis file, lokasi file, versi, tanggal unggah
- Menampilkan daftar dokumen beserta metadatanya

### 4.6 Kontrol Akses Basis Data
- Pembuatan akun basis data untuk role Administrator dan Petugas Perpustakaan dengan hak akses berbeda
- Login yang membedakan hak akses sesuai peran
- Demonstrasi/pembuktian bahwa hak akses antar peran benar-benar berbeda (misalnya, satu peran ditolak saat mencoba aksi di luar kewenangannya)

### 4.7 Pencarian dan Pelaporan
- Pencarian data (anggota, buku, transaksi) berdasarkan kriteria tertentu
- Laporan buku yang tersedia dan sedang dipinjam
- Laporan riwayat peminjaman/pengembalian

### 4.8 Backup & Recovery
- Backup basis data secara berkala/manual
- Pengujian proses pemulihan (restore) data dari hasil backup

## 5. Di Luar Ruang Lingkup (Out of Scope)

- Sistem denda keterlambatan pengembalian
- Sistem reservasi/pemesanan buku oleh anggota
- Notifikasi otomatis (email/SMS) kepada anggota
- Portal self-service untuk anggota (anggota tidak login ke sistem ini)
- Integrasi pembayaran
- Deployment ke lingkungan production/publik (sistem berjalan di lingkungan pengujian/lokal)

## 6. Entitas Data Utama

| Entitas | Deskripsi Singkat |
|---|---|
| Anggota | Data peminjam buku (mahasiswa/dosen) |
| Buku | Data koleksi buku perpustakaan |
| Kategori Buku | Klasifikasi/genre buku |
| Peminjaman | Transaksi peminjaman buku oleh anggota |
| Pengembalian | Transaksi pengembalian buku |
| Dokumen | Metadata dokumen/arsip perpustakaan |
| Pengguna Sistem | Akun Administrator dan Petugas Perpustakaan |

## 7. Batasan Teknis (Constraints)

- Basis data menggunakan salah satu dari: MySQL, MariaDB, atau PostgreSQL
- Perancangan basis data menggunakan tools ERD (mis. MySQL Workbench, dbdiagram.io, ER/Studio, atau sejenisnya)
- Pengelolaan basis data menggunakan DBMS terkait beserta tools administrasi (mis. phpMyAdmin) dan tools backup/recovery
- Sistem harus dapat didemonstrasikan langsung (live demo) di hadapan penilai, mencakup: struktur tabel, relasi antar tabel, input data, transaksi, pencarian, impor CSV, perbaikan data, metadata dokumen, login multi-peran, perbedaan hak akses, dan backup basis data

## 7.1 Tech Stack

| Layer | Teknologi | Catatan |
|---|---|---|
| Database | MySQL / MariaDB | Raw SQL murni (DDL, views, stored procedures, triggers) — tanpa ORM, agar kemampuan SQL langsung terlihat dan dapat dibuktikan |
| Backend | Express.js + `mysql2` | Menjalankan query manual ke database, endpoint untuk login, CRUD, import CSV, dan laporan |
| Frontend | Vue 3 (Composition API) + Vite + Tailwind + Chart.js | Dashboard demo untuk menampilkan data, laporan, ERD, dan matriks akses |
| Autentikasi | Login sederhana (role Administrator/Petugas) | Kontrol akses sesungguhnya didemonstrasikan di level database (GRANT/REVOKE), bukan JWT/RBAC kompleks di aplikasi |
| ERD | dbdiagram.io | Perancangan dan export skema ke SQL |
| Administrasi DB | phpMyAdmin / MySQL Workbench | Operasional dan verifikasi manual |
| Backup/Recovery | `mysqldump` | Backup dan pengujian restore basis data |
| Deployment | Lokal (opsional: Express ke Railway, Vue ke Vercel) | Deployment production di luar cakupan wajib DIT |

## 8. Kriteria Keberhasilan

- Seluruh entitas data memiliki relasi yang benar dan konsisten (tidak ada anomali data)
- Proses impor CSV berjalan tanpa menimbulkan duplikasi data
- Data bermasalah (ganda/kosong/tidak valid) dapat ditunjukkan sebelum dan sesudah perbaikan
- Perbedaan hak akses antar peran dapat dibuktikan secara langsung (bukan hanya secara teori)
- Proses backup dan restore basis data berhasil dilakukan dan diverifikasi
- Sistem dapat didemonstrasikan secara utuh sesuai seluruh poin pada bagian Ruang Lingkup Fitur

## 9. Deliverables (Bukti yang Harus Dihasilkan)

1. Dokumen analisis kebutuhan dan permasalahan
2. Entity Relationship Diagram (ERD) dan hasil rancangan basis data
3. Script pembuatan dan pengisian basis data
4. Script serta hasil query SQL
5. File CSV dan hasil integrasi data
6. Laporan kualitas data (sebelum dan sesudah perbaikan)
7. Metadata dan contoh dokumen perpustakaan
8. Matriks serta bukti pengujian hak akses
9. File backup basis data
10. Laporan hasil pengujian dan evaluasi sistem
