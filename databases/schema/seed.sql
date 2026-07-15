USE perpustakaan_db;

-- Users (Administrator & Petugas)
INSERT INTO users (username, password_hash, role) VALUES
('admin', '$2b$10$bCwPwDIkvvzhS6P9YmIdGuqgdKIfKv2fJ6uNj1Ma3Iirw2BL0h3dm', 'administrator'),
('petugas1', '$2b$10$bCwPwDIkvvzhS6P9YmIdGuqgdKIfKv2fJ6uNj1Ma3Iirw2BL0h3dm', 'petugas');
-- password untuk kedua user di atas adalah: password123

-- Kategori Buku
INSERT INTO kategori_buku (nama_kategori) VALUES
('Teknologi Informasi'),
('Sastra'),
('Sains'),
('Ekonomi'),
('Sejarah');

-- Anggota
INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar) VALUES
('Ahmad Fauzi', 'Jl. Merdeka No. 10', '081234567890', 'ahmad.fauzi@mail.com', '2025-01-15'),
('Siti Nurhaliza', 'Jl. Sudirman No. 22', '081298765432', 'siti.nur@mail.com', '2025-02-01'),
('Budi Santoso', 'Jl. Diponegoro No. 5', '081211112222', 'budi.santoso@mail.com', '2025-02-10'),
('Dewi Lestari', 'Jl. Ahmad Yani No. 8', '081233334444', 'dewi.lestari@mail.com', '2025-03-01'),
('Rian Pratama', 'Jl. Gatot Subroto No. 15', '081255556666', 'rian.pratama@mail.com', '2025-03-05');

-- Buku
INSERT INTO buku (judul, penulis, kategori_id, penerbit, tahun_terbit, stok) VALUES
('Belajar Basis Data', 'Andi Wijaya', 1, 'Penerbit Informatika', 2022, 5),
('Algoritma dan Pemrograman', 'Rudi Hartono', 1, 'Penerbit Andi', 2021, 3),
('Laskar Pelangi', 'Andrea Hirata', 2, 'Bentang Pustaka', 2005, 4),
('Fisika Dasar', 'Sutrisno Hadi', 3, 'Erlangga', 2019, 2),
('Pengantar Ekonomi Mikro', 'N. Gregory Mankiw', 4, 'Salemba Empat', 2020, 6),
('Sejarah Indonesia Modern', 'M.C. Ricklefs', 5, 'Serambi', 2018, 2);

-- Peminjaman (contoh: beberapa masih dipinjam, beberapa sudah dikembalikan)
INSERT INTO peminjaman (anggota_id, buku_id, tanggal_pinjam, tanggal_jatuh_tempo, status) VALUES
(1, 1, '2025-06-01', '2025-06-08', 'dikembalikan'),
(2, 3, '2025-06-05', '2025-06-12', 'dipinjam'),
(3, 5, '2025-06-10', '2025-06-17', 'dipinjam'),
(4, 2, '2025-06-15', '2025-06-22', 'dikembalikan'),
(5, 4, '2025-06-20', '2025-06-27', 'dipinjam');

-- Pengembalian (hanya untuk peminjaman yang statusnya "dikembalikan")
INSERT INTO pengembalian (peminjaman_id, tanggal_kembali, kondisi_buku) VALUES
(1, '2025-06-07', 'baik'),
(4, '2025-06-21', 'baik');

-- Dokumen contoh
INSERT INTO dokumen (judul, nama_file, jenis_file, lokasi_file, versi, uploaded_by) VALUES
('Panduan Peminjaman Buku', 'panduan_peminjaman.pdf', 'pdf', '/dokumen/panduan_peminjaman.pdf', '1.0', 1),
('Laporan Tahunan Perpustakaan 2025', 'laporan_tahunan_2025.pdf', 'pdf', '/dokumen/laporan_tahunan_2025.pdf', '1.0', 1);