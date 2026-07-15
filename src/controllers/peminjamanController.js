const db = require('../config/db');

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT p.*, a.nama as nama_anggota, b.judul as judul_buku
       FROM peminjaman p
       JOIN anggota a ON p.anggota_id = a.id
       JOIN buku b ON p.buku_id = b.id
       ORDER BY p.id DESC`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { anggota_id, buku_id, tanggal_pinjam, tanggal_jatuh_tempo } = req.body;
    if (!anggota_id || !buku_id) {
      return res.status(400).json({ error: 'anggota_id dan buku_id wajib diisi' });
    }

    const [rows] = await db.execute('CALL sp_tambah_peminjaman(?, ?, ?, ?)', [
      anggota_id, buku_id,
      tanggal_pinjam || new Date().toISOString().split('T')[0],
      tanggal_jatuh_tempo || (() => {
        const d = new Date(); d.setDate(d.getDate() + 7);
        return d.toISOString().split('T')[0];
      })(),
    ]);

    const peminjamanId = rows[0][0]?.peminjaman_id;
    res.status(201).json({ message: 'Peminjaman berhasil', id: peminjamanId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getById = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT p.*, a.nama as nama_anggota, b.judul as judul_buku
       FROM peminjaman p
       JOIN anggota a ON p.anggota_id = a.id
       JOIN buku b ON p.buku_id = b.id
       WHERE p.id = ?`, [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ error: 'Peminjaman tidak ditemukan' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
