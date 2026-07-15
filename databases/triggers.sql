USE perpustakaan_db;

DELIMITER //

-- =============================================
-- TRIGGERS
-- =============================================

-- 1. Kurangi stok buku saat peminjaman dibuat
DROP TRIGGER IF EXISTS trg_kurangi_stok;
CREATE TRIGGER trg_kurangi_stok
AFTER INSERT ON peminjaman
FOR EACH ROW
BEGIN
  UPDATE buku
  SET stok = stok - 1
  WHERE id = NEW.buku_id;
END //

-- 2. Tambah stok buku saat pengembalian (hanya jika kondisi baik)
DROP TRIGGER IF EXISTS trg_tambah_stok;
CREATE TRIGGER trg_tambah_stok
AFTER INSERT ON pengembalian
FOR EACH ROW
BEGIN
  DECLARE v_buku_id INT;
  DECLARE v_kondisi ENUM('baik', 'rusak', 'hilang');

  SELECT buku_id, NEW.kondisi_buku INTO v_buku_id, v_kondisi
  FROM peminjaman WHERE id = NEW.peminjaman_id;

  IF v_kondisi = 'baik' THEN
    UPDATE buku
    SET stok = stok + 1
    WHERE id = v_buku_id;
  END IF;
END //

DELIMITER ;
