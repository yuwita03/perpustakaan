const express = require('express');
const router = express.Router();
const csvController = require('../controllers/csvController');
const { isAuthenticated, isAdministrator } = require('../middleware/auth');

router.post('/import', isAuthenticated, isAdministrator, csvController.import);

module.exports = router;
