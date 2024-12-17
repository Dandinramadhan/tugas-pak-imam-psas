-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2024 at 01:28 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ruangbuku`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `pengarang` varchar(50) NOT NULL,
  `penerbit` varchar(25) NOT NULL,
  `kategori` enum('Fiction','Science','History','Fantasy','Biography','Horor') NOT NULL,
  `sinopsis` text DEFAULT NULL,
  `tahun_terbit` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `judul`, `pengarang`, `penerbit`, `kategori`, `sinopsis`, `tahun_terbit`) VALUES
(1, 'matahari', 'tere liye ', 'andika', 'Science', 'tentang matahari', '2024'),
(2, 'sea of quanta', 'tere liye ', 'rahmat', 'Fiction', 'kedalaman laut', '2024'),
(3, 'akazora', 'tere liye', 'siva', 'History', 'tentang festival', '2024'),
(5, 'jmlkgjvjlm', 'retgret', 'ertgry', 'Fiction', 'hbftgjhftgjhny', '2024'),
(7, 'akuuuu', 'herman', 'hiuhiuhk', 'History', 'ihiuhiu', '2024'),
(8, 'herman', 'herman', 'herman', 'Horor', 'herman', '2024'),
(9, 'kjewld', 'adjlaksjdlsad', 'ocdewajfdlia', 'Horor', 'lkesmlkfj', '2024'),
(10, 'andi', 'andi', 'andi', 'Fantasy', 'andi', '2024');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
