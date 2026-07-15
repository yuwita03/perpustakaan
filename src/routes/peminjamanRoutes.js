const express = require('express');
const router = express.Router();
const peminjamanController = require('../controllers/peminjamanController');
const { isAuthenticated } = require('../middleware/auth');

router.get('/', isAuthenticated, peminjamanController.getAll);
router.get('/:id', isAuthenticated, peminjamanController.getById);
router.post('/', isAuthenticated, peminjamanController.create);

module.exports = router;
