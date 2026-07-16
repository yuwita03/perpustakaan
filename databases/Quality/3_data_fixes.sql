USE perpustakaan_db;

-- =============================================
-- PERBAIKAN KUALITAS DATA (VERSI HAPUS)
-- =============================================

-- 1. Hapus Data Anggota Ganda (hapus duplikat, pertahankan id terkecil)
DELETE a2 FROM anggota a1
JOIN anggota a2 ON a1.email = a2.email AND a1.id < a2.id
WHERE a1.email != '' AND a2.email != ''
  AND a1.email IS NOT NULL AND a2.email IS NOT NULL;

-- 2. Hapus Data dengan Nama ATAU Email Kosong
DELETE FROM anggota
WHERE nama IS NULL OR nama = ''
   OR email IS NULL OR email = '';

-- 3. Perbaiki Format Email (ganti '_at_' dengan '@')
UPDATE anggota
SET email = REPLACE(email, '_at_', '@')
WHERE email LIKE '%_at_%';

-- 4. Perbaiki Stok Negatif (set ke 0)
UPDATE buku
SET stok = 0
WHERE stok < 0;

-- 5. Hapus Data Buku Ganda (pertahankan id terkecil)
DELETE b2 FROM buku b1
JOIN buku b2 ON b1.judul = b2.judul 
  AND b1.penulis = b2.penulis 
  AND b1.tahun_terbit = b2.tahun_terbit
  AND b1.id < b2.id;

-- =============================================
-- LAPORAN KUALITAS DATA - SETELAH PERBAIKAN
-- =============================================

SELECT 'SETELAH PERBAIKAN - Cek Anggota Ganda' as cek,
       COUNT(*) as jumlah
FROM anggota a1
JOIN anggota a2 ON a1.email = a2.email AND a1.id <> a2.id
UNION ALL
SELECT 'Setelah Perbaikan - Cek Nama/Email Kosong',
       COUNT(*) FROM anggota WHERE nama IS NULL OR nama = '' OR email IS NULL OR email = ''
UNION ALL
SELECT 'Setelah Perbaikan - Cek Email Invalid',
       COUNT(*) FROM anggota WHERE email NOT LIKE '%@%' AND email != ''
UNION ALL
SELECT 'Setelah Perbaikan - Cek Stok Negatif',
       COUNT(*) FROM buku WHERE stok < 0
UNION ALL
SELECT 'Setelah Perbaikan - Cek Buku Ganda',
       COUNT(*) FROM buku b1
       JOIN buku b2 ON b1.judul = b2.judul 
         AND b1.penulis = b2.penulis 
         AND b1.tahun_terbit = b2.tahun_terbit
         AND b1.id <> b2.id;