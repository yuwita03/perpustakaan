const express = require('express');
const cors = require('cors');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const path = require('path');
require('dotenv').config();

const db = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const anggotaRoutes = require('./routes/anggotaRoutes');
const bukuRoutes = require('./routes/bukuRoutes');
const kategoriRoutes = require('./routes/kategoriRoutes');
const peminjamanRoutes = require('./routes/peminjamanRoutes');
const pengembalianRoutes = require('./routes/pengembalianRoutes');
const dokumenRoutes = require('./routes/dokumenRoutes');
const laporanRoutes = require('./routes/laporanRoutes');
const csvRoutes = require('./routes/csvRoutes');

const app = express();

app.use(cors({ origin: 'http://localhost:5173', credentials: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const sessionStore = new MySQLStore({}, db);

app.use(session({
  secret: process.env.SESSION_SECRET || 'rahasia_default',
  resave: false,
  saveUninitialized: false,
  store: sessionStore,
  cookie: { maxAge: 1000 * 60 * 60 * 8 },
}));

app.use('/api/auth', authRoutes);
app.use('/api/anggota', anggotaRoutes);
app.use('/api/buku', bukuRoutes);
app.use('/api/kategori', kategoriRoutes);
app.use('/api/peminjaman', peminjamanRoutes);
app.use('/api/pengembalian', pengembalianRoutes);
app.use('/api/dokumen', dokumenRoutes);
app.use('/api/laporan', laporanRoutes);
app.use('/api/csv', csvRoutes);

// Serve frontend build in production
app.use(express.static(path.join(__dirname, '..', 'frontend', 'dist')));

app.use((req, res) => {
  if (!req.path.startsWith('/api')) {
    res.sendFile(path.join(__dirname, '..', 'frontend', 'dist', 'index.html'));
  }
});

module.exports = app;
