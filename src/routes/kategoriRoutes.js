const express = require('express');
const router = express.Router();
const kategoriController = require('../controllers/kategoriController');
const { isAuthenticated, isAdministrator } = require('../middleware/auth');

router.get('/', isAuthenticated, kategoriController.getAll);
router.post('/', isAuthenticated, kategoriController.create);
router.put('/:id', isAuthenticated, kategoriController.update);
router.delete('/:id', isAuthenticated, isAdministrator, kategoriController.remove);

module.exports = router;
