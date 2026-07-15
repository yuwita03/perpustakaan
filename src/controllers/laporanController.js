const db = require('../config/db');

exports.statistik = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM v_statistik');
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.bukuTersedia = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM v_buku_tersedia');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.bukuDipinjam = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM v_buku_dipinjam');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.riwayatPeminjaman = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM v_riwayat_peminjaman ORDER BY tanggal_pinjam DESC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.bukuTerpopuler = async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM v_buku_terpopuler LIMIT 10');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.kualitasData = async (req, res) => {
  try {
    // update hasil pengecekan
    await db.execute('CALL sp_cek_kualitas_data()');

    // ambil hasil terbaru
    const [rows] = await db.execute(
      'SELECT * FROM laporan_kualitas_data ORDER BY id ASC'
    );

    res.json(rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

exports.perPeriod = async (req, res) => {
  try {
    const { mulai, selesai } = req.query;
    if (!mulai || !selesai) {
      return res.status(400).json({ error: 'Parameter mulai dan selesai diperlukan (YYYY-MM-DD)' });
    }
    const [rows] = await db.execute('CALL sp_laporan_peminjaman(?, ?)', [mulai, selesai]);
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
