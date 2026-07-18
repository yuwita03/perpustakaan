# 📚 Sistem Perpustakaan Kampus

Aplikasi manajemen perpustakaan untuk mengelola data anggota, buku, peminjaman, pengembalian, dan dokumen — dibangun dengan raw SQL (tanpa ORM) supaya query, trigger, dan stored procedure-nya bisa dibaca dan dijelaskan langsung dari kode.

## Fitur

- 📖 Manajemen data anggota, buku, dan kategori buku (CRUD)
- 🔄 Transaksi peminjaman & pengembalian dengan update stok otomatis lewat trigger
- ⚠️ Validasi stok sebelum peminjaman disetujui (stored procedure)
- 📥 Import data anggota dari CSV dengan pengecekan anti-duplikat
- 🧹 Deteksi & perbaikan data kotor (data ganda, kosong, format salah, stok invalid)
- 📄 Metadata dokumen perpustakaan
- 🔐 Role-based access control — di level database (GRANT/REVOKE) dan level aplikasi (session + middleware)
- 📊 Dashboard dengan statistik, grafik buku terpopuler, dan laporan kualitas data live
- 🗂️ Halaman Matriks Hak Akses lengkap dengan bukti pengujian
- 💾 Backup & restore database (mysqldump)

## Tech Stack

**Database:** MySQL (raw SQL — views, stored procedures, triggers, tanpa ORM)
**Backend:** Express.js + mysql2
**Frontend:** Vue 3 (Composition API) + Vite + Tailwind CSS + Chart.js
**Auth:** Session-based (express-session) + bcrypt

## Struktur Proyek

```
perpustakaan/
├── databases/
│   ├── schema.sql
│   ├── seed.sql
│   ├── views.sql
│   ├── procedures.sql
│   ├── triggers.sql
│   ├── grants.sql
│   ├── data_quality_checks.sql
│   ├── data_fixes.sql
│   └── access_matrix.md
├── csv/
│   ├── anggota.csv
│   └── import.cjs
├── src/
│   ├── config/db.js
│   ├── controllers/
│   ├── middleware/
│   ├── routes/
│   ├── app.js
│   └── server.js
├── frontend/
└── .env
```

## Skema Database

Entitas utama: `users`, `anggota`, `kategori_buku`, `buku`, `peminjaman`, `pengembalian`, `dokumen`, `laporan_kualitas_data`.

- Satu kategori punya banyak buku (1:N)
- Satu anggota bisa punya banyak peminjaman (1:N)
- Satu buku bisa muncul di banyak peminjaman (1:N)
- Satu peminjaman punya tepat satu pengembalian (1:1)

Update stok buku sepenuhnya ditangani trigger (`trg_kurangi_stok`, `trg_tambah_stok`), bukan dihitung manual di kode aplikasi — jadi konsisten di manapun data dimasukkan.

## Cara Menjalankan

### 1. Setup Database
```bash
mysql -u root -p -e "CREATE DATABASE perpustakaan_db;"
mysql -u root -p perpustakaan_db < databases/schema.sql
mysql -u root -p perpustakaan_db < databases/seed.sql
mysql -u root -p perpustakaan_db < databases/views.sql
mysql -u root -p perpustakaan_db < databases/procedures.sql
mysql -u root -p perpustakaan_db < databases/triggers.sql
mysql -u root -p perpustakaan_db < databases/grants.sql
```

### 2. Backend
```bash
cd src
npm install
```

Buat `.env`:
```dotenv
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=perpustakaan_db
DB_PORT=3306
```

Jalankan:
```bash
node server.js
```

### 3. Frontend
```bash
cd frontend
npm install
npm run dev
```

### 4. Import Data Anggota dari CSV
```bash
node csv/import.cjs
```

## Akun Demo

| Role | Username/Email | Password |
|---|---|---|
| Administrator | `admin` | *(sesuai seed)* |
| Petugas Perpustakaan | `petugas1` | *(sesuai seed)* |

## Hak Akses

| Objek | Administrator | Petugas Perpustakaan |
|---|---|---|
| Data master & transaksi | Full (CRUD) | SELECT, INSERT, UPDATE |
| Data users | Full (CRUD) | SELECT |
| Views & laporan | SELECT | SELECT |
| Stored procedures | EXECUTE | EXECUTE |
| DDL (CREATE/DROP/ALTER) | ✅ | ❌ |
| Backup database | ✅ | ❌ |

Detail dan bukti pengujian ada di `databases/access_matrix.md` dan halaman Matriks Hak Akses di aplikasi.

## Backup & Restore

```bash
# Backup
mysqldump -u root -p perpustakaan_db > backup_perpustakaan.sql

# Restore
mysql -u root -p perpustakaan_db < backup_perpustakaan.sql
```
