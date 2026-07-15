const db = require('../config/db');

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM kategori_buku ORDER BY id ASC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { nama_kategori } = req.body;
    if (!nama_kategori) return res.status(400).json({ error: 'Nama kategori wajib diisi' });
    const [result] = await db.execute('INSERT INTO kategori_buku (nama_kategori) VALUES (?)', [nama_kategori]);
    res.status(201).json({ message: 'Kategori berhasil ditambahkan', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.update = async (req, res) => {
  try {
    const { nama_kategori } = req.body;
    const [result] = await db.execute('UPDATE kategori_buku SET nama_kategori=? WHERE id=?', [nama_kategori, req.params.id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Kategori tidak ditemukan' });
    res.json({ message: 'Kategori berhasil diupdate' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.remove = async (req, res) => {
  try {
    const [buku] = await db.execute('SELECT id FROM buku WHERE kategori_id = ? LIMIT 1', [req.params.id]);
    if (buku.length > 0) {
      return res.status(400).json({ error: 'Kategori masih digunakan oleh buku. Hapus atau ubah kategori buku terlebih dahulu.' });
    }
    const [result] = await db.execute('DELETE FROM kategori_buku WHERE id = ?', [req.params.id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Kategori tidak ditemukan' });
    res.json({ message: 'Kategori berhasil dihapus' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
