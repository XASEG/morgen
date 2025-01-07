-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 07, 2025 at 03:49 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sekolahs`
--

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `guru_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `class_name`, `guru_id`, `created_at`, `updated_at`) VALUES
(1, 'RPL', 1, '2025-01-20 02:44:08', '2025-01-28 02:44:08');

-- --------------------------------------------------------

--
-- Table structure for table `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi_pengumuman` text NOT NULL,
  `ID_pengirim` int(11) NOT NULL,
  `level_target` enum('wakil','wali kelas','orang tua','siswa','semua') NOT NULL,
  `id_kelas` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pengumuman`
--

INSERT INTO `pengumuman` (`id`, `judul`, `isi_pengumuman`, `ID_pengirim`, `level_target`, `id_kelas`, `created_at`, `updated_at`) VALUES
(1, 'wiw', 'pengumuman', 1, 'wali kelas', 1, '2025-01-20 02:46:46', '2025-01-25 02:46:46');

-- --------------------------------------------------------

--
-- Table structure for table `target_pengumuman`
--

CREATE TABLE `target_pengumuman` (
  `id` int(11) NOT NULL,
  `id_pengumuman` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `baca_pengumuman` tinyint(1) DEFAULT 0,
  `waktu_baca` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `target_pengumuman`
--

INSERT INTO `target_pengumuman` (`id`, `id_pengumuman`, `id_user`, `baca_pengumuman`, `waktu_baca`) VALUES
(1, 1, 1, 0, '2025-01-28 02:49:12');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `level` enum('kepalasekolah','nama','email','phone','level') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `email`, `phone`, `level`, `created_at`, `update_at`) VALUES
(1, 'cihuy', 'keren@gmail.com', '086521342', 'kepalasekolah', '2025-01-20 02:38:56', '2025-01-21 02:38:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guru_id` (`guru_id`);

--
-- Indexes for table `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ID_pengirim` (`ID_pengirim`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `target_pengumuman`
--
ALTER TABLE `target_pengumuman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pengumuman` (`id_pengumuman`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `target_pengumuman`
--
ALTER TABLE `target_pengumuman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_ibfk_1` FOREIGN KEY (`guru_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD CONSTRAINT `pengumuman_ibfk_1` FOREIGN KEY (`ID_pengirim`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pengumuman_ibfk_2` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `target_pengumuman`
--
ALTER TABLE `target_pengumuman`
  ADD CONSTRAINT `target_pengumuman_ibfk_1` FOREIGN KEY (`id_pengumuman`) REFERENCES `pengumuman` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `target_pengumuman_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
