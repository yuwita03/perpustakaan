USE perpustakaan_db;

DELIMITER //

-- =============================================
-- STORED PROCEDURES
-- =============================================

-- 1. Tambah Peminjaman + Update Status Buku
DROP PROCEDURE IF EXISTS sp_tambah_peminjaman;
CREATE PROCEDURE sp_tambah_peminjaman(
  IN p_anggota_id INT,
  IN p_buku_id INT,
  IN p_tanggal_pinjam DATE,
  IN p_tanggal_jatuh_tempo DATE
)
BEGIN
  DECLARE stok_tersedia INT;

  -- Cek stok
  SELECT stok INTO stok_tersedia FROM buku WHERE id = p_buku_id;
  IF stok_tersedia <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok buku tidak tersedia';
  END IF;

  -- Insert peminjaman
  INSERT INTO peminjaman (anggota_id, buku_id, tanggal_pinjam, tanggal_jatuh_tempo, status)
  VALUES (p_anggota_id, p_buku_id, p_tanggal_pinjam, p_tanggal_jatuh_tempo, 'dipinjam');

  SELECT LAST_INSERT_ID() as peminjaman_id;
END //

-- 2. Tambah Pengembalian + Update Status
DROP PROCEDURE IF EXISTS sp_tambah_pengembalian;
CREATE PROCEDURE sp_tambah_pengembalian(
  IN p_peminjaman_id INT,
  IN p_tanggal_kembali DATE,
  IN p_kondisi_buku ENUM('baik', 'rusak', 'hilang')
)
BEGIN
  -- Insert pengembalian
  INSERT INTO pengembalian (peminjaman_id, tanggal_kembali, kondisi_buku)
  VALUES (p_peminjaman_id, p_tanggal_kembali, p_kondisi_buku);

  -- Update status peminjaman
  UPDATE peminjaman
  SET status = 'dikembalikan'
  WHERE id = p_peminjaman_id;
END //

-- 3. Cari Anggota (by nama, email, no_telepon)
DROP PROCEDURE IF EXISTS sp_cari_anggota;
CREATE PROCEDURE sp_cari_anggota(
  IN p_keyword VARCHAR(100)
)
BEGIN
  SELECT * FROM anggota
  WHERE nama LIKE CONCAT('%', p_keyword, '%')
     OR email LIKE CONCAT('%', p_keyword, '%')
     OR no_telepon LIKE CONCAT('%', p_keyword, '%');
END //

-- 4. Cari Buku (by judul, penulis, kategori)
DROP PROCEDURE IF EXISTS sp_cari_buku;
CREATE PROCEDURE sp_cari_buku(
  IN p_keyword VARCHAR(100)
)
BEGIN
  SELECT b.*, k.nama_kategori
  FROM buku b
  LEFT JOIN kategori_buku k ON b.kategori_id = k.id
  WHERE b.judul LIKE CONCAT('%', p_keyword, '%')
     OR b.penulis LIKE CONCAT('%', p_keyword, '%')
     OR k.nama_kategori LIKE CONCAT('%', p_keyword, '%');
END //

-- 5. Laporan Peminjaman per Periode
DROP PROCEDURE IF EXISTS sp_laporan_peminjaman;
CREATE PROCEDURE sp_laporan_peminjaman(
  IN p_tanggal_mulai DATE,
  IN p_tanggal_selesai DATE
)
BEGIN
  SELECT p.id, a.nama as anggota, b.judul as buku,
         p.tanggal_pinjam, p.tanggal_jatuh_tempo, p.status,
         pk.tanggal_kembali, pk.kondisi_buku
  FROM peminjaman p
  JOIN anggota a ON p.anggota_id = a.id
  JOIN buku b ON p.buku_id = b.id
  LEFT JOIN pengembalian pk ON p.id = pk.peminjaman_id
  WHERE p.tanggal_pinjam BETWEEN p_tanggal_mulai AND p_tanggal_selesai;
END //

DELIMITER ;
