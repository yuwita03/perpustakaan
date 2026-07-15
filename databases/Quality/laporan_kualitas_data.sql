USE perpustakaan_db;

CREATE TABLE IF NOT EXISTS laporan_kualitas_data (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tabel_terkait VARCHAR(50) NOT NULL,
  jenis_masalah VARCHAR(100) NOT NULL,
  jumlah_sebelum INT NOT NULL DEFAULT 0,
  jumlah_sesudah INT NOT NULL DEFAULT 0,
  tanggal_pengecekan DATETIME DEFAULT CURRENT_TIMESTAMP
);

TRUNCATE TABLE laporan_kualitas_data;

INSERT INTO laporan_kualitas_data (tabel_terkait, jenis_masalah, jumlah_sebelum, jumlah_sesudah) VALUES
('anggota', 'Data anggota ganda (duplikat email)', 1, 0),
('anggota', 'Nama anggota kosong', 1, 0),
('anggota', 'Email anggota kosong', 1, 0),
('anggota', 'Format email tidak valid (tanpa @)', 1, 0),
('buku', 'Stok buku bernilai negatif', 1, 0);
