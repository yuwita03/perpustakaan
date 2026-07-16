# Demonstrasi Quality Data

Quality Data digunakan untuk memastikan data pada database valid, konsisten, dan sesuai dengan aturan bisnis.

---

## 1. Menambahkan Data Bermasalah (dirty_data.sql)

```sql
SOURCE databases/dirty_data.sql;
```

**Fungsi:**
Menambahkan contoh data yang sengaja dibuat bermasalah.

**Contoh data bermasalah:**

- Email duplikat
- Nama kosong
- Email kosong
- Format email tidak valid
- Stok buku bernilai negatif

**Penjelasan:**

Tahap ini dilakukan untuk mensimulasikan kondisi data yang tidak valid sehingga dapat diuji proses identifikasi dan perbaikannya.

---

## 2. Mengecek Kualitas Data (data_quality_checks.sql)

```sql
SOURCE databases/data_quality_checks.sql;
```

**Fungsi:**
Mendeteksi seluruh data yang bermasalah.

**Yang dicek:**

- Data anggota duplikat
- Nama kosong
- Email kosong
- Format email tidak valid
- Stok buku negatif
- Peminjaman yang terlambat

**Penjelasan:**

Script ini hanya melakukan pengecekan dan menampilkan laporan data yang tidak sesuai tanpa mengubah data.

---

## 3. Memperbaiki Data (data_fixes.sql)

```sql
SOURCE databases/data_fixes.sql;
```

**Fungsi:**
Memperbaiki data yang bermasalah.

**Perbaikan yang dilakukan:**

- Menghapus data anggota duplikat
- Mengisi nama yang kosong
- Mengisi email yang kosong
- Memperbaiki format email
- Mengubah stok negatif menjadi 0

**Penjelasan:**

Script ini melakukan proses pembersihan data agar kembali memenuhi aturan yang telah ditentukan.

---

## 4. Verifikasi Hasil

Refresh halaman **Laporan** pada aplikasi.

atau jalankan

```sql
CALL sp_cek_kualitas_data();
```

**Fungsi:**

Melakukan pengecekan ulang terhadap kondisi database setelah proses perbaikan.

**Penjelasan:**

Stored Procedure akan menghitung kembali jumlah data yang masih bermasalah, kemudian memperbarui tabel `laporan_kualitas_data`.

Apabila seluruh perbaikan berhasil dilakukan, maka nilai **jumlah_sesudah** akan menjadi **0** sehingga status berubah menjadi **Bersih**.

---

# Alur Demonstrasi

```
dirty_data.sql
        │
        ▼
data_quality_checks.sql
        │
        ▼
data_fixes.sql
        │
        ▼
CALL sp_cek_kualitas_data()
atau Refresh Halaman Laporan
        │
        ▼
Laporan Before & After ditampilkan
```

## Hasil yang Diharapkan

| Sebelum | Sesudah |
|----------|----------|
| Data bermasalah terdeteksi | Seluruh data telah diperbaiki |
| jumlah_sebelum > 0 | jumlah_sesudah = 0 |
| Status Bermasalah | Status Bersih |