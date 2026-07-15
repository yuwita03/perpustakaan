const bcrypt = require('bcryptjs');
const db = require('../config/db');

exports.login = async (req, res) => {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      return res.status(400).json({ error: 'Username dan password harus diisi' });
    }

    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    if (rows.length === 0) {
      return res.status(401).json({ error: 'Username atau password salah' });
    }

    const user = rows[0];
    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) {
      return res.status(401).json({ error: 'Username atau password salah' });
    }

    req.session.user = {
      id: user.id,
      username: user.username,
      role: user.role,
    };

    res.json({
      message: 'Login berhasil',
      user: { id: user.id, username: user.username, role: user.role },
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.logout = async (req, res) => {
  req.session.destroy();
  res.json({ message: 'Logout berhasil' });
};

exports.me = async (req, res) => {
  if (req.session && req.session.user) {
    return res.json({ user: req.session.user });
  }
  res.status(401).json({ error: 'Belum login' });
};
