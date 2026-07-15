=========================================
DEMO KONTROL AKSES BERBASIS PERAN (RBAC)
=========================================

PENJELASAN

"Pada sistem perpustakaan ini saya menerapkan Role Based Access Control (RBAC)
menggunakan CREATE USER, GRANT, dan REVOKE.

Saya membuat dua user database:

1. admin_perpus
   -> Memiliki hak akses penuh terhadap database.

2. petugas_perpus
   -> Hanya dapat melihat, menambah, dan mengubah data.
   -> Tidak dapat menghapus data."

====================================================
1. LOGIN SEBAGAI PETUGAS
====================================================

CMD

mysql -u petugas_perpus -p

Password

Petugas123!

Masuk database

USE perpustakaan_db;

====================================================
2. PETUGAS BOLEH MELIHAT DATA
====================================================

SELECT * FROM anggota;

Penjelasan

"Perintah SELECT berhasil karena petugas memiliki privilege SELECT."

====================================================
3. PETUGAS TIDAK BOLEH DELETE
====================================================

DELETE FROM anggota WHERE id = 5;

Output

ERROR 1142 (42000):
DELETE command denied to user 'petugas_perpus'@'localhost'

Penjelasan

"Petugas tidak memiliki privilege DELETE sehingga MySQL menolak perintah tersebut."

====================================================
4. KELUAR
====================================================

exit;

====================================================
5. LOGIN SEBAGAI ADMIN
====================================================

mysql -u admin_perpus -p

Password

Admin123!

USE perpustakaan_db;

====================================================
6. TAMBAH DATA DUMMY
====================================================

INSERT INTO anggota (nama, alamat)
VALUES ('Dummy LSP', 'Testing');

Penjelasan

"Saya membuat data dummy agar dapat menunjukkan bahwa Administrator
memiliki hak DELETE."

====================================================
7. HAPUS DATA DUMMY
====================================================

DELETE FROM anggota
WHERE nama='Dummy LSP';

Output

Query OK, 1 row affected

Penjelasan

"Administrator berhasil menghapus data karena memiliki privilege DELETE."

====================================================
8. PENJELASAN SCRIPT
====================================================

CREATE USER

CREATE USER 'admin_perpus'@'localhost'
IDENTIFIED BY 'Admin123!';

CREATE USER 'petugas_perpus'@'localhost'
IDENTIFIED BY 'Petugas123!';

Penjelasan

"CREATE USER digunakan untuk membuat akun database."

----------------------------------------------------

GRANT

GRANT ALL PRIVILEGES
ON perpustakaan_db.*
TO 'admin_perpus'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON perpustakaan_db.anggota
TO 'petugas_perpus'@'localhost';

Penjelasan

"GRANT digunakan untuk memberikan hak akses kepada user."

----------------------------------------------------

REVOKE

REVOKE UPDATE
ON perpustakaan_db.anggota
FROM 'petugas_perpus'@'localhost';

FLUSH PRIVILEGES;

atau

REVOKE ALL PRIVILEGES
ON perpustakaan_db.*
FROM 'petugas_perpus'@'localhost';

FLUSH PRIVILEGES;

Penjelasan

"REVOKE digunakan untuk mencabut hak akses yang sebelumnya diberikan dengan GRANT."

====================================================
JIKA ASESOR BERTANYA
====================================================

Q : Kenapa tidak menggunakan root?

A :
"Karena root merupakan superuser. Untuk keamanan aplikasi saya membuat
user khusus Administrator dan Petugas agar hak akses dapat dibatasi sesuai peran."

----------------------------------------------------

Q : Kenapa petugas tidak boleh DELETE?

A :
"Untuk menjaga keamanan dan integritas data. Penghapusan data hanya boleh
dilakukan oleh Administrator."

----------------------------------------------------

Q : Apa fungsi CREATE USER?

A :
"Membuat akun database baru."

----------------------------------------------------

Q : Apa fungsi GRANT?

A :
"Memberikan privilege atau hak akses kepada user."

----------------------------------------------------

Q : Apa fungsi REVOKE?

A :
"Mencabut privilege yang sebelumnya diberikan."

====================================================
ALUR DEMO
====================================================

1. Jelaskan RBAC.
2. Login sebagai petugas.
3. SELECT berhasil.
4. DELETE ditolak.
5. Exit.
6. Login sebagai administrator.
7. INSERT data dummy.
8. DELETE data dummy berhasil.
9. Jelaskan CREATE USER, GRANT, dan REVOKE.