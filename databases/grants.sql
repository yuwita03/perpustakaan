-- =============================================
-- KONTROL AKSES BERBASIS PERAN (GRANT/REVOKE)
-- =============================================
-- Jalankan sebagai root atau user dengan CREATE USER privilege

-- Buat user untuk Administrator (akses penuh)
CREATE USER IF NOT EXISTS 'admin_perpus'@'localhost' IDENTIFIED BY 'Admin123!';
GRANT ALL PRIVILEGES ON perpustakaan_db.* TO 'admin_perpus'@'localhost';

-- Buat user untuk Petugas Perpustakaan (akses terbatas)
CREATE USER IF NOT EXISTS 'petugas_perpus'@'localhost' IDENTIFIED BY 'Petugas123!';

-- Petugas: SELECT, INSERT, UPDATE pada tabel transaksi dan data master
-- Tapi TIDAK BOLEH DELETE data master (anggota, buku, kategori)
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.anggota TO 'petugas_perpus'@'localhost';
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.buku TO 'petugas_perpus'@'localhost';
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.kategori_buku TO 'petugas_perpus'@'localhost';
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.peminjaman TO 'petugas_perpus'@'localhost';
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.pengembalian TO 'petugas_perpus'@'localhost';
GRANT SELECT, INSERT, UPDATE ON perpustakaan_db.dokumen TO 'petugas_perpus'@'localhost';
GRANT SELECT ON perpustakaan_db.users TO 'petugas_perpus'@'localhost';

-- Petugas TIDAK boleh menghapus data
-- (tidak ada GRANT DELETE, jadi secara default tidak bisa)

-- Petugas boleh akses views
GRANT SELECT ON perpustakaan_db.v_buku_tersedia TO 'petugas_perpus'@'localhost';
GRANT SELECT ON perpustakaan_db.v_buku_dipinjam TO 'petugas_perpus'@'localhost';
GRANT SELECT ON perpustakaan_db.v_riwayat_peminjaman TO 'petugas_perpus'@'localhost';
GRANT SELECT ON perpustakaan_db.v_buku_terpopuler TO 'petugas_perpus'@'localhost';
GRANT SELECT ON perpustakaan_db.v_statistik TO 'petugas_perpus'@'localhost';

-- Petugas boleh execute stored procedures
GRANT EXECUTE ON PROCEDURE perpustakaan_db.sp_tambah_peminjaman TO 'petugas_perpus'@'localhost';
GRANT EXECUTE ON PROCEDURE perpustakaan_db.sp_tambah_pengembalian TO 'petugas_perpus'@'localhost';
GRANT EXECUTE ON PROCEDURE perpustakaan_db.sp_cari_anggota TO 'petugas_perpus'@'localhost';
GRANT EXECUTE ON PROCEDURE perpustakaan_db.sp_cari_buku TO 'petugas_perpus'@'localhost';
GRANT EXECUTE ON PROCEDURE perpustakaan_db.sp_laporan_peminjaman TO 'petugas_perpus'@'localhost';

-- Terapkan perubahan
FLUSH PRIVILEGES;

-- =============================================
-- UJI PERBEDAAN HAK AKSES
-- =============================================
-- Buka terminal MySQL baru dan jalankan:

-- UJI 1: Login sebagai petugas_perpus
-- mysql -u petugas_perpus -p
-- (masukkan password: Petugas123!)

-- UJI 2: Coba SELECT (harus berhasil)
-- USE perpustakaan_db;
-- SELECT * FROM anggota;
-- SELECT * FROM v_buku_tersedia;

-- UJI 3: Coba INSERT (harus berhasil)
-- INSERT INTO anggota (nama, alamat) VALUES ('Test', 'Jl. Test');

-- UJI 4: Coba DELETE anggota (HARUS DITOLAK)
-- DELETE FROM anggota WHERE nama = 'Test';
-- => Error: DELETE command denied to user 'petugas_perpus'@'localhost'

-- UJI 5: Coba DROP TABLE (HARUS DITOLAK)
-- DROP TABLE anggota;
-- => Error: DROP command denied to user 'petugas_perpus'@'localhost'

-- =============================================
-- REVOKE (jika ingin mencabut akses)
-- REVOKE ALL PRIVILEGES ON perpustakaan_db.* FROM 'petugas_perpus'@'localhost';
