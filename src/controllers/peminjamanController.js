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

    const [cek] = await db.execute('SELECT status FROM anggota WHERE id = ?', [anggota_id]);
    if (cek.length === 0) return res.status(404).json({ error: 'Anggota tidak ditemukan' });
    if (cek[0].status === 'nonaktif') return res.status(403).json({ error: 'Anggota yang dinonaktifkan tidak dapat meminjam buku' });

    const now = new Date();
    const fmt = (d) => {
      const pad = (n) => String(n).padStart(2, '0');
      return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;
    };
    const [rows] = await db.execute('CALL sp_tambah_peminjaman(?, ?, ?, ?)', [
      anggota_id, buku_id,
      tanggal_pinjam || fmt(now),
      tanggal_jatuh_tempo || fmt(new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000)),
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
