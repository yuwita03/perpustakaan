const db = require('../config/db');

exports.import = async (req, res) => {
  try {
    const { data } = req.body;
    if (!data || !Array.isArray(data) || data.length === 0) {
      return res.status(400).json({ error: 'Data CSV tidak valid' });
    }

    let imported = 0;
    let skipped = 0;
    let errors = [];

    for (const row of data) {
      if (!row.nama) {
        errors.push({ nama: row.nama || 'unknown', message: 'Nama kosong' });
        continue;
      }

      try {
        const [existing] = await db.execute('SELECT id FROM anggota WHERE email = ?', [row.email || '']);
        if (existing.length > 0) {
          skipped++;
          continue;
        }

        await db.execute(
          'INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar) VALUES (?, ?, ?, ?, ?)',
          [row.nama, row.alamat || null, row.no_telepon || null, row.email || null, row.tanggal_daftar || new Date().toISOString().split('T')[0]]
        );
        imported++;
      } catch (err) {
        errors.push({ nama: row.nama, message: err.message });
      }
    }

    res.json({ imported, skipped, errors, total: data.length });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
