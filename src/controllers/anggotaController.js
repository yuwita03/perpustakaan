const db = require('../config/db');

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM anggota ORDER BY id DESC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getById = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM anggota WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Anggota tidak ditemukan' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { nama, alamat, no_telepon, email, tanggal_daftar } = req.body;
    if (!nama) return res.status(400).json({ error: 'Nama wajib diisi' });

    const [result] = await db.execute(
      'INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar) VALUES (?, ?, ?, ?, ?)',
      [nama, alamat || null, no_telepon || null, email || null, tanggal_daftar || new Date().toISOString().split('T')[0]]
    );
    res.status(201).json({ message: 'Anggota berhasil ditambahkan', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.update = async (req, res) => {
  try {
    const { nama, alamat, no_telepon, email, tanggal_daftar } = req.body;

    const [cek] = await db.execute('SELECT status FROM anggota WHERE id = ?', [req.params.id]);
    if (cek.length === 0) return res.status(404).json({ error: 'Anggota tidak ditemukan' });
    if (cek[0].status === 'nonaktif') return res.status(403).json({ error: 'Anggota yang dinonaktifkan tidak bisa diedit' });

    await db.execute(
      'UPDATE anggota SET nama=?, alamat=?, no_telepon=?, email=?, tanggal_daftar=? WHERE id=?',
      [nama, alamat, no_telepon, email, tanggal_daftar, req.params.id]
    );
    res.json({ message: 'Anggota berhasil diupdate' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.toggleStatus = async (req, res) => {
  try {
    const [anggota] = await db.execute('SELECT status FROM anggota WHERE id = ?', [req.params.id]);
    if (anggota.length === 0) return res.status(404).json({ error: 'Anggota tidak ditemukan' });
    const newStatus = anggota[0].status === 'aktif' ? 'nonaktif' : 'aktif';
    await db.execute('UPDATE anggota SET status = ? WHERE id = ?', [newStatus, req.params.id]);
    res.json({ message: `Anggota berhasil di${newStatus === 'aktif' ? 'aktifkan' : 'nonaktifkan'}`, status: newStatus });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.search = async (req, res) => {
  try {
    const keyword = req.query.q || '';
    const [rows] = await db.execute(
      'SELECT * FROM anggota WHERE nama LIKE ? OR email LIKE ? OR no_telepon LIKE ?',
      [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
