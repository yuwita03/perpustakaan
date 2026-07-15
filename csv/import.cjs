const mysql = require('mysql2');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'perpustakaan_db',
  waitForConnections: true,
  connectionLimit: 10,
});

const promisePool = pool.promise();

async function importCSV(filePath) {
  const data = fs.readFileSync(filePath, 'utf-8').trim().split('\n');
  const headers = data[0].split(',');
  const rows = data.slice(1);

  let imported = 0;
  let skipped = 0;
  let errors = [];

  for (const [index, line] of rows.entries()) {
    const values = line.split(',');
    const record = {};
    headers.forEach((h, i) => {
      record[h.trim()] = values[i]?.trim() || null;
    });

    try {
      // Cek duplikat berdasarkan email
      const [existing] = await promisePool.execute(
        'SELECT id FROM anggota WHERE email = ?',
        [record.email]
      );

      if (existing.length > 0) {
        console.log(`[SKIP] Baris ${index + 2}: Email ${record.email} sudah ada (id: ${existing[0].id})`);
        skipped++;
        continue;
      }

      await promisePool.execute(
        'INSERT INTO anggota (nama, alamat, no_telepon, email, tanggal_daftar) VALUES (?, ?, ?, ?, ?)',
        [record.nama, record.alamat, record.no_telepon, record.email, record.tanggal_daftar]
      );
      console.log(`[OK] Baris ${index + 2}: ${record.nama} berhasil diimpor`);
      imported++;
    } catch (err) {
      console.error(`[ERROR] Baris ${index + 2}: ${err.message}`);
      errors.push({ row: index + 2, message: err.message });
    }
  }

  console.log('\n=== RINGKASAN IMPORT ===');
  console.log(`Total data di CSV: ${rows.length}`);
  console.log(`Berhasil diimpor: ${imported}`);
  console.log(`Duplikat (skip): ${skipped}`);
  console.log(`Error: ${errors.length}`);
  if (errors.length > 0) {
    console.log('\nDaftar Error:');
    errors.forEach(e => console.log(`  Baris ${e.row}: ${e.message}`));
  }
}

const csvFile = process.argv[2] || path.join(__dirname, 'anggota.csv');
console.log(`Import CSV: ${csvFile}\n`);
importCSV(csvFile).then(() => {
  console.log('\nSelesai.');
  process.exit(0);
}).catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});
