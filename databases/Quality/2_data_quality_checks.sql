USE perpustakaan_db;

-- =============================================
-- LAPORAN KUALITAS DATA - SEBELUM PERBAIKAN
-- =============================================

-- 1. Data Anggota Ganda (duplikat berdasarkan email)
SELECT 'ANGGOTA GANDA' as masalah, a1.id, a1.nama, a1.email
FROM anggota a1
JOIN anggota a2 ON a1.email = a2.email AND a1.id <> a2.id
WHERE a1.email != '' AND a1.email IS NOT NULL;

-- 2. Data Anggota dengan Nama Kosong
SELECT 'NAMA KOSONG' as masalah, id, nama, email
FROM anggota
WHERE nama IS NULL OR nama = '';

-- 3. Data Anggota dengan Email Kosong
SELECT 'EMAIL KOSONG' as masalah, id, nama, email
FROM anggota
WHERE email IS NULL OR email = '';

-- 4. Format Email Tidak Valid (tidak mengandung '@')
SELECT 'EMAIL TIDAK VALID' as masalah, id, nama, email
FROM anggota
WHERE email NOT LIKE '%@%' AND email != '' AND email IS NOT NULL;

-- 5. Stok Buku Tidak Valid (negatif)
SELECT 'STOK NEGATIF' as masalah, id, judul, stok
FROM buku
WHERE stok < 0;

-- 6. Peminjaman Tanpa Pengembalian (sudah lewat jatuh tempo)
SELECT 'TERLAMBAT' as masalah, p.id, a.nama as anggota, b.judul as buku,
       p.tanggal_pinjam, p.tanggal_jatuh_tempo,
       DATEDIFF(CURDATE(), p.tanggal_jatuh_tempo) as hari_terlambat
FROM peminjaman p
JOIN anggota a ON p.anggota_id = a.id
JOIN buku b ON p.buku_id = b.id
WHERE p.status = 'dipinjam' AND p.tanggal_jatuh_tempo < CURDATE();

UNION ALL
SELECT 'RINGKASAN',
       COUNT(*),
       'Buku dengan data ganda'
FROM (
  SELECT b1.id FROM buku b1
  JOIN buku b2 ON b1.judul = b2.judul 
    AND b1.penulis = b2.penulis 
    AND b1.tahun_terbit = b2.tahun_terbit
    AND b1.id <> b2.id
) AS buku_ganda;

-- 8. Data Buku Ganda (duplikat berdasarkan judul + penulis + penerbit + tahun)
SELECT 'BUKU GANDA' as masalah, b1.id, b1.judul, b1.penulis, b1.tahun_terbit
FROM buku b1
JOIN buku b2 ON b1.judul = b2.judul 
  AND b1.penulis = b2.penulis 
  AND b1.tahun_terbit = b2.tahun_terbit
  AND b1.id <> b2.id;