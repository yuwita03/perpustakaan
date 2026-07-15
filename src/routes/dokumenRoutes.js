const express = require('express');
const router = express.Router();
const dokumenController = require('../controllers/dokumenController');
const { isAuthenticated, isAdministrator } = require('../middleware/auth');

router.get('/', isAuthenticated, dokumenController.getAll);
router.post('/', isAuthenticated, dokumenController.create);
router.delete('/:id', isAuthenticated, isAdministrator, dokumenController.remove);

module.exports = router;
