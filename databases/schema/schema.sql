CREATE DATABASE IF NOT EXISTS perpustakaan_db;
USE perpustakaan_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('administrator', 'petugas') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE anggota (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100) NOT NULL,
  alamat VARCHAR(255),
  no_telepon VARCHAR(20),
  email VARCHAR(100),
  tanggal_daftar DATE,
  status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE kategori_buku (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_kategori VARCHAR(50) NOT NULL
);

CREATE TABLE buku (
  id INT AUTO_INCREMENT PRIMARY KEY,
  judul VARCHAR(150) NOT NULL,
  penulis VARCHAR(100),
  kategori_id INT,
  penerbit VARCHAR(100),
  tahun_terbit INT,
  stok INT DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (kategori_id) REFERENCES kategori_buku(id)
);

CREATE TABLE peminjaman (
  id INT AUTO_INCREMENT PRIMARY KEY,
  anggota_id INT NOT NULL,
  buku_id INT NOT NULL,
  tanggal_pinjam DATE NOT NULL,
  tanggal_jatuh_tempo DATE,
  status ENUM('dipinjam', 'dikembalikan') DEFAULT 'dipinjam',
  FOREIGN KEY (anggota_id) REFERENCES anggota(id),
  FOREIGN KEY (buku_id) REFERENCES buku(id)
);

CREATE TABLE pengembalian (
  id INT AUTO_INCREMENT PRIMARY KEY,
  peminjaman_id INT NOT NULL UNIQUE,
  tanggal_kembali DATE,
  kondisi_buku ENUM('baik', 'rusak', 'hilang') DEFAULT 'baik',
  FOREIGN KEY (peminjaman_id) REFERENCES peminjaman(id)
);

CREATE TABLE dokumen (
  id INT AUTO_INCREMENT PRIMARY KEY,
  judul VARCHAR(150) NOT NULL,
  nama_file VARCHAR(150) NOT NULL,
  jenis_file VARCHAR(50),
  lokasi_file VARCHAR(255),
  versi VARCHAR(20),
  tanggal_unggah DATETIME DEFAULT CURRENT_TIMESTAMP,
  uploaded_by INT,
  FOREIGN KEY (uploaded_by) REFERENCES users(id)
);