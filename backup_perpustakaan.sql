-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: perpustakaan_db
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anggota`
--

DROP TABLE IF EXISTS `anggota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anggota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telepon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tanggal_daftar` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anggota`
--

LOCK TABLES `anggota` WRITE;
/*!40000 ALTER TABLE `anggota` DISABLE KEYS */;
INSERT INTO `anggota` VALUES (1,'Ahmad Fauzi','Jl. Merdeka No. 10','081234567890','ahmad.fauzi@mail.com','2025-01-15','2026-07-15 16:36:05','2026-07-15 16:36:05'),(2,'Siti Nurhaliza','Jl. Sudirman No. 22','081298765432','siti.nur@mail.com','2025-02-01','2026-07-15 16:36:05','2026-07-15 16:36:05'),(3,'Budi Santoso','Jl. Diponegoro No. 5','081211112222','budi.santoso@mail.com','2025-02-10','2026-07-15 16:36:05','2026-07-15 16:36:05'),(4,'Dewi Lestari','Jl. Ahmad Yani No. 8','081233334444','dewi.lestari@mail.com','2025-03-01','2026-07-15 16:36:05','2026-07-15 16:36:05'),(5,'Rian Pratama','Jl. Gatot Subroto No. 15','081255556666','rian.pratama@mail.com','2025-03-05','2026-07-15 16:36:05','2026-07-15 16:36:05'),(7,'Tidak Diketahui','Jl. Tanpa Nama',NULL,'anggota_7@fix.perpustakaan.ac.id','2025-04-05','2026-07-15 16:36:05','2026-07-15 16:41:33'),(8,'Joko Widodo','Jl. Kebon Jeruk No. 3','081222223333','joko_widodo@mail.com','2025-04-10','2026-07-15 16:36:05','2026-07-15 16:41:33'),(9,'asdasd','wasdwa','1123213','asdasdasd@gmail.com','2026-07-15','2026-07-15 17:23:24','2026-07-15 17:23:24');
/*!40000 ALTER TABLE `anggota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buku`
--

DROP TABLE IF EXISTS `buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buku` (
  `id` int NOT NULL AUTO_INCREMENT,
  `judul` varchar(150) NOT NULL,
  `penulis` varchar(100) DEFAULT NULL,
  `kategori_id` int DEFAULT NULL,
  `penerbit` varchar(100) DEFAULT NULL,
  `tahun_terbit` int DEFAULT NULL,
  `stok` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori_buku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buku`
--

LOCK TABLES `buku` WRITE;
/*!40000 ALTER TABLE `buku` DISABLE KEYS */;
INSERT INTO `buku` VALUES (1,'Belajar Basis Data','Andi Wijaya',1,'Penerbit Informatika',2022,5,'2026-07-15 16:36:05','2026-07-15 16:36:05'),(2,'Algoritma dan Pemrograman','Rudi Hartono',1,'Penerbit Andi',2021,3,'2026-07-15 16:36:05','2026-07-15 16:36:05'),(3,'Laskar Pelangi','Andrea Hirata',2,'Bentang Pustaka',2005,5,'2026-07-15 16:36:05','2026-07-15 17:16:33'),(4,'Fisika Dasar','Sutrisno Hadi',3,'Erlangga',2019,3,'2026-07-15 16:36:05','2026-07-15 16:53:17'),(5,'Pengantar Ekonomi Mikro','N. Gregory Mankiw',4,'Salemba Empat',2020,6,'2026-07-15 16:36:05','2026-07-15 17:17:11'),(6,'Sejarah Indonesia Modern','M.C. Ricklefs',5,'Serambi',2018,0,'2026-07-15 16:36:05','2026-07-15 17:18:18'),(7,'Manajemen Proyek IT','Herman Wibowo',1,'Gramedia',2020,0,'2026-07-15 16:36:05','2026-07-15 17:20:20');
/*!40000 ALTER TABLE `buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokumen`
--

DROP TABLE IF EXISTS `dokumen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dokumen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `judul` varchar(150) NOT NULL,
  `nama_file` varchar(150) NOT NULL,
  `jenis_file` varchar(50) DEFAULT NULL,
  `lokasi_file` varchar(255) DEFAULT NULL,
  `versi` varchar(20) DEFAULT NULL,
  `tanggal_unggah` datetime DEFAULT CURRENT_TIMESTAMP,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uploaded_by` (`uploaded_by`),
  CONSTRAINT `dokumen_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokumen`
--

LOCK TABLES `dokumen` WRITE;
/*!40000 ALTER TABLE `dokumen` DISABLE KEYS */;
INSERT INTO `dokumen` VALUES (1,'Panduan Peminjaman Buku','panduan_peminjaman.pdf','pdf','/dokumen/panduan_peminjaman.pdf','1.0','2026-07-15 16:36:05',1),(2,'Laporan Tahunan Perpustakaan 2025','laporan_tahunan_2025.pdf','pdf','/dokumen/laporan_tahunan_2025.pdf','1.0','2026-07-15 16:36:05',1);
/*!40000 ALTER TABLE `dokumen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori_buku`
--

DROP TABLE IF EXISTS `kategori_buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategori_buku` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori_buku`
--

LOCK TABLES `kategori_buku` WRITE;
/*!40000 ALTER TABLE `kategori_buku` DISABLE KEYS */;
INSERT INTO `kategori_buku` VALUES (1,'Teknologi Informasi'),(2,'Sastra'),(3,'Sains'),(4,'Ekonomi'),(5,'Sejarah');
/*!40000 ALTER TABLE `kategori_buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peminjaman`
--

DROP TABLE IF EXISTS `peminjaman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peminjaman` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anggota_id` int NOT NULL,
  `buku_id` int NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_jatuh_tempo` date DEFAULT NULL,
  `status` enum('dipinjam','dikembalikan') DEFAULT 'dipinjam',
  PRIMARY KEY (`id`),
  KEY `anggota_id` (`anggota_id`),
  KEY `buku_id` (`buku_id`),
  CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`id`),
  CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`buku_id`) REFERENCES `buku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peminjaman`
--

LOCK TABLES `peminjaman` WRITE;
/*!40000 ALTER TABLE `peminjaman` DISABLE KEYS */;
INSERT INTO `peminjaman` VALUES (1,1,1,'2025-06-01','2025-06-08','dikembalikan'),(2,2,3,'2025-06-05','2025-06-12','dikembalikan'),(3,3,5,'2025-06-10','2025-06-17','dikembalikan'),(4,4,2,'2025-06-15','2025-06-22','dikembalikan'),(5,5,4,'2025-06-20','2025-06-27','dikembalikan'),(6,8,6,'2026-07-15','2026-07-30','dikembalikan'),(7,7,5,'2026-07-15','2026-07-31','dikembalikan'),(8,8,6,'2026-07-15','2026-07-22','dikembalikan'),(9,5,5,'2026-07-15','2026-07-22','dikembalikan'),(10,8,5,'2026-07-15','2026-07-22','dikembalikan'),(11,8,5,'2026-07-15','2026-07-22','dikembalikan'),(12,8,5,'2026-07-15','2026-07-22','dipinjam'),(13,8,6,'2026-07-15','2026-07-22','dipinjam');
/*!40000 ALTER TABLE `peminjaman` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_kurangi_stok` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
  UPDATE buku
  SET stok = stok - 1
  WHERE id = NEW.buku_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pengembalian`
--

DROP TABLE IF EXISTS `pengembalian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengembalian` (
  `id` int NOT NULL AUTO_INCREMENT,
  `peminjaman_id` int NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `kondisi_buku` enum('baik','rusak','hilang') DEFAULT 'baik',
  PRIMARY KEY (`id`),
  UNIQUE KEY `peminjaman_id` (`peminjaman_id`),
  CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`peminjaman_id`) REFERENCES `peminjaman` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengembalian`
--

LOCK TABLES `pengembalian` WRITE;
/*!40000 ALTER TABLE `pengembalian` DISABLE KEYS */;
INSERT INTO `pengembalian` VALUES (1,1,'2025-06-07','baik'),(2,4,'2025-06-21','baik'),(3,5,'2026-07-15','baik'),(4,6,'2026-07-15','hilang'),(5,9,'2026-07-15','baik'),(6,7,'2026-07-15','baik'),(7,8,'2026-07-15','baik'),(8,10,'2026-07-15','baik'),(9,11,'2026-07-15','baik'),(10,2,'2026-07-15','baik'),(11,3,'2026-07-15','baik');
/*!40000 ALTER TABLE `pengembalian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tambah_stok` AFTER INSERT ON `pengembalian` FOR EACH ROW BEGIN
  DECLARE v_buku_id INT;
  DECLARE v_kondisi ENUM('baik', 'rusak', 'hilang');

  SELECT buku_id, NEW.kondisi_buku INTO v_buku_id, v_kondisi
  FROM peminjaman WHERE id = NEW.peminjaman_id;

  IF v_kondisi = 'baik' THEN
    UPDATE buku
    SET stok = stok + 1
    WHERE id = v_buku_id;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('Lmdz57_vAfE5TOo1SajtVPVCc39GKToB',1784138089,'{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2026-07-15T17:53:52.832Z\",\"httpOnly\":true,\"path\":\"/\"},\"user\":{\"id\":2,\"username\":\"petugas1\",\"role\":\"petugas\"}}'),('eOHcJUQObIhsieBqRvtEWHlgZtnl5YLA',1784140745,'{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2026-07-15T17:56:26.005Z\",\"httpOnly\":true,\"path\":\"/\"},\"user\":{\"id\":1,\"username\":\"admin\",\"role\":\"administrator\"}}'),('xKypZqfaw3nXXONNumZv3ooBHDyjG6sS',1784137891,'{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2026-07-15T17:51:31.174Z\",\"httpOnly\":true,\"path\":\"/\"},\"user\":{\"id\":2,\"username\":\"petugas1\",\"role\":\"petugas\"}}'),('zUn51uqyzfh7XiURpWM_z-90iKKl-8uW',1784137888,'{\"cookie\":{\"originalMaxAge\":28800000,\"expires\":\"2026-07-15T17:51:27.754Z\",\"httpOnly\":true,\"path\":\"/\"},\"user\":{\"id\":1,\"username\":\"admin\",\"role\":\"administrator\"}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('administrator','petugas') NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2b$10$bCwPwDIkvvzhS6P9YmIdGuqgdKIfKv2fJ6uNj1Ma3Iirw2BL0h3dm','administrator','2026-07-15 16:36:05'),(2,'petugas1','$2b$10$bCwPwDIkvvzhS6P9YmIdGuqgdKIfKv2fJ6uNj1Ma3Iirw2BL0h3dm','petugas','2026-07-15 16:36:05');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_buku_dipinjam`
--

DROP TABLE IF EXISTS `v_buku_dipinjam`;
/*!50001 DROP VIEW IF EXISTS `v_buku_dipinjam`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_buku_dipinjam` AS SELECT 
 1 AS `peminjaman_id`,
 1 AS `buku_id`,
 1 AS `judul_buku`,
 1 AS `anggota_id`,
 1 AS `nama_anggota`,
 1 AS `tanggal_pinjam`,
 1 AS `tanggal_jatuh_tempo`,
 1 AS `hari_terlambat`,
 1 AS `status_pinjam`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_buku_terpopuler`
--

DROP TABLE IF EXISTS `v_buku_terpopuler`;
/*!50001 DROP VIEW IF EXISTS `v_buku_terpopuler`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_buku_terpopuler` AS SELECT 
 1 AS `id`,
 1 AS `judul`,
 1 AS `penulis`,
 1 AS `nama_kategori`,
 1 AS `jumlah_dipinjam`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_buku_tersedia`
--

DROP TABLE IF EXISTS `v_buku_tersedia`;
/*!50001 DROP VIEW IF EXISTS `v_buku_tersedia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_buku_tersedia` AS SELECT 
 1 AS `id`,
 1 AS `judul`,
 1 AS `penulis`,
 1 AS `nama_kategori`,
 1 AS `penerbit`,
 1 AS `tahun_terbit`,
 1 AS `stok`,
 1 AS `stok_tersedia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_riwayat_peminjaman`
--

DROP TABLE IF EXISTS `v_riwayat_peminjaman`;
/*!50001 DROP VIEW IF EXISTS `v_riwayat_peminjaman`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_riwayat_peminjaman` AS SELECT 
 1 AS `peminjaman_id`,
 1 AS `anggota_id`,
 1 AS `nama_anggota`,
 1 AS `buku_id`,
 1 AS `judul_buku`,
 1 AS `tanggal_pinjam`,
 1 AS `tanggal_jatuh_tempo`,
 1 AS `status`,
 1 AS `tanggal_kembali`,
 1 AS `kondisi_buku`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_statistik`
--

DROP TABLE IF EXISTS `v_statistik`;
/*!50001 DROP VIEW IF EXISTS `v_statistik`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_statistik` AS SELECT 
 1 AS `total_buku`,
 1 AS `total_anggota`,
 1 AS `peminjaman_aktif`,
 1 AS `total_peminjaman`,
 1 AS `total_pengembalian`,
 1 AS `total_kategori`,
 1 AS `total_dokumen`,
 1 AS `total_users`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_buku_dipinjam`
--

/*!50001 DROP VIEW IF EXISTS `v_buku_dipinjam`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_buku_dipinjam` AS select `p`.`id` AS `peminjaman_id`,`b`.`id` AS `buku_id`,`b`.`judul` AS `judul_buku`,`a`.`id` AS `anggota_id`,`a`.`nama` AS `nama_anggota`,`p`.`tanggal_pinjam` AS `tanggal_pinjam`,`p`.`tanggal_jatuh_tempo` AS `tanggal_jatuh_tempo`,(to_days(curdate()) - to_days(`p`.`tanggal_jatuh_tempo`)) AS `hari_terlambat`,(case when (`p`.`tanggal_jatuh_tempo` < curdate()) then 'Terlambat' else 'Aman' end) AS `status_pinjam` from ((`peminjaman` `p` join `buku` `b` on((`p`.`buku_id` = `b`.`id`))) join `anggota` `a` on((`p`.`anggota_id` = `a`.`id`))) where (`p`.`status` = 'dipinjam') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_buku_terpopuler`
--

/*!50001 DROP VIEW IF EXISTS `v_buku_terpopuler`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_buku_terpopuler` AS select `b`.`id` AS `id`,`b`.`judul` AS `judul`,`b`.`penulis` AS `penulis`,`k`.`nama_kategori` AS `nama_kategori`,count(`p`.`id`) AS `jumlah_dipinjam` from ((`buku` `b` left join `kategori_buku` `k` on((`b`.`kategori_id` = `k`.`id`))) left join `peminjaman` `p` on((`b`.`id` = `p`.`buku_id`))) group by `b`.`id`,`b`.`judul`,`b`.`penulis`,`k`.`nama_kategori` order by `jumlah_dipinjam` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_buku_tersedia`
--

/*!50001 DROP VIEW IF EXISTS `v_buku_tersedia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_buku_tersedia` AS select `b`.`id` AS `id`,`b`.`judul` AS `judul`,`b`.`penulis` AS `penulis`,`k`.`nama_kategori` AS `nama_kategori`,`b`.`penerbit` AS `penerbit`,`b`.`tahun_terbit` AS `tahun_terbit`,`b`.`stok` AS `stok`,(`b`.`stok` - ifnull(`dipinjam`.`total`,0)) AS `stok_tersedia` from ((`buku` `b` left join `kategori_buku` `k` on((`b`.`kategori_id` = `k`.`id`))) left join (select `peminjaman`.`buku_id` AS `buku_id`,count(0) AS `total` from `peminjaman` where (`peminjaman`.`status` = 'dipinjam') group by `peminjaman`.`buku_id`) `dipinjam` on((`b`.`id` = `dipinjam`.`buku_id`))) having (`stok_tersedia` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_riwayat_peminjaman`
--

/*!50001 DROP VIEW IF EXISTS `v_riwayat_peminjaman`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_riwayat_peminjaman` AS select `p`.`id` AS `peminjaman_id`,`a`.`id` AS `anggota_id`,`a`.`nama` AS `nama_anggota`,`b`.`id` AS `buku_id`,`b`.`judul` AS `judul_buku`,`p`.`tanggal_pinjam` AS `tanggal_pinjam`,`p`.`tanggal_jatuh_tempo` AS `tanggal_jatuh_tempo`,`p`.`status` AS `status`,`pk`.`tanggal_kembali` AS `tanggal_kembali`,`pk`.`kondisi_buku` AS `kondisi_buku` from (((`peminjaman` `p` join `anggota` `a` on((`p`.`anggota_id` = `a`.`id`))) join `buku` `b` on((`p`.`buku_id` = `b`.`id`))) left join `pengembalian` `pk` on((`p`.`id` = `pk`.`peminjaman_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_statistik`
--

/*!50001 DROP VIEW IF EXISTS `v_statistik`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_statistik` AS select (select count(0) from `buku`) AS `total_buku`,(select count(0) from `anggota`) AS `total_anggota`,(select count(0) from `peminjaman` where (`peminjaman`.`status` = 'dipinjam')) AS `peminjaman_aktif`,(select count(0) from `peminjaman`) AS `total_peminjaman`,(select count(0) from `pengembalian`) AS `total_pengembalian`,(select count(0) from `kategori_buku`) AS `total_kategori`,(select count(0) from `dokumen`) AS `total_dokumen`,(select count(0) from `users`) AS `total_users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-15 17:39:52
