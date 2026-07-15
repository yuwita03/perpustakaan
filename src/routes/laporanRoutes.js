const express = require('express');
const router = express.Router();
const laporanController = require('../controllers/laporanController');
const { isAuthenticated } = require('../middleware/auth');

router.get('/statistik', isAuthenticated, laporanController.statistik);
router.get('/buku-tersedia', isAuthenticated, laporanController.bukuTersedia);
router.get('/buku-dipinjam', isAuthenticated, laporanController.bukuDipinjam);
router.get('/riwayat', isAuthenticated, laporanController.riwayatPeminjaman);
router.get('/buku-terpopuler', isAuthenticated, laporanController.bukuTerpopuler);
router.get('/kualitas-data', isAuthenticated, laporanController.kualitasData);
router.get('/per-periode', isAuthenticated, laporanController.perPeriod);

module.exports = router;
