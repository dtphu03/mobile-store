CREATE DATABASE  IF NOT EXISTS `online_store` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `online_store`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: online_store
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chi_muc_gio_hang`
--

DROP TABLE IF EXISTS `chi_muc_gio_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_muc_gio_hang` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `so_luong` int NOT NULL,
  `ma_gio_hang` bigint DEFAULT NULL,
  `ma_san_pham` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK49lmmclnjgb7eck20lwhv0cks` (`ma_gio_hang`),
  KEY `FKkd69a7wiulr4xgohxl0rlhth4` (`ma_san_pham`),
  CONSTRAINT `FK49lmmclnjgb7eck20lwhv0cks` FOREIGN KEY (`ma_gio_hang`) REFERENCES `gio_hang` (`id`),
  CONSTRAINT `FKkd69a7wiulr4xgohxl0rlhth4` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_muc_gio_hang`
--

LOCK TABLES `chi_muc_gio_hang` WRITE;
/*!40000 ALTER TABLE `chi_muc_gio_hang` DISABLE KEYS */;
INSERT INTO `chi_muc_gio_hang` VALUES (26,1,1,155),(41,1,3,158),(42,1,3,154);
/*!40000 ALTER TABLE `chi_muc_gio_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_don_hang`
--

DROP TABLE IF EXISTS `chi_tiet_don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_don_hang` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `don_gia` bigint NOT NULL,
  `so_luong` int DEFAULT NULL,
  `ma_don_hang` bigint DEFAULT NULL,
  `ma_san_pham` bigint DEFAULT NULL,
  `so_luong_dat` int NOT NULL,
  `so_luong_nhan_hang` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9wl3houbukbxpixsut6uvojhy` (`ma_don_hang`),
  KEY `FK3ry84nmdxgoarx53qjxd671tk` (`ma_san_pham`),
  CONSTRAINT `FK3ry84nmdxgoarx53qjxd671tk` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`id`),
  CONSTRAINT `FK9wl3houbukbxpixsut6uvojhy` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (4,59920000,NULL,41,64,8,8),(5,22490000,NULL,41,54,1,1),(6,5490000,NULL,41,60,1,1),(7,31190000,NULL,42,145,1,1),(8,19590000,NULL,43,158,1,0),(9,2990000,NULL,43,157,1,0),(10,19590000,NULL,44,158,1,0),(11,2990000,NULL,44,157,1,0),(12,19590000,NULL,45,158,1,0),(13,2990000,NULL,45,157,1,0),(14,19590000,NULL,46,158,1,0),(15,2990000,NULL,46,157,1,0),(16,19590000,NULL,47,158,1,0),(17,2990000,NULL,47,157,1,0),(18,19590000,NULL,48,158,1,0),(19,2990000,NULL,48,157,1,0),(20,19590000,NULL,49,158,1,0),(21,2990000,NULL,49,157,1,0),(22,19590000,NULL,50,158,1,0),(23,2990000,NULL,50,157,1,0),(24,19590000,NULL,51,158,1,0),(25,2990000,NULL,51,157,1,0),(26,9690000,NULL,52,156,1,0),(27,6490000,NULL,52,155,1,0),(28,9690000,NULL,53,156,1,0),(29,6490000,NULL,53,155,1,0),(30,9690000,NULL,54,156,1,0),(31,6490000,NULL,54,155,1,0),(32,9690000,NULL,55,156,1,0),(33,6490000,NULL,55,155,1,0),(34,9690000,NULL,56,156,1,0),(35,6490000,NULL,56,155,1,0),(36,44990000,NULL,57,150,1,0),(37,6690000,NULL,57,149,1,0),(38,15290000,NULL,58,151,1,0),(39,6490000,NULL,59,155,1,0),(40,19290000,NULL,60,153,1,0),(41,6490000,NULL,61,155,1,0),(42,22590000,NULL,62,152,1,0),(43,22590000,NULL,63,152,1,0),(44,45180000,NULL,64,152,2,0),(45,5290000,NULL,65,147,1,0),(46,6490000,NULL,66,155,1,0),(47,6490000,NULL,67,155,1,0),(48,6490000,NULL,68,155,1,0),(49,5290000,NULL,69,147,1,0),(50,22590000,NULL,70,152,1,0),(51,6690000,NULL,71,149,1,0),(52,6690000,NULL,72,149,1,0),(53,27990000,NULL,73,148,1,0),(54,15290000,NULL,74,151,1,0),(55,31190000,NULL,75,145,1,0),(56,9490000,NULL,75,146,1,0),(57,6490000,NULL,76,155,1,0),(58,6490000,NULL,77,155,1,0),(59,5290000,NULL,77,147,1,0);
