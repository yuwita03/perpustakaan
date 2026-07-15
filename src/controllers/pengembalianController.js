const db = require('../config/db');

function fmtDatetime(d) {
  const pad = (n) => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;
}

exports.getAll = async (req, res) => {
  try {
    const [rows] = await db.execute(
      `SELECT pk.*, a.nama as nama_anggota, b.judul as judul_buku, p.tanggal_pinjam, p.tanggal_jatuh_tempo
       FROM pengembalian pk
       JOIN peminjaman p ON pk.peminjaman_id = p.id
       JOIN anggota a ON p.anggota_id = a.id
       JOIN buku b ON p.buku_id = b.id
       ORDER BY pk.id DESC`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const { peminjaman_id, tanggal_kembali, kondisi_buku } = req.body;
    if (!peminjaman_id) {
      return res.status(400).json({ error: 'peminjaman_id wajib diisi' });
    }

    await db.execute('CALL sp_tambah_pengembalian(?, ?, ?)', [
      peminjaman_id,
      tanggal_kembali || fmtDatetime(new Date()),
      kondisi_buku || 'baik',
    ]);

    res.status(201).json({ message: 'Pengembalian berhasil dicatat' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
