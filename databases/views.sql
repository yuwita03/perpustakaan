USE perpustakaan_db;

-- =============================================
-- VIEWS untuk LAPORAN
-- =============================================

-- 1. Buku yang Tersedia (stok > 0 dan tidak semua sedang dipinjam)
CREATE OR REPLACE VIEW v_buku_tersedia AS
SELECT b.id, b.judul, b.penulis, k.nama_kategori, b.penerbit, b.tahun_terbit,
       b.stok,
       (b.stok - IFNULL(dipinjam.total, 0)) as stok_tersedia
FROM buku b
LEFT JOIN kategori_buku k ON b.kategori_id = k.id
LEFT JOIN (
  SELECT buku_id, COUNT(*) as total
  FROM peminjaman
  WHERE status = 'dipinjam'
  GROUP BY buku_id
) dipinjam ON b.id = dipinjam.buku_id
HAVING stok_tersedia > 0;

-- 2. Buku yang Sedang Dipinjam
CREATE OR REPLACE VIEW v_buku_dipinjam AS
SELECT p.id as peminjaman_id, b.id as buku_id, b.judul as judul_buku,
       a.id as anggota_id, a.nama as nama_anggota,
       p.tanggal_pinjam, p.tanggal_jatuh_tempo,
       DATEDIFF(CURDATE(), p.tanggal_jatuh_tempo) as hari_terlambat,
       CASE WHEN p.tanggal_jatuh_tempo < CURDATE() THEN 'Terlambat' ELSE 'Aman' END as status_pinjam
FROM peminjaman p
JOIN buku b ON p.buku_id = b.id
JOIN anggota a ON p.anggota_id = a.id
WHERE p.status = 'dipinjam';

-- 3. Riwayat Peminjaman Lengkap
CREATE OR REPLACE VIEW v_riwayat_peminjaman AS
SELECT p.id as peminjaman_id,
       a.id as anggota_id, a.nama as nama_anggota,
       b.id as buku_id, b.judul as judul_buku,
       p.tanggal_pinjam, p.tanggal_jatuh_tempo,
       p.status,
       pk.tanggal_kembali, pk.kondisi_buku
FROM peminjaman p
JOIN anggota a ON p.anggota_id = a.id
JOIN buku b ON p.buku_id = b.id
LEFT JOIN pengembalian pk ON p.id = pk.peminjaman_id;

-- 4. Buku Terpopuler (berdasarkan jumlah peminjaman)
CREATE OR REPLACE VIEW v_buku_terpopuler AS
SELECT b.id, b.judul, b.penulis, k.nama_kategori,
       COUNT(p.id) as jumlah_dipinjam
FROM buku b
LEFT JOIN kategori_buku k ON b.kategori_id = k.id
LEFT JOIN peminjaman p ON b.id = p.buku_id
GROUP BY b.id, b.judul, b.penulis, k.nama_kategori
ORDER BY jumlah_dipinjam DESC;

-- 5. Statistik Dashboard
CREATE OR REPLACE VIEW v_statistik AS
SELECT
  (SELECT COUNT(*) FROM buku) as total_buku,
  (SELECT COUNT(*) FROM anggota) as total_anggota,
  (SELECT COUNT(*) FROM peminjaman WHERE status = 'dipinjam') as peminjaman_aktif,
  (SELECT COUNT(*) FROM peminjaman) as total_peminjaman,
  (SELECT COUNT(*) FROM pengembalian) as total_pengembalian,
  (SELECT COUNT(*) FROM kategori_buku) as total_kategori,
  (SELECT COUNT(*) FROM dokumen) as total_dokumen,
  (SELECT COUNT(*) FROM users) as total_users;
