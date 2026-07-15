USE perpustakaan_db;

-- =============================================
-- PERBAIKAN KUALITAS DATA
-- =============================================

-- 1. Hapus Data Anggota Ganda (hapus duplikat, pertahankan id terkecil)
DELETE a2 FROM anggota a1
JOIN anggota a2 ON a1.email = a2.email AND a1.id < a2.id
WHERE a1.email != '' AND a2.email != ''
  AND a1.email IS NOT NULL AND a2.email IS NOT NULL;

-- 2. Update Nama Kosong menjadi 'Tidak Diketahui'
UPDATE anggota
SET nama = 'Tidak Diketahui'
WHERE nama IS NULL OR nama = '';

-- 3. Update Email Kosong menjadi placeholder
UPDATE anggota
SET email = CONCAT('anggota_', id, '@fix.perpustakaan.ac.id')
WHERE email IS NULL OR email = '';

-- 4. Perbaiki Format Email (ganti ' at ' dengan '@')
UPDATE anggota
SET email = REPLACE(email, '_at_', '@')
WHERE email LIKE '%_at_%';

-- 5. Perbaiki Stok Negatif (set ke 0)
UPDATE buku
SET stok = 0
WHERE stok < 0;

-- =============================================
-- LAPORAN KUALITAS DATA - SETELAH PERBAIKAN
-- =============================================

-- Verifikasi: cek apakah masih ada data bermasalah
SELECT 'SETELAH PERBAIKAN - Cek Anggota Ganda' as cek,
       COUNT(*) as jumlah
FROM anggota a1
JOIN anggota a2 ON a1.email = a2.email AND a1.id <> a2.id
UNION ALL
SELECT 'Setelah Perbaikan - Cek Nama Kosong',
       COUNT(*) FROM anggota WHERE nama IS NULL OR nama = ''
UNION ALL
SELECT 'Setelah Perbaikan - Cek Email Invalid',
       COUNT(*) FROM anggota WHERE email NOT LIKE '%@%'
UNION ALL
SELECT 'Setelah Perbaikan - Cek Stok Negatif',
       COUNT(*) FROM buku WHERE stok < 0;
