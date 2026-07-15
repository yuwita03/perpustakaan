const db = require('../config/db');

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT d.*, u.username as uploaded_by_name
       FROM dokumen d
       LEFT JOIN users u ON d.uploaded_by = u.id
       ORDER BY d.id DESC`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { judul, nama_file, jenis_file, lokasi_file, versi } = req.body;
    if (!judul || !nama_file) {
      return res.status(400).json({ error: 'Judul dan nama_file wajib diisi' });
    }

    const [result] = await db.execute(
      'INSERT INTO dokumen (judul, nama_file, jenis_file, lokasi_file, versi, uploaded_by) VALUES (?, ?, ?, ?, ?, ?)',
      [judul, nama_file, jenis_file || null, lokasi_file || null, versi || '1.0', req.session.user?.id || null]
    );
    res.status(201).json({ message: 'Dokumen berhasil ditambahkan', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.remove = async (req, res) => {
  try {
    const [result] = await db.execute('DELETE FROM dokumen WHERE id = ?', [req.params.id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Dokumen tidak ditemukan' });
    res.json({ message: 'Dokumen berhasil dihapus' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
