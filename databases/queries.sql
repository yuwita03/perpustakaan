USE perpustakaan_db;

-- =============================================
-- CONTOH QUERY SQL
-- =============================================

-- --- INSERT ---
-- Tambah kategori baru
INSERT INTO kategori_buku (nama_kategori) VALUES ('Filsafat');

-- Tambah buku baru
INSERT INTO buku (judul, penulis, kategori_id, penerbit, tahun_terbit, stok)
VALUES ('Filsafat Ilmu', 'Jujun S. Suriasumantri', 6, 'Pustaka Filsafat', 2023, 3);

-- Tambah anggota baru
INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar)
VALUES ('Rina Melati', 'Jl. Anggrek No. 7', '081277788899', 'rina.melati@mail.com', CURDATE());

-- --- SELECT ---
-- Semua buku dengan kategori
SELECT b.*, k.nama_kategori
FROM buku b
JOIN kategori_buku k ON b.kategori_id = k.id;

-- Peminjaman aktif (belum dikembalikan)
SELECT * FROM peminjaman WHERE status = 'dipinjam';

-- Anggota yang pernah meminjam buku
SELECT DISTINCT a.id, a.nama
FROM anggota a
JOIN peminjaman p ON a.id = p.anggota_id;

-- --- UPDATE ---
-- Update data anggota
UPDATE anggota
SET alamat = 'Jl. Baru No. 99', no_telepon = '081399988877'
WHERE id = 1;

-- Update stok buku
UPDATE buku SET stok = 10 WHERE id = 1;

-- --- DELETE ---
-- Hapus pengembalian (jika ada)
-- DELETE FROM pengembalian WHERE peminjaman_id = 1;
-- Hapus peminjaman (jika tidak ada pengembalian terkait)
-- DELETE FROM peminjaman WHERE id = 1;

-- --- JOIN (Multi-tabel) ---
-- Riwayat lengkap: anggota + peminjaman + buku + pengembalian
SELECT a.nama as anggota, b.judul as buku,
       p.tanggal_pinjam, p.tanggal_jatuh_tempo, p.status,
       pk.tanggal_kembali, pk.kondisi_buku
FROM anggota a
JOIN peminjaman p ON a.id = p.anggota_id
JOIN buku b ON p.buku_id = b.id
LEFT JOIN pengembalian pk ON p.id = pk.peminjaman_id;

-- --- AGREGASI ---
-- Jumlah peminjaman per anggota
SELECT a.nama, COUNT(p.id) as total_pinjam
FROM anggota a
LEFT JOIN peminjaman p ON a.id = p.anggota_id
GROUP BY a.id, a.nama
ORDER BY total_pinjam DESC;

-- Buku paling banyak dipinjam
SELECT b.judul, COUNT(p.id) as total_dipinjam
FROM buku b
LEFT JOIN peminjaman p ON b.id = p.buku_id
GROUP BY b.id, b.judul
ORDER BY total_dipinjam DESC;

-- --- PENCARIAN ---
-- Cari buku berdasarkan judul
SELECT * FROM buku WHERE judul LIKE '%basis%';

-- Cari anggota berdasarkan nama
SELECT * FROM anggota WHERE nama LIKE '%ahmad%';

-- Cari peminjaman berdasarkan nama anggota (via JOIN)
SELECT p.*, a.nama
FROM peminjaman p
JOIN anggota a ON p.anggota_id = a.id
WHERE a.nama LIKE '%siti%';
