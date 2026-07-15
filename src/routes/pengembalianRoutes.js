const express = require('express');
const router = express.Router();
const pengembalianController = require('../controllers/pengembalianController');
const { isAuthenticated } = require('../middleware/auth');

router.get('/', isAuthenticated, pengembalianController.getAll);
router.post('/', isAuthenticated, pengembalianController.create);

module.exports = router;
