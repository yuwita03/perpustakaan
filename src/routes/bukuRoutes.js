const express = require('express');
const router = express.Router();
const bukuController = require('../controllers/bukuController');
const { isAuthenticated, isAdministrator } = require('../middleware/auth');

router.get('/', isAuthenticated, bukuController.getAll);
router.get('/search', isAuthenticated, bukuController.search);
router.get('/:id', isAuthenticated, bukuController.getById);
router.post('/', isAuthenticated, bukuController.create);
router.put('/:id', isAuthenticated, bukuController.update);
router.delete('/:id', isAuthenticated, isAdministrator, bukuController.remove);

module.exports = router;
