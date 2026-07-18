USE perpustakaan_db;

-- =====================================================
-- PERBAIKAN KUALITAS DATA (DATA CLEANSING)
-- =====================================================

-- 1. Hapus Data Anggota Ganda
-- Mempertahankan data dengan ID terkecil

DELETE a2
FROM anggota a1
JOIN anggota a2
    ON a1.email = a2.email
   AND a1.id < a2.id
WHERE a1.email IS NOT NULL
  AND a2.email IS NOT NULL
  AND a1.email <> ''
  AND a2.email <> '';

-- =====================================================

-- 2. Hapus Data Anggota dengan Nama atau Email Kosong

DELETE FROM anggota
WHERE nama IS NULL
   OR nama = ''
   OR email IS NULL
   OR email = '';

-- =====================================================

-- 3. Perbaiki Format Email
-- Mengubah "_at_" menjadi "@"

UPDATE anggota
SET email = REPLACE(email, '_at_', '@')
WHERE email LIKE '%_at_%';

-- =====================================================

-- 4. Perbaiki Nomor Telepon Tidak Valid
-- Mengosongkan nomor telepon yang tidak memenuhi aturan

UPDATE anggota
SET no_telepon = NULL
WHERE no_telepon IS NOT NULL
  AND (
        LENGTH(no_telepon) < 10
        OR LENGTH(no_telepon) > 15
      );

-- =====================================================

-- 5. Perbaiki Stok Buku Negatif

UPDATE buku
SET stok = 0
WHERE stok < 0;

-- =====================================================

-- 6. Perbaiki Tahun Terbit Tidak Valid
-- Mengubah menjadi tahun berjalan

UPDATE buku
SET tahun_terbit = YEAR(CURDATE())
WHERE tahun_terbit > YEAR(CURDATE());

-- =====================================================

-- 7. Hapus Data Buku Ganda
-- Mempertahankan data dengan ID terkecil

DELETE b2
FROM buku b1
JOIN buku b2
    ON b1.judul = b2.judul
   AND b1.penulis = b2.penulis
   AND b1.penerbit = b2.penerbit
   AND b1.tahun_terbit = b2.tahun_terbit
   AND b1.id < b2.id;

-- =====================================================

SELECT 'PROSES DATA CLEANSING BERHASIL' AS status;