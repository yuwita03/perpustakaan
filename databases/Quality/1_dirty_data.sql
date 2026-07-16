USE perpustakaan_db;

-- Data anggota ganda (duplikat nama & email persis)
INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar) VALUES
('Ahmad Fauzi', 'Jl. Merdeka No. 10', '081234567890', 'ahmad.fauzi@mail.com', '2025-04-01'),
-- Data kosong (nama & email kosong)
('', 'Jl. Tanpa Nama', NULL, '', '2025-04-05'),
-- Format email tidak sesuai
('Joko Widodo', 'Jl. Kebon Jeruk No. 3', '081222223333', 'joko_widodo_at_mail.com', '2025-04-10');

-- Buku dengan stok tidak valid (negatif)
INSERT INTO buku (judul, penulis, kategori_id, penerbit, tahun_terbit, stok) VALUES
('Manajemen Proyek IT', 'Herman Wibowo', 1, 'Gramedia', 2020, -3);