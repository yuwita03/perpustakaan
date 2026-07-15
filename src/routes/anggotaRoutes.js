const express = require('express');
const router = express.Router();
const anggotaController = require('../controllers/anggotaController');
const { isAuthenticated, isAdministrator } = require('../middleware/auth');

router.get('/', isAuthenticated, anggotaController.getAll);
router.get('/search', isAuthenticated, anggotaController.search);
router.get('/:id', isAuthenticated, anggotaController.getById);
router.post('/', isAuthenticated, anggotaController.create);
router.put('/:id', isAuthenticated, anggotaController.update);
router.put('/:id/toggle-status', isAuthenticated, isAdministrator, anggotaController.toggleStatus);

module.exports = router;
