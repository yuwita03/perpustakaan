const db = require('../config/db');

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT b.*, k.nama_kategori FROM buku b LEFT JOIN kategori_buku k ON b.kategori_id = k.id ORDER BY b.id DESC'
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getById = async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT b.*, k.nama_kategori FROM buku b LEFT JOIN kategori_buku k ON b.kategori_id = k.id WHERE b.id = ?',
      [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ error: 'Buku tidak ditemukan' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { judul, penulis, kategori_id, penerbit, tahun_terbit, stok } = req.body;
    if (!judul) return res.status(400).json({ error: 'Judul wajib diisi' });

    const [result] = await db.execute(
      'INSERT INTO buku (judul, penulis, kategori_id, penerbit, tahun_terbit, stok) VALUES (?, ?, ?, ?, ?, ?)',
      [judul, penulis || null, kategori_id || null, penerbit || null, tahun_terbit || null, stok || 0]
    );
    res.status(201).json({ message: 'Buku berhasil ditambahkan', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.update = async (req, res) => {
  try {
    const { judul, penulis, kategori_id, penerbit, tahun_terbit, stok } = req.body;
    const [result] = await db.execute(
      'UPDATE buku SET judul=?, penulis=?, kategori_id=?, penerbit=?, tahun_terbit=?, stok=? WHERE id=?',
      [judul, penulis, kategori_id, penerbit, tahun_terbit, stok, req.params.id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Buku tidak ditemukan' });
    res.json({ message: 'Buku berhasil diupdate' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.remove = async (req, res) => {
  try {
    const [peminjaman] = await db.execute('SELECT id FROM peminjaman WHERE buku_id = ? LIMIT 1', [req.params.id]);
    if (peminjaman.length > 0) {
      return res.status(400).json({ error: 'Buku memiliki riwayat peminjaman. Hapus peminjaman terlebih dahulu.' });
    }
    const [result] = await db.execute('DELETE FROM buku WHERE id = ?', [req.params.id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Buku tidak ditemukan' });
    res.json({ message: 'Buku berhasil dihapus' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.search = async (req, res) => {
  try {
    const keyword = req.query.q || '';
    const [rows] = await db.execute(
      `SELECT b.*, k.nama_kategori FROM buku b LEFT JOIN kategori_buku k ON b.kategori_id = k.id
       WHERE b.judul LIKE ? OR b.penulis LIKE ? OR k.nama_kategori LIKE ?`,
      [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
