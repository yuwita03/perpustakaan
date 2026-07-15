# Matriks Hak Akses - Sistem Perpustakaan Kampus

| Objek Database | Administrator | Petugas Perpustakaan |
|---------------|:-------------:|:--------------------:|
| **Tabel** | | |
| anggota | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| buku | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| kategori_buku | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| peminjaman | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| pengembalian | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| dokumen | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |
| users | SELECT, INSERT, UPDATE, DELETE | SELECT |
| **Views** | | |
| v_buku_tersedia | SELECT | SELECT |
| v_buku_dipinjam | SELECT | SELECT |
| v_riwayat_peminjaman | SELECT | SELECT |
| v_buku_terpopuler | SELECT | SELECT |
| v_statistik | SELECT | SELECT |
| **Procedures** | | |
| sp_tambah_peminjaman | EXECUTE | EXECUTE |
| sp_tambah_pengembalian | EXECUTE | EXECUTE |
| sp_cari_anggota | EXECUTE | EXECUTE |
| sp_cari_buku | EXECUTE | EXECUTE |
| sp_laporan_peminjaman | EXECUTE | EXECUTE |
| **DDL** | | |
| CREATE TABLE | ✅ | ❌ |
| DROP TABLE | ✅ | ❌ |
| ALTER TABLE | ✅ | ❌ |
| **Lainnya** | | |
| Backup (mysqldump) | ✅ | ❌ |
| Management User | ✅ | ❌ |

**Keterangan:**
- ✅ = Memiliki akses
- ❌ = Tidak memiliki akses
- Administrator memiliki ALL PRIVILEGES (akses penuh)
- Petugas Perpustakaan hanya memiliki SELECT, INSERT, UPDATE (tanpa DELETE)
- Uji akses dapat dilakukan melalui: `mysql -u petugas_perpus -p`
