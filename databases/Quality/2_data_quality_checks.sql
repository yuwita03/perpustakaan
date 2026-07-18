USE perpustakaan_db;

-- =====================================================
-- RINGKASAN HASIL QUALITY CHECK
-- =====================================================

SELECT
    'Anggota Ganda' AS pemeriksaan,
    (
        SELECT COUNT(*)
        FROM anggota a1
        JOIN anggota a2
            ON a1.email = a2.email
           AND a1.id < a2.id
        WHERE a1.email IS NOT NULL
          AND a1.email <> ''
    ) AS jumlah

UNION ALL

SELECT
    'Nama Kosong',
    (
        SELECT COUNT(*)
        FROM anggota
        WHERE nama IS NULL
           OR nama = ''
    )

UNION ALL

SELECT
    'Email Kosong',
    (
        SELECT COUNT(*)
        FROM anggota
        WHERE email IS NULL
           OR email = ''
    )

UNION ALL

SELECT
    'Email Tidak Valid',
    (
        SELECT COUNT(*)
        FROM anggota
        WHERE email IS NOT NULL
          AND email <> ''
          AND email NOT LIKE '%@%'
    )

UNION ALL

SELECT
    'Stok Buku Negatif',
    (
        SELECT COUNT(*)
        FROM buku
        WHERE stok < 0
    )

UNION ALL

SELECT
    'Tahun Terbit Tidak Valid',
    (
        SELECT COUNT(*)
        FROM buku
        WHERE tahun_terbit > YEAR(CURDATE())
    )

UNION ALL

SELECT
    'Buku Ganda',
    (
        SELECT COUNT(*)
        FROM buku b1
        JOIN buku b2
            ON b1.judul = b2.judul
           AND b1.penulis = b2.penulis
           AND b1.tahun_terbit = b2.tahun_terbit
           AND b1.id < b2.id
    );

-- =====================================================
-- DETAIL DATA ANGGOTA GANDA
-- =====================================================

SELECT 'DETAIL DATA ANGGOTA GANDA' AS informasi;

SELECT
    a1.id,
    a1.nama,
    a1.email
FROM anggota a1
JOIN anggota a2
    ON a1.email = a2.email
   AND a1.id < a2.id
WHERE a1.email IS NOT NULL
  AND a1.email <> '';

-- =====================================================
-- DETAIL DATA NAMA KOSONG
-- =====================================================

SELECT 'DETAIL DATA NAMA KOSONG' AS informasi;

SELECT
    id,
    nama,
    email
FROM anggota
WHERE nama IS NULL
   OR nama = '';

-- =====================================================
-- DETAIL DATA EMAIL KOSONG
-- =====================================================

SELECT 'DETAIL DATA EMAIL KOSONG' AS informasi;

SELECT
    id,
    nama,
    email
FROM anggota
WHERE email IS NULL
   OR email = '';

-- =====================================================
-- DETAIL DATA EMAIL TIDAK VALID
-- =====================================================

SELECT 'DETAIL DATA EMAIL TIDAK VALID' AS informasi;

SELECT
    id,
    nama,
    email
FROM anggota
WHERE email IS NOT NULL
  AND email <> ''
  AND email NOT LIKE '%@%';

-- =====================================================
-- DETAIL DATA NOMOR TELEPON TIDAK VALID
-- =====================================================

SELECT 'DETAIL DATA NOMOR TELEPON TIDAK VALID' AS informasi;

SELECT
    id,
    nama,
    no_telepon
FROM anggota
WHERE no_telepon IS NOT NULL
  AND (
        LENGTH(no_telepon) < 10
        OR LENGTH(no_telepon) > 15
      );

-- =====================================================
-- DETAIL DATA STOK NEGATIF
-- =====================================================

SELECT 'DETAIL DATA STOK NEGATIF' AS informasi;

SELECT
    id,
    judul,
    stok
FROM buku
WHERE stok < 0;

-- =====================================================
-- DETAIL DATA TAHUN TERBIT TIDAK VALID
-- =====================================================

SELECT 'DETAIL DATA TAHUN TERBIT TIDAK VALID' AS informasi;

SELECT
    id,
    judul,
    tahun_terbit
FROM buku
WHERE tahun_terbit > YEAR(CURDATE());

-- =====================================================
-- DETAIL DATA BUKU GANDA
-- =====================================================

SELECT 'DETAIL DATA BUKU GANDA' AS informasi;

SELECT
    b1.id,
    b1.judul,
    b1.penulis,
    b1.tahun_terbit
FROM buku b1
JOIN buku b2
    ON b1.judul = b2.judul
   AND b1.penulis = b2.penulis
   AND b1.tahun_terbit = b2.tahun_terbit
   AND b1.id < b2.id;