function isAuthenticated(req, res, next) {
  if (req.session && req.session.user) {
    return next();
  }
  return res.status(401).json({ error: 'Silakan login terlebih dahulu' });
}

function isAdministrator(req, res, next) {
  if (req.session && req.session.user && req.session.user.role === 'administrator') {
    return next();
  }
  return res.status(403).json({ error: 'Akses ditolak. Hanya untuk Administrator.' });
}

module.exports = { isAuthenticated, isAdministrator };
