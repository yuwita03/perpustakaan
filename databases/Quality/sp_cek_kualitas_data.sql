USE perpustakaan_db;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_cek_kualitas_data;
CREATE PROCEDURE sp_cek_kualitas_data()
BEGIN
  DECLARE v_duplikat INT DEFAULT 0;
  DECLARE v_nama_kosong INT DEFAULT 0;
  DECLARE v_email_kosong INT DEFAULT 0;
  DECLARE v_email_invalid INT DEFAULT 0;
  DECLARE v_stok_negatif INT DEFAULT 0;

  SELECT COUNT(*) INTO v_duplikat FROM anggota a1
  JOIN anggota a2 ON a1.email = a2.email AND a1.id <> a2.id
  WHERE a1.email != '' AND a1.email IS NOT NULL;

  SELECT COUNT(*) INTO v_nama_kosong FROM anggota WHERE nama IS NULL OR nama = '' OR nama = 'Tidak Diketahui';

  SELECT COUNT(*) INTO v_email_kosong FROM anggota WHERE email IS NULL OR email = '' OR email LIKE '%fix.perpustakaan%';

  SELECT COUNT(*) INTO v_email_invalid FROM anggota WHERE email NOT LIKE '%@%' AND email != '' AND email IS NOT NULL;

  SELECT COUNT(*) INTO v_stok_negatif FROM buku WHERE stok < 0;

  UPDATE laporan_kualitas_data SET jumlah_sesudah = v_duplikat, tanggal_pengecekan = NOW() WHERE jenis_masalah LIKE '%duplikat%';
  UPDATE laporan_kualitas_data SET jumlah_sesudah = v_nama_kosong, tanggal_pengecekan = NOW() WHERE jenis_masalah LIKE '%Nama%kosong%';
  UPDATE laporan_kualitas_data SET jumlah_sesudah = v_email_kosong, tanggal_pengecekan = NOW() WHERE jenis_masalah LIKE '%Email%kosong%';
  UPDATE laporan_kualitas_data SET jumlah_sesudah = v_email_invalid, tanggal_pengecekan = NOW() WHERE jenis_masalah LIKE '%Format email%';
  UPDATE laporan_kualitas_data SET jumlah_sesudah = v_stok_negatif, tanggal_pengecekan = NOW() WHERE jenis_masalah LIKE '%Stok%';

  SELECT * FROM laporan_kualitas_data ORDER BY id;
END //

DELIMITER ;