/*!40000 ALTER TABLE `chi_tiet_don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc`
--

DROP TABLE IF EXISTS `danh_muc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danh_muc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ten_danh_muc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc`
--

LOCK TABLES `danh_muc` WRITE;
/*!40000 ALTER TABLE `danh_muc` DISABLE KEYS */;
INSERT INTO `danh_muc` VALUES (1,'LAPTOP'),(2,'ĐIỆN THOẠI'),(3,'PHỤ KIỆN'),(4,'THIẾT BỊ CHƠI GAME'),(5,'TIVI'),(6,'TABLET'),(7,'ĐỒNG HỒ'),(8,'SMARTWATCH'),(9,'MÀN HÌNH');
/*!40000 ALTER TABLE `danh_muc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_hang`
--

DROP TABLE IF EXISTS `don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `don_hang` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dia_chi_nhan` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ho_ten_nguoi_nhan` varchar(255) DEFAULT NULL,
  `ngay_dat_hang` datetime DEFAULT NULL,
  `ngay_giao_hang` datetime DEFAULT NULL,
  `ngay_nhan_hang` datetime DEFAULT NULL,
  `sdt_nhan_hang` varchar(255) DEFAULT NULL,
  `trang_thai_don_hang` varchar(255) DEFAULT NULL,
  `ma_nguoi_dat` bigint DEFAULT NULL,
  `ma_shipper` bigint DEFAULT NULL,
  `tong_gia_tri` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnwjiboxao1uvw1siemkvs1jb9` (`ma_nguoi_dat`),
  KEY `FKgndcrlvetoudr3jaif9b7ay37` (`ma_shipper`),
  CONSTRAINT `FKgndcrlvetoudr3jaif9b7ay37` FOREIGN KEY (`ma_shipper`) REFERENCES `nguoi_dung` (`id`),
  CONSTRAINT `FKnwjiboxao1uvw1siemkvs1jb9` FOREIGN KEY (`ma_nguoi_dat`) REFERENCES `nguoi_dung` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` VALUES (31,'bd','asdf','aaa','2018-12-01 14:38:26',NULL,NULL,'dsf','Đang chờ duyệt',NULL,NULL,0),(33,'hanoi',NULL,'áasdg','2025-04-07 14:31:57',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(34,'hanoi',NULL,'áasdg','2025-04-07 14:32:13',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(35,'hanoi',NULL,'áasdg','2025-04-07 14:32:25',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(36,'hanoi',NULL,'áasdg','2025-04-07 14:32:47',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(37,'hanoi',NULL,'áasdg','2025-04-07 14:33:06',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(38,'hanoi',NULL,'áasdg','2025-04-07 14:33:16',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(39,'hanoi',NULL,'áasdg','2025-04-07 14:33:33','2025-04-09 21:26:35',NULL,'09235723','Đang giao',NULL,3,7490000),(40,'hanoi',NULL,'áasdg','2025-04-07 14:37:51',NULL,NULL,'09235723','Đã bị hủy',NULL,NULL,7490000),(41,'124124',NULL,'123','2025-04-07 14:46:43','2025-04-09 00:40:28','2025-04-09 00:43:38','12345','Hoàn thành',2,3,87900000),(42,'Hà Nội',NULL,'Đỗ Trọng Phú','2025-04-09 18:47:18','2025-04-09 18:50:38','2025-04-09 18:51:01','0328049903','Hoàn thành',5,3,31190000),(43,NULL,NULL,NULL,'2025-04-10 18:15:26',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(44,NULL,NULL,NULL,'2025-04-10 18:16:44',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(45,NULL,NULL,NULL,'2025-04-10 18:27:55',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(46,NULL,NULL,NULL,'2025-04-10 18:31:38',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(47,NULL,NULL,NULL,'2025-04-10 18:41:26',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(48,NULL,NULL,NULL,'2025-04-10 18:41:56',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(49,NULL,NULL,NULL,'2025-04-10 18:42:02',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(50,NULL,NULL,NULL,'2025-04-10 18:44:10',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(51,NULL,NULL,NULL,'2025-04-10 18:44:20',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(52,NULL,NULL,NULL,'2025-04-10 18:48:04',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(53,NULL,NULL,NULL,'2025-04-10 18:49:53',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(54,NULL,NULL,NULL,'2025-04-10 18:54:34',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(55,NULL,NULL,NULL,'2025-04-10 19:00:52',NULL,NULL,NULL,'Đang xử lý',2,NULL,0),(56,NULL,NULL,NULL,'2025-04-10 20:04:50',NULL,NULL,NULL,'Đã bị hủy',2,NULL,0),(57,NULL,NULL,NULL,'2025-04-10 20:10:01',NULL,NULL,NULL,'Đã bị hủy',2,NULL,0),(58,'kkk',NULL,'kkk','2025-04-10 20:18:57',NULL,NULL,'kkk','Đã bị hủy',2,NULL,15290000),(59,NULL,NULL,NULL,'2025-04-10 20:24:45',NULL,NULL,NULL,'Đã bị hủy',1,NULL,0),(60,'khong',NULL,'khong co hi','2025-04-10 20:26:55',NULL,NULL,'khong','Đã bị hủy',1,NULL,19290000),(61,'123456','','admin','2025-04-10 20:40:30',NULL,NULL,'admin','Đang chờ giao',1,NULL,0),(62,'ad','','ad','2025-04-10 20:45:50',NULL,NULL,'ad','Đang xử lý',1,NULL,0),(63,'addd','','addd','2025-04-10 20:47:01',NULL,NULL,'addd','Đang xử lý',1,NULL,0),(64,'1111','','1111','2025-04-10 20:47:58',NULL,NULL,'1111','Đang chờ giao',1,NULL,0),(65,'kkk','','kkk','2025-04-10 20:53:25',NULL,NULL,'kkk','Đang chờ giao',1,NULL,0),(66,'kkk','','kkk','2025-04-10 20:55:56',NULL,NULL,'kkk','Đang xử lý',1,NULL,0),(67,'qưe','','qưe','2025-04-10 21:00:07',NULL,NULL,'qưe','Đang xử lý',1,NULL,0),(68,'123',NULL,'123','2025-04-10 21:03:47',NULL,NULL,'123','Đang chờ giao',1,NULL,6490000),(69,'fh','','fgh','2025-04-10 21:04:46',NULL,NULL,'fgh','Đang chờ giao',1,NULL,0),(70,'ccc',NULL,'ccc','2025-04-10 21:06:46',NULL,NULL,'ccc','Đang chờ giao',1,NULL,22590000),(71,'aaaaaa','','aaaaa','2025-04-10 21:08:39',NULL,NULL,'aaaaaa','Đang xử lý',1,NULL,0),(72,'SFUHJDS','','ádgkjsg','2025-04-10 21:10:23',NULL,NULL,'adhgfkj','Đang chờ giao',1,NULL,0),(73,'akjdgl','','zxm,vcb','2025-04-10 21:20:03',NULL,NULL,'akslfgfh','Đang chờ giao',1,NULL,0),(74,'ádfasgv','','ágfa','2025-04-10 21:27:54',NULL,NULL,'ádags','Đang chờ giao',1,NULL,0),(75,'12412412','','124555','2025-04-10 21:31:15','2025-04-12 05:55:32',NULL,'12312412','Đang giao',1,3,0),(76,'','','','2025-04-10 21:37:44',NULL,NULL,'','Đang xử lý',1,NULL,0),(77,'123545','','phú','2025-04-12 14:00:15',NULL,NULL,'123456','Đang chờ giao',1,NULL,0);
/*!40000 ALTER TABLE `don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gio_hang`
--

DROP TABLE IF EXISTS `gio_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gio_hang` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tong_tien` varchar(255) DEFAULT NULL,
  `ma_nguoi_dung` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKitverect56puwr47y7tyvy6er` (`ma_nguoi_dung`),
  CONSTRAINT `FKitverect56puwr47y7tyvy6er` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gio_hang`
--

LOCK TABLES `gio_hang` WRITE;
/*!40000 ALTER TABLE `gio_hang` DISABLE KEYS */;
INSERT INTO `gio_hang` VALUES (1,NULL,2),(2,NULL,1),(3,NULL,5),(4,NULL,NULL);
/*!40000 ALTER TABLE `gio_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hang_san_xuat`
--

DROP TABLE IF EXISTS `hang_san_xuat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hang_san_xuat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ten_hang_san_xuat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hang_san_xuat`
--

LOCK TABLES `hang_san_xuat` WRITE;
/*!40000 ALTER TABLE `hang_san_xuat` DISABLE KEYS */;
INSERT INTO `hang_san_xuat` VALUES (2,'Apple'),(3,'Asus'),(4,'Acer'),(5,'Dell'),(6,'HP'),(7,'Lenovo'),(8,'MSI'),(9,'Masstel'),(10,'Haier'),(11,'Samsung'),(12,'Oppo'),(13,'Xiaomi');
/*!40000 ALTER TABLE `hang_san_xuat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lien_he`
--

DROP TABLE IF EXISTS `lien_he`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lien_he` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_lien_he` varchar(255) DEFAULT NULL,
  `ngay_lien_he` datetime DEFAULT NULL,
  `ngay_tra_loi` datetime DEFAULT NULL,
  `noi_dung_lien_he` varchar(255) DEFAULT NULL,
  `noi_dung_tra_loi` varchar(255) DEFAULT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_nguoi_tra_loi` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6jm47uh7f94pc3wix0duvedde` (`ma_nguoi_tra_loi`),
  CONSTRAINT `FK6jm47uh7f94pc3wix0duvedde` FOREIGN KEY (`ma_nguoi_tra_loi`) REFERENCES `nguoi_dung` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lien_he`
--

LOCK TABLES `lien_he` WRITE;
/*!40000 ALTER TABLE `lien_he` DISABLE KEYS */;
INSERT INTO `lien_he` VALUES (1,'chimchic200@gmail.com','2025-04-09 21:31:04','2025-04-09 21:32:12','hello','khong co gi','Đã trả lời',NULL),(2,'dtp30092003@gmail.com','2025-08-18 15:32:11','2025-08-18 15:35:13','very good','cảm ơn đã đánh giá\n','Đã trả lời',NULL);
/*!40000 ALTER TABLE `lien_he` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoi_dung` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dia_chi` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,NULL,'admin@gmail.com','admin','$2a$10$/VFMNUPBKNVRMjxPFCYKZ.lKahoLQda0EaAxdqoun1w3DqwNLa2me','123456789'),(2,NULL,'member@gmail.com',NULL,'$2a$10$j7Upgupou72GBmukz0G6pOATk3wlCAgaoFCEqAhSvLToD/V/1wlpu',NULL),(3,NULL,'shipper@gmail.com',NULL,'$2a$10$u2B29HDxuWVYY3fUJ8R2qunNzXngfxij5GpvlFAEtIz3JpK/WFXF2',NULL),(4,'Ha Noi','jvgiveup@gmail.com','Pham Tuan','$2a$10$ZCqCO9gSWt8A8HNXAWq8luqfNbJm0uG3PsUlzry0aRLwO3VHQZTmy','123456'),(5,'Hà Nội','phudt@gmail.com','Phú','$2a$10$Xm8rYyjH1Mn2SQj.E1eNceINhDBkRCdZbbQ6cJnA5Xes7OoVrnWt.','0328049903');
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoidung_vaitro`
--

DROP TABLE IF EXISTS `nguoidung_vaitro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoidung_vaitro` (
  `ma_nguoi_dung` bigint NOT NULL,
  `ma_vai_tro` bigint NOT NULL,
  PRIMARY KEY (`ma_nguoi_dung`,`ma_vai_tro`),
  KEY `FKig6jxd861mqv02a8pn68r43fr` (`ma_vai_tro`),
  CONSTRAINT `FKig6jxd861mqv02a8pn68r43fr` FOREIGN KEY (`ma_vai_tro`) REFERENCES `vai_tro` (`id`),
  CONSTRAINT `FKocavcnspu1wcvp2w0s4usfgbf` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoidung_vaitro`
--

LOCK TABLES `nguoidung_vaitro` WRITE;
/*!40000 ALTER TABLE `nguoidung_vaitro` DISABLE KEYS */;
INSERT INTO `nguoidung_vaitro` VALUES (1,1),(5,1),(1,2),(2,2),(4,2),(3,3);
/*!40000 ALTER TABLE `nguoidung_vaitro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `san_pham`
--

DROP TABLE IF EXISTS `san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `san_pham` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cpu` varchar(255) DEFAULT NULL,
  `don_gia` bigint NOT NULL,
  `don_vi_ban` int NOT NULL,
  `don_vi_kho` int NOT NULL,
  `dung_luong_pin` varchar(255) DEFAULT NULL,
  `he_dieu_hanh` varchar(255) DEFAULT NULL,
  `man_hinh` varchar(255) DEFAULT NULL,
  `ram` varchar(255) DEFAULT NULL,
  `ten_san_pham` varchar(255) DEFAULT NULL,
  `thiet_ke` varchar(255) DEFAULT NULL,
  `thong_tin_bao_hanh` varchar(255) DEFAULT NULL,
  `thong_tin_chung` varchar(255) DEFAULT NULL,
  `ma_danh_muc` bigint DEFAULT NULL,
  `ma_hang_sx` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqss6n6gtx6lhb7flcka9un18t` (`ma_danh_muc`),
  KEY `FKchvjvgjnq8lbt9mjtyfn5pksq` (`ma_hang_sx`),
  CONSTRAINT `FKchvjvgjnq8lbt9mjtyfn5pksq` FOREIGN KEY (`ma_hang_sx`) REFERENCES `hang_san_xuat` (`id`),
  CONSTRAINT `FKqss6n6gtx6lhb7flcka9un18t` FOREIGN KEY (`ma_danh_muc`) REFERENCES `danh_muc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `san_pham`
--

LOCK TABLES `san_pham` WRITE;
/*!40000 ALTER TABLE `san_pham` DISABLE KEYS */;
INSERT INTO `san_pham` VALUES (3,'Intel, Core i5, 1.8 Ghz',23990000,0,100,'5800mAh',' Mac Os',' 13.3 inch LED-backlit','8 GB, LPDDR3, 1600 Mhz','Macbook Air 13 128GB MQD32SA/A (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(4,' Intel, Core i5, 1.8 Ghz',28990000,0,100,'6000mAh','Mac Os','13.3 inch LED-backlit',' 8 GB, LPDDR3, 1600 Mhz','Macbook Air 13 256GB MQD42SA/A (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(5,'Intel, Core M3, 1.2 GHz',33990000,0,150,'6000mAh','Mac Os',' 12 inch LED-backlit','8 GB, LPDDR3, 1866 MHz','Macbook 12 256GB (2017)','thiết kế không có thay đổi so với phiên bản 2016 nhưng Apple đã nâng cấp thêm bộ nhớ và giới thiệu bộ vi xử lý Intel thế hệ thứ 7','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,2),(6,' Intel, Core i5, 2.3 GHz',33990000,0,200,'6000mAh','Mac Os',' 13.3 inch LED-backlit',' 8 GB, LPDDR3, 2133MHz','Macbook Pro 13 inch 128GB (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(7,'Intel, Core i5, 2.3GHz',44990000,0,100,'7000mAh','Mac Os','13.3 inch, Retina (2560 x 1600 pixels)','8 GB, LPDDR3, 2133 MHz','Macbook Pro 13 Touch Bar 256 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(8,'Intel, Core i5, 2.3GHz',49990000,0,150,'7000mAh','Mac Os','13.3 inch, Retina (2560 x 1600 pixels)','8 GB, LPDDR3, 2133 MHz','Macbook Pro 13 Touch Bar 512 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(9,'Intel, Core i7, 2.2GHz',59990000,0,200,'7000mAh','Mac Os','15.4 inch, Retina (2880 x 1800 pix','16GB, LPDDR4, 2400MHz','Macbook Pro 15 Touch Bar 256 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(10,'Intel, Core i7, 2.2GHz',69990000,0,120,'7000mAh','Mac Os','15.4 inch, Retina (2880 x 1800 pi','16GB, LPDDR4, 2400MHz','Macbook Pro 15 Touch Bar 512 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2),(11,' Intel Celeron N3350',5490000,0,100,'7000','Windows 10','14 inch HD LED Glare',' 4 GB DDR3','Asus E402NA-GA034T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Bàn phím chiclet cùng Touchpad thông minh',1,3),(12,'Intel Celeron N3060',5490000,0,200,'7000','Windows 10','14.0 inch HD Ultra Slim 200nits','2 GB DDR3L 1600 MHz','Asus Vivobook E406SA-BV001T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Bàn phím chiclet cùng Touchpad thông minh',1,3),(13,'Intel Celeron N3060',5490000,0,200,'7000','Windows 10','14.0 inch HD Ultra Slim 200nits','2 GB DDR3 1600 MHz','Asus Vivobook E406SA-BV043T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','gọn,nhẹ, độ bền cao',1,3),(14,'Intel Celeron N4000',6690000,0,120,'7000',' Windows 10','15.6 inch Anti-Glare LED Backlit',' 4 GB DDR4 2400 MHz','Asus Vivobook X507MA-BR208T/Celeron N4000','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3),(15,'Intel Pentium N4200',7290000,0,110,'6000','Windows 10','15.6 inch HD LED',' 4 GB, DDR3L, 1600 MHz','Asus X541NA-GO012T/Pentium N4200','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3),(16,'Intel, Core i3-6100U',8990000,0,130,'7000','Windows 10 Home','15.6 inch LED Backlight','4 GB DDR4 2133 MHz','Asus X541UA-XX272T/Core i3 6100U','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3),(17,' Intel, Core i3, 2.0 GHz',8990000,0,200,'7000',' Free DOS','15.6 inchHD LED backlight','4 GB, DDR4, 2400MHz','Asus X541UA-GO1345','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','tinh tế đến từng chi tiết',1,3),(18,' Intel, Core i3, 2.0 GHz',10490000,0,300,'7000','Window 10',' 15.6 inchLED Backlight',' 4 GB, DDR4, 2400MHz','Asus X541UJ-DM544T/Core i3-6006U','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3),(19,' Intel, Celeron, 1.10 GHz',5990000,0,300,'7000',' Linux','5.6 inchAcer CineCrystal LED',' 4 GB DDR3L 1333 MHz','Acer AS A315-31-C8GB','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(20,' Intel Celeron N4000',6090000,0,100,'8000','Linux',' 15.6 inchs HD LED Backlight','4 GB DDR4 2133 MHz','Acer A315-32-C9A4 ','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(21,' Intel Core i3-7020U',8990000,0,100,'8000',' Linux','14.0 inchs HD LED','4 GB DDR4 2400 MHz','Acer E5-476-33BQ','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(22,' Intel Core i3-6006U',8990000,0,50,'5000','Linux','15.6 inch HD',' 4 GB DDR4 2133MHz','Acer A315-51-3932/Core i3-6006U','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(23,'Intel Core i3-7020U',9390000,0,300,'6000','Linux','15.6 inchs HD LED Backlight','4 GB DDR4 2133 MHz','Acer AS A315-51-325E','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(24,' Intel Core i3',9990000,0,130,'5000','Linux','15.6 inch  HD',' 4 GB DDR4 2133 MHz','Acer A315-51-364W','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(25,' Intel, Core i3, 2.4 Ghz',10690000,0,120,'5000','Free DOS',' 15.6 inchFull HD',' 4 GB, DDR4, 2133 MHz','Acer Aspire E5-575G-39QW','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(26,' Intel Core i5-8250U',16990000,0,130,'6000',' Windows 10 Home','14.0 inchs FHD IPS LCD',' 4 GB DDR4 2133 MHz','Acer Swift SF314-52-55UF','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4),(27,' Intel Pentium N3710',6990000,0,110,'5000',' Ubuntu','15.6 inchs HD Truelife',' 4 GB DDR3 1600 MHz','Dell Inspiron N3552','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(28,' Intel Pentium N3710',9990000,0,100,'5000','Ubuntu','15.6 inchs HD Truelife',' 4 GB DDR3 1600 MHz','Dell Inspiron N3567C','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(29,'Intel, Core i3, 2.0 GHz',9990000,0,100,'6000','Ubuntu 16.04','14 inchHD Anti-Glare LED','4 GB, DDR4, 2400MHz','Dell Inspiron N3467','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(30,' Intel Core i3-6006U',10890000,0,120,'7000','Linux','15.6 inchs',' 4 GB DDR4 2400 MHz','Dell Vostro 3568','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(31,' Intel, Core i3, 2.0 GHz',11190000,0,90,'6000',' Free DOS',' 15.6 inchHD LED',' 4 GB, DDR3L, 1600 Mhz','Dell Ins N3567','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(32,' Intel Core i3-7020U',11590000,0,80,'7000',' Ubuntu','15.6 inch HD Anti Glare LED','4 GB DDR4 2400 MHz','Dell Inspiron N3576','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(33,'Intel Core i3-7020U',11890000,0,110,'8000',' Windows 10 Home','15.6 inches Anti-Glare LED',' 4 GB DDR4 2400 MHz','Dell Vostro 3568','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(34,' Intel, Core i3, 2.40 GHz',12490000,0,100,'8000','Free DOS','14 inchHD Anti-Glare LED','4 GB, DDR4, 2133 MHz','Dell Vostro V5468/i3','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5),(35,' Intel Celeron',5990000,0,100,'5000','Linux',' 15.6 inchs',' 4 GB DDR3L 1600 MHz','HP 15-bs644TU/Celeron-N3060','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(36,' Intel Celeron N4000',6190000,0,70,'7000',' Windows 10 Home',' 15.6 inchs HD HD SVA ',' 4 GB DDR4 2400 MHz','HP 15-da0107TU/Celeron','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(37,' Intel Penitum N3710',6990000,0,120,'8000','Windows 10','15.6 inch',' 4GB DDR4','HP 15-bs648TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(38,' Intel, Core i3, 2.0 GHz',8990000,0,80,'8000',' Free Dos','15.6 inch LED-backlit',' 4GB, DDR4, 2133 MHz','HP 15-bs555TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(39,' Intel, Core i3, 2.0 GHz',10490000,0,90,'7000',' Free DOS',' 15.6 inchHD SVA BrightView',' 4 GB, DDR4, 2133 MHz','HP 15-bs637TX','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(40,' Intel Core i3-7100U',11490000,0,90,'6000',' Free DOS',' 15.6 inch',' 4GB DDR4','HP Pavilion 15-cc043TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(41,' Intel, Core i5, 2.50 GHz',12190000,0,100,'8000','Free DOS','15.6 inchHD SVA BrightView',' 4 GB, DDR4, 2133 MHz','HP 15-bs559TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(42,' Intel Core i3-7100U',12990000,0,150,'7000','Windows 10 Home Single',' 11.6 inch HD',' 4 GB DDR4 2133 MHz','HP Pavilion X360 11','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6),(43,'Intel, Celeron, 1.10 GHz',4990000,0,100,'6000',' Windows 10 EM',' 11.6 inchHD LED',' 2 GB, LPDDR4, 2400MHz','Lenovo Ideapad 120S-11IAP','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(44,' Intel, Pentium, 1.60 GHz',5490000,0,120,'5000',' Free DOS','14 inchHD LED backlight',' 4 GB, DDR3L, 1600 MHz','Lenovo IdeaPad 110','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(45,' Intel, Pentium, 1.10 GHz',7490000,0,80,'7000',' Windows 10',' 11.6 inchHD TN AG TOUCH',' 4 GB, DDR3L, 1600 MHz','Lenovo Yoga 310-11IAP','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(46,'Intel Core i3-6006U',8990000,0,120,'7000','FreeDOS',' 14.0 inchs HD LED',' 4 GB DDR4 2133 MHz','Lenovo Ideapad 320-14ISK ','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(47,'Intel Core i5-8250U',10990000,0,130,'5000',' Windows 10 Home',' 14.0 inchs HD LED','4 GB DDR4 2133 MHz','Lenovo Ideapad 330-14IKBR','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(48,' Intel, Core i5, 2.50 GHz',11290000,0,120,'5000','Linux',' 15.6 inchFull HD',' 4 GB, DDR4, 2133 MHz','Lenovo IdeaPad 310-15IKB','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(49,' Intel Core i5-8250U',13490000,0,130,'6000','Linux',' 14.0 inchs FHD IPS','4 GB DDR4 2400 MHz','Lenovo Ideapad 330S-14IKBR','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(50,' Intel, Core i5, 2.50 GHz',15990000,0,200,'7000','Windows 10 Single',' 15.6 inchAnti-Glare LED',' 4 GB, DDR4, 2133 MHz','Lenovo ThinkPad E570','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7),(51,' Intel, Core i5, 2.50 GHz',18990000,0,300,'7000',' Free DOS',' 15.6 inchWide-View','4 GB, DDR4, 2133 MHz','MSI GL62M 7RDX – 1036XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(52,' Intel Core i5-8250U',20990000,0,120,'8000','Windows 10 Home','14.0 inchs FHD IPS 72%',' 8 GB DDR4 2666 MHz','MSI PS42 8M-296VN/i5-8250U','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(53,' Intel Core i5-8300H',21490000,0,130,'7000',' Windows 10 Home','15.6 inchs Wideview 94%NTS','8 GB DDR4 2400MHz','MSI GV62 8RC-063VN/i5-8300H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(54,' Intel Core i5-8300H',22490000,1,139,'7000','Windows 10','15.6 inchs FullHD IPS 45% ',' 8 GB DDR4 2666 MHz','MSI GF63 8RC-203VN/I5-8300H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(55,' Intel, Core i7, 2.8 GHz',23990000,0,150,'8000','  DOS','  17.3 inch',' 8 GB, DDR4, 2400 MHz','MSI GL72M 7REX - 1427XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(56,' Intel, Core i7, 2.80 GHz',24990000,0,110,'7000',' Free DOS',' 15.6 inchWide-View',' 8 GB, DDR4, 2400MHz','MSI GF62 7RE-1818XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(57,' Intel Core i7-8750H',25990000,0,110,'7000','Windows 10 Home','15.6 inchs FullHD IPS 45%',' 8 GB DDR4 2666 MHz','MSI GF63 8RD-218VN/i7-8750H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(58,' Intel, Core i5, 2.50 GH',19990000,0,100,'8000','Free DOS','15.6 inchWide-View',' 8 GB, DDR4, 2133 MHz','MSI GL62M 7RDX-1817XVN','Thiết kế gọn gàng để di chuyển','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8),(59,'Intel Celeron N3350 1.10 GHz',4990000,0,100,'5000','Windows 10','13.3 inch FullHD IPS','3 GB LPDDR3 1600 MHz','Masstel L133','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9),(60,'Intel Celeron N3350 1.10 GHz',5490000,1,99,'5000','Windows 10','13.3 inch FullHD IPS','3 GB LPDDR3 1600 MHz',' Masstel L133/Celeron N3350','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9),(61,' Intel Celeron N3350 1.10 GHz',5990000,0,100,'4000','Windows 10',' 13.3 inch FullHD IPS',' 3 GB LPDDR3 1600 MHz','Masstel L133 Celeron N3350','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9),(62,'Intel Celeron N4100',6990000,0,50,'4000','Windows 10','13.3 inchs FullHD IPS','4 GB LPDDR4','Masstel L133 Pro/Celeron N4100','Thiết kế siêu mỏng nhẹ','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9),(63,' Intel Celeron N3350',4499000,0,50,'5000','FreeDOS','13.3 inchs IPS LCD',' 3 GB DDR3L 1600 MHz','Haier S1 HR-13M/Celeron N3350','Thiết kế siêu mỏng nhẹ','6 tháng','Một chiếc laptop đời mới thời trang, siêu mỏng nhẹ phục vụ tối ưu cho công việc nhưng lại trong tầm giá rất rẻ',1,10),(64,' Intel Pentium N4200',7490000,8,52,'4000','FreeDOS','13.3 inchs IPS LCD',' 6 GB DDR3L 1600 MHz','Haier S1 HR-13MZ/Pentium N4200','Thiết kế siêu mỏng nhẹ','6 tháng','Một chiếc laptop đời mới thời trang, siêu mỏng nhẹ phục vụ tối ưu cho công việc nhưng lại trong tầm giá rất rẻ',1,10),(89,NULL,2800500,0,100,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion 300 Surround 7.1',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led màu đỏ nổi bật \r\nCó thể sử dụng 3,5mm và USB linh hoạt',3,3),(90,NULL,3200000,0,120,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion Wireless',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3),(91,NULL,10000000,0,90,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion 500',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led RGB 16,8 triệu màu \r\nCó thể sử dụng 3,5mm và USB linh hoạt \r\nĐiều chỉnh qua bề mặt cảm ứng của củ tai',3,3),(92,NULL,4200123,0,100,NULL,NULL,NULL,NULL,'Tai nghe Asus STRIX 2.0- ROG Gaming Headset',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led RGB 16,8 triệu màu \r\nCó thể sử dụng 3,5mm và USB linh hoạt \r\nĐiều chỉnh qua bề mặt cảm ứng của củ tai',3,3),(93,NULL,3200000,0,50,NULL,NULL,NULL,NULL,'Tai nghe Asus Centurion - ROG Gaming Headset',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3),(94,NULL,1002356,0,60,NULL,NULL,NULL,NULL,'Tai Nghe Asus CERBERUS V2 - Red / Black',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3),(95,NULL,2500000,0,70,NULL,NULL,NULL,NULL,'Tai nghe Asus Gaming Asus Strix Pro',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3),(96,NULL,3000000,0,100,NULL,NULL,NULL,NULL,'Tai nghe Asus gaming ROG Strix Wireless',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3),(97,NULL,43000000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer Nitro 23.8\"VG240Y LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4),(98,NULL,50000000,0,200,NULL,NULL,NULL,NULL,'Monitor Acer 21.5\"R221Q LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4),(99,NULL,5200000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer 19.5\"K202HQL LED',NULL,'6 tháng','Kích Thước Màn Hình	27\'\' \r\nĐộ Sáng Màn Hình	350 cd/m² \r\nĐộ Phân Giải Màn Hình	2560 x 1440 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16,7 Triệu Màu \r\nGóc nhìn	178°/178° \r\nTín hiệu đầu vào	HDMI, DP \r\nMức Tiêu Thụ̣ Điện	26W',4,4),(100,NULL,2000000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer Nitro 27\"VG270 LED IPS',NULL,'6 tháng','Size	27” \r\nĐộ phân giải	Full HD (1920 x 1080) \r\nTỷ lệ khung hình	16:9 \r\nThời gian đáp ứng: 1 ms \r\nRefresh Rate	75 Hz \r\nHỗ trợ màu	16.7 million \r\nĐộ sáng	250 cd/m² \r\nBacklight	LED',4,4),(101,NULL,1200000,0,12,NULL,NULL,NULL,NULL,'Màn hình Acer 18.5\"EB192Q LED',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4),(102,NULL,12000000,0,123,NULL,NULL,NULL,NULL,'Màn hình Acer 27\"KG271 LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4),(103,NULL,300000,0,123,NULL,NULL,NULL,NULL,'Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch',NULL,'6 tháng','Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch',4,3),(104,NULL,4000000,0,123,NULL,NULL,NULL,NULL,'Keyboard ASUS ROG Strix Flare Cherry Blue switch',NULL,'6 tháng','Keyboard ASUS ROG Strix Flare Cherry Blue switch',4,3),(105,NULL,5432584,0,123,NULL,NULL,NULL,NULL,'Keyboard ASUS Strix Tactic Pro Mechanical Blue',NULL,'6 tháng','Keyboard ASUS Strix Tactic Pro Mechanical Blue',4,3),(106,NULL,1200000,0,123,NULL,NULL,NULL,NULL,'Mouse ASUS ROG Strix Impact',NULL,'2 tháng','Mouse ASUS ROG Strix Impact',4,3),(107,NULL,100000,0,123,NULL,NULL,NULL,NULL,'Mouse ASUS ROG Gladius II',NULL,'2 tháng','Chuột chơi game cho game thủ chuyên nghiệp của Asus ROG \r\nHệ thống led RGB tích hợp công nghệ Aura Sync với Mainboard và VGA \r\nThiết kế Ergonomics phù hợp với kiểu cầm chuột Palm Grip và Claw Grip \r\n',4,3),(108,NULL,3000000,0,123,NULL,NULL,NULL,NULL,'Mouse Asus ROG Spatha - Super MMO Gaming Mouse',NULL,'2 tháng','Mouse Asus ROG Spatha - Super MMO Gaming Mouse\r\n',4,3),(109,NULL,200000,0,1000,NULL,NULL,NULL,NULL,'MicroSDHC SILICON POWER UHS-I 32GB W/A',NULL,'2 tháng','MicroSDHC SILICON POWER UHS-I 32GB W/A',5,2),(110,NULL,30000,0,100,NULL,NULL,NULL,NULL,'HDD Western Caviar Black 500GB 7200Rpm, SATA3 6Gb/s, 64MB Cache',NULL,'2 tháng','HDD Western Caviar Black 500GB 7200Rpm, SATA3 6Gb/s, 64MB Cache\r\n',5,2),(111,NULL,1230000,0,100,NULL,NULL,NULL,NULL,'SSD Kingston Furry RGB 240GB Sata3 2.5\" (Doc 550MB/s, Ghi 480MB/s) - SHFR200/240G',NULL,'2 tháng','SSD Kingston Furry RGB 240GB Sata3 2.5\" (Doc 550MB/s, Ghi 480MB/s) - SHFR200/240G',5,3),(112,NULL,1230000,0,1000,NULL,NULL,NULL,NULL,'SSD AVEXIR S100 White 120GB SATA3 6Gb/s 2.5\" (Read 550MB/s, Write 275MB/s)',NULL,'2 tháng','SSD AVEXIR S100 White 120GB SATA3 6Gb/s 2.5\" (Read 550MB/s, Write 275MB/s)',5,2),(113,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Handy Kingston 32GB DATA TRAVELER DT SWIVL USB 3.0',NULL,'2 tháng','Handy Kingston 32GB DATA TRAVELER DT SWIVL USB 3.0',5,2),(114,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Handy Kingston 16GB DATA TRAVELER DT SWIVL USB 3',NULL,'2 tháng','Handy Kingston 16GB DATA TRAVELER DT SWIVL USB 3',5,2),(115,NULL,1200000,0,123,NULL,NULL,NULL,NULL,'USB3.0 SILICON POWER Marvel M50 16GB',NULL,'2 tháng','USB3.0 SILICON POWER Marvel M50 16GB',5,2),(116,NULL,3000000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N14UHP N300 3-in-1 Wi-Fi Router / Access Point / Repeater',NULL,'2 tháng','Router ASUS RT-N14UHP N300 3-in-1 Wi-Fi Router / Access Point / Repeater',6,3),(117,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N12+ 3-in-1 Router/AP/Range',NULL,'2 tháng','Router ASUS RT-N12+ 3-in-1 Router/AP/Range\r\n',6,3),(118,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N12HP (Black Diamond) N300 3-in-1 Wi-Fi Router / Access Point / Repeater',NULL,'2 tháng','Router ASUS RT-N12HP (Black Diamond) N300 3-in-1 Wi-Fi Router / Access Point / Repeater',6,3),(119,NULL,1000000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC86U',NULL,'2 tháng','Router ASUS RT-AC86U',6,3),(120,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-A1300UHP',NULL,'2 tháng','Router ASUS RT-A1300UHP',6,3),(121,NULL,200000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC68U',NULL,'2 tháng','Router ASUS RT-AC68U',6,3),(122,NULL,230000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC58U',NULL,'2 tháng','Router ASUS RT-AC58U',6,3),(123,NULL,1299999,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC53',NULL,'2 tháng','Router ASUS RT-AC53',6,3),(124,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân IP HikVision DS-2CD1023G0-I H265+',NULL,'2 tháng','Camera Thân IP HikVision DS-2CD1023G0-I H265+',7,2),(125,NULL,12000000,0,100,NULL,NULL,NULL,NULL,'Camera IP Hikvision Dome HIK -HDIP2820FH 2.0M',NULL,'2 tháng','Camera IP Hikvision Dome HIK -HDIP2820FH 2.0M',7,2),(126,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Camera Vantech FullHD HD-SDI VP-120HD',NULL,'2 tháng','Camera Vantech FullHD HD-SDI VP-120HD',7,2),(127,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Camera Dome Vantech VP- 4224T VT 1230',NULL,'2 tháng','Camera Dome Vantech VP- 4224T',7,2),(128,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân TVI HikVision DS-2CE16C0T-IRP',NULL,'2 tháng','Camera Thân TVI HikVision DS-2CE16C0T-IRP',7,2),(129,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân TVI HikVision DS-2CE16C0T-IRP',NULL,'2 tháng','Camera Thân TVI HikVision DS-2CE16C0T-IRP',7,2),(130,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera IP Vantech quay quét VT-6300C',NULL,'2 tháng','Camera IP Vantech quay quét VT-6300C',7,2),(131,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Camera IP Thân Hikvision DS-2CD2055FWD-I   H.265+',NULL,'2 tháng','Camera IP Thân Hikvision DS-2CD2055FWD-I   H.265+',7,3),(132,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Madcatz G.L.I.D.E.7',NULL,'2 tháng','Mouse Pad Madcatz G.L.I.D.E.7',8,3),(133,NULL,0,0,100,NULL,NULL,NULL,NULL,'Đế Làm Mát Laptop Cooling pad N99',NULL,'2 tháng','Đế Làm Mát Laptop Cooling pad N99',8,2),(134,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Razer Goliathus SKT T1 Edition',NULL,'2 tháng','Mouse Pad Razer Goliathus SKT T1 Edition - Soft Gaming Mouse Mat - Medium - Speed  (355mm x 254mm)',8,4),(135,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Razer Goliathus Medium 2014 (250x300mm)',NULL,'2 tháng','Mouse Pad Razer Goliathus Medium 2014 (250x300mm)',8,6),(136,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI 15m Vention',NULL,'1 tháng','Cable HDMI 15m Vention version 1.4',9,2),(137,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI dẹt 1.5m Vention ',NULL,'1 tháng','Cable HDMI dẹt 1.5m Vention version 1.4',9,3),(138,NULL,1500000,0,100,NULL,NULL,NULL,NULL,'Cable màn hình VGA ',NULL,'1 tháng','Cable màn hình VGA 1m -1.5m (Từ cổng 15 đực sang 15 đực)',9,5),(139,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI dẹt 10m Vention version 1.4',NULL,'2 tháng','Cable HDMI dẹt 10m Vention version 1.4',9,5),(140,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Bộ chuyển đổi HDMI sang VGA',NULL,'1 tháng','Bộ chuyển đổi HDMI sang VGA( có Audio) Vention Black Metal Type',9,5),(141,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Cáp chuyển HDMI sang VGA ',NULL,'3 tháng','Cáp chuyển HDMI sang VGA Hỗ trợ Full HD DHTV-C20 Orico',9,5),(142,NULL,140000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI 1.5m',NULL,'2 tháng','Cable HDMI 1.5m Version 2.0 hỗ trợ 4K 60Mhz',9,3),(143,NULL,1000000,0,100,NULL,NULL,NULL,NULL,'Cáp chuyển TypeC ',NULL,'2 tháng','Cáp chuyển TypeC sang 5 cổng HDMI/TypeC/2*USB 3.0 RCH3A-GD Orico',9,6),(144,NULL,16590000,0,10,NULL,NULL,NULL,NULL,'Điện thoại iPhone 16e 128GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 18\r\nChip xử lý (CPU):\r\nApple A18 6 nhân\r\nTốc độ CPU:\r\nHãng không công bố\r\nChip đồ họa (GPU):\r\nApple GPU 4 nhân\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n128 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n113 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2),(145,NULL,31190000,1,9,NULL,NULL,NULL,NULL,'Điện thoại iPhone 16 Pro Max 256GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 18\r\nChip xử lý (CPU):\r\nApple A18 Pro 6 nhân\r\nTốc độ CPU:\r\nHãng không công bố\r\nChip đồ họa (GPU):\r\nApple GPU 6 nhân\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n256 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n241 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2),(146,NULL,9490000,0,10,NULL,NULL,NULL,NULL,'Samsung Galaxy A56 5G-123GB',NULL,'6 tháng','Màn hình: Super AMOLED 6.7\" Full HD Camera sau: Chính 50 MP & Phụ 12 MP, 5 MP Camera trước: 12 MP Chip: Exynos 1580 8 nhân RAM: 8 GB Dung lượng lưu trữ: 128 GB SIM: 2 Nano SIM hoặc 2 eSIM hoặc 1 Nano SIM + 1 eSIMHỗ trợ 5G Pin, Sạc:	5000 mAh45 W',2,11),(147,NULL,5290000,0,10,NULL,NULL,NULL,NULL,'Điện thoại Xiaomi Redmi Note 14 8GB/128GB',NULL,'6 tháng','Chip xử lý (CPU):MediaTek Helio G99-Ultra 8 nhân Tốc độ CPU: 2 nhân 2.2 GHz & 6 nhân 2.0 GHz Chip đồ họa (GPU):Mali-G57 MC2 RAM:8 G Dung lượng lưu trữ:128 GB\r\n\r\n',2,13),(148,NULL,27990000,0,10,NULL,NULL,NULL,NULL,'Điện thoại Samsung Galaxy S25 Ultra 5G 12GB/256GB',NULL,'6 tháng','Chip xử lý (CPU):\r\nQualcomm Snapdragon 8 Elite For Galaxy 8 nhân\r\nTốc độ CPU:\r\n4.47 GHz\r\nChip đồ họa (GPU):\r\nAdreno 830\r\nRAM:\r\n12 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,11),(149,NULL,6690000,0,15,NULL,NULL,NULL,NULL,'Điện thoại Xiaomi Redmi Note 14 Pro 8GB/256GB',NULL,'6 tháng','Chip xử lý (CPU):\r\nMediaTek Helio G100-Ultra 8 nhân\r\nTốc độ CPU:\r\n2 nhân 2.2 GHz & 6 nhân 2.0 GHz\r\nChip đồ họa (GPU):\r\nMali-G57 MC2\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,13),(150,NULL,44990000,0,5,NULL,NULL,NULL,NULL,'Điện thoại Oppo Find N5 5G 16GB/512GB',NULL,'6 tháng','Camera sau:	Chính 50 MP & Phụ 50 MP, 8 MP\r\nCamera trước:	8 MP\r\nChip:	Qualcomm Snapdragon 8 Elite 8 nhân\r\nRAM:	16 GB\r\nDung lượng lưu trữ:	512 GB\r\nSIM:	2 Nano SIM hoặc 1 Nano SIM + 1 eSIMHỗ trợ 5G\r\nPin, Sạc:	5600 mAh80 W',2,12),(151,NULL,15290000,0,10,NULL,NULL,NULL,NULL,'Điện thoại OPPO Reno13 5G 12GB/256GB',NULL,'6 tháng','Hệ điều hành:\r\nAndroid 15\r\nChip xử lý (CPU):\r\nMediaTek Dimensity 8350 5G 8 nhân\r\nTốc độ CPU:\r\n1 nhân 3.35 GHz, 3 nhân 3.2 GHz & 4 nhân 2.2 GHz\r\nChip đồ họa (GPU):\r\nMali-G615\r\nRAM:\r\n12 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,12),(152,NULL,22590000,0,10,NULL,NULL,NULL,NULL,'Điện thoại iPhone 16 Plus 128GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 18\r\nChip xử lý (CPU):\r\nApple A18 6 nhân\r\nTốc độ CPU:\r\nHãng không công bố\r\nChip đồ họa (GPU):\r\nApple GPU 5 nhân\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n128 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n113 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2),(153,NULL,19290000,0,10,NULL,NULL,NULL,NULL,'Điện thoại iPhone 16 128GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 18\r\nChip xử lý (CPU):\r\nApple A18 6 nhân\r\nTốc độ CPU:\r\nHãng không công bố\r\nChip đồ họa (GPU):\r\nApple GPU 5 nhân\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n128 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n113 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2),(154,NULL,23990000,0,10,NULL,NULL,NULL,NULL,'Điện thoại Samsung Galaxy S24 Ultra 5G 12GB/256GB',NULL,'6 tháng','Hệ điều hành:\r\nAndroid 14\r\nChip xử lý (CPU):\r\nSnapdragon 8 Gen 3 for Galaxy\r\nTốc độ CPU:\r\n3.39 GHz\r\nChip đồ họa (GPU):\r\nAdreno 750\r\nRAM:\r\n12 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,11),(155,NULL,6490000,0,10,NULL,NULL,NULL,NULL,'Điện thoại Samsung Galaxy A16 5G 8GB/256GB',NULL,'6 tháng','Hệ điều hành:\r\nAndroid 14\r\nChip xử lý (CPU):\r\nMediaTek Dimensity 6300 5G 8 nhân\r\nTốc độ CPU:\r\n2.4 GHz\r\nChip đồ họa (GPU):\r\nMali-G57\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,11),(156,NULL,9690000,0,10,NULL,NULL,NULL,NULL,'Điện thoại Xiaomi Redmi Note 14 Pro+ 5G 8GB/256GB',NULL,'6 tháng','Hệ điều hành:\r\nAndroid 14\r\nChip xử lý (CPU):\r\nSnapdragon 7s Gen 3 5G 8 nhân\r\nTốc độ CPU:\r\n1 nhân 2.5 GHz, 3 nhân 2.4 GHz & 4 nhân 1.8 GHz\r\nChip đồ họa (GPU):\r\nĐang cập nhật\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n256 GB',2,13),(157,NULL,2990000,0,10,NULL,NULL,NULL,NULL,'Điện thoại iPhone 15 Pro Max 256GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 17\r\nChip xử lý (CPU):\r\nApple A17 Pro 6 nhân\r\nTốc độ CPU:\r\n3.78 GHz\r\nChip đồ họa (GPU):\r\nApple GPU 6 nhân\r\nRAM:\r\n8 GB\r\nDung lượng lưu trữ:\r\n256 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n241 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2),(158,NULL,19590000,0,10,NULL,NULL,NULL,NULL,'Điện thoại iPhone 15 Plus 128GB',NULL,'6 tháng','Hệ điều hành:\r\niOS 17\r\nChip xử lý (CPU):\r\nApple A16 Bionic\r\nTốc độ CPU:\r\n3.46 GHz\r\nChip đồ họa (GPU):\r\nApple GPU 5 nhân\r\nRAM:\r\n6 GB\r\nDung lượng lưu trữ:\r\n128 GB\r\nDung lượng còn lại (khả dụng) khoảng:\r\n113 GB\r\nDanh bạ:\r\nKhông giới hạn',2,2);
/*!40000 ALTER TABLE `san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vai_tro`
--

DROP TABLE IF EXISTS `vai_tro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vai_tro` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ten_vai_tro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vai_tro`
--

LOCK TABLES `vai_tro` WRITE;
/*!40000 ALTER TABLE `vai_tro` DISABLE KEYS */;
INSERT INTO `vai_tro` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_MEMBER'),(3,'ROLE_SHIPPER');
/*!40000 ALTER TABLE `vai_tro` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-18 21:44:53
