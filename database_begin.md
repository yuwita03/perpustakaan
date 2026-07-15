# Persiapan Database

## 1. schema.sql

```sql
SOURCE databases/schema.sql;
```

**Fungsi:**
- Membuat database.
- Membuat seluruh tabel.
- Membuat relasi (Foreign Key).

**Penjelasan:**
File ini merupakan dasar dari database. Semua struktur tabel dibuat di sini.

---

## 2. seed.sql

```sql
SOURCE databases/seed.sql;
```

**Fungsi:**
- Mengisi data awal.

**Penjelasan:**
Digunakan agar aplikasi langsung memiliki data contoh seperti user, anggota, buku, dan peminjaman.

---

## 3. views.sql

```sql
SOURCE databases/views.sql;
```

**Fungsi:**
- Membuat View.

**Penjelasan:**
View digunakan untuk mempermudah pembuatan laporan tanpa harus menulis query yang panjang berulang kali.

---

## 4. triggers.sql

```sql
SOURCE databases/triggers.sql;
```

**Fungsi:**
- Membuat Trigger.

**Penjelasan:**
Trigger akan berjalan otomatis ketika terjadi perubahan data, misalnya saat buku dipinjam atau dikembalikan.

---

## 5. procedures.sql

```sql
SOURCE databases/procedures.sql;
```

**Fungsi:**
- Membuat Stored Procedure.

**Penjelasan:**
Stored Procedure menyimpan logika bisnis di dalam database, seperti pencarian data, laporan, dan proses peminjaman.

---

## 6. grants.sql

```sql
SOURCE databases/grants.sql;
```

**Fungsi:**
- Mengatur hak akses pengguna database.

**Penjelasan:**
Administrator memiliki akses penuh, sedangkan Petugas hanya dapat melihat, menambah, dan mengubah data tanpa menghapus data.

---

# Database Siap Digunakan

Setelah seluruh file di atas dijalankan, database sudah memiliki:

- Struktur tabel
- Data awal
- View
- Trigger
- Stored Procedure
- Hak akses pengguna

Database siap digunakan oleh aplikasi backend dan frontend.