-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 18, 2022 at 04:35 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vereflix`
--

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `id` int(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `film`
--

INSERT INTO `film` (`id`, `name`) VALUES
(673, 'Harry Potter y el prisionero de Azkaban'),
(808, 'Shrek'),
(7660, NULL),
(76600, 'Avatar: El sentido del agua'),
(106646, 'El lobo de Wall Street'),
(417859, 'El gato con botas'),
(436270, 'Black Adam'),
(453395, 'Doctor Strange en el multiverso de la locura'),
(634649, 'Spider-Man: No Way Home'),
(720998, 'The Walking Dead: The Journey So Far'),
(766000, 'Holiday Beach'),
(773867, 'Seúl a toda pastilla'),
(829799, 'Paradise City'),
(830784, 'Lilo, mi amigo el cocodrilo'),
(852046, 'Atenea'),
(880841, 'Abandonada'),
(1013860, 'R.I.P.D 2: La rebelión de los condenados'),
(1045944, 'El extra navideño del Bebé Jefazo');

-- --------------------------------------------------------

--
-- Table structure for table `punctuate`
--

CREATE TABLE `punctuate` (
  `id` int(20) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `film_id` int(10) DEFAULT NULL,
  `note` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `punctuate`
--

INSERT INTO `punctuate` (`id`, `user_id`, `film_id`, `note`) VALUES
(24, 2, 453395, '6'),
(25, 2, 76600, '5'),
(26, 1, 76600, '6'),
(27, 1, 436270, '7'),
(28, 1, 436270, '7'),
(29, 1, 808, '8'),
(30, 2, 808, '7'),
(31, 2, 634649, '10'),
(32, 2, 830784, '5'),
(33, 2, 830784, '5'),
(34, 2, 1013860, '3'),
(35, 2, 634649, '10'),
(36, 2, 76600, '8'),
(37, 2, 106646, '9'),
(38, 2, 634649, '8'),
(39, 2, 634649, '10'),
(40, 2, 634649, '8'),
(41, 2, 436270, '7'),
(42, 2, 673, '7');

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE `record` (
  `id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id`, `film_id`, `user_id`) VALUES
(3, 880841, 2),
(5, 453395, 2),
(7, 106646, 2),
(8, 106646, 2),
(9, 852046, 2),
(10, 453395, 2),
(11, 436270, 2),
(12, 436270, 2),
(13, 829799, 2),
(14, 436270, 2),
(15, 76600, 2),
(16, 76600, 2),
(17, 76600, 1),
(18, 436270, 1),
(19, 436270, 1),
(20, 436270, 1),
(21, 436270, 1),
(22, 808, 1),
(23, 436270, 1),
(24, 436270, 1),
(25, 436270, 2),
(26, 436270, 2),
(27, 808, 2),
(28, 634649, 2),
(29, 634649, 2),
(30, 634649, 2),
(31, 634649, 2),
(32, 76600, 2),
(33, 76600, 2),
(34, 76600, 2),
(35, 766000, 1),
(36, 76600, 1),
(37, 76600, 2),
(38, 76600, 2),
(39, 76600, 2),
(40, 76600, 2),
(41, 773867, 2),
(42, 76600, 2),
(43, 76600, 2),
(44, 76600, 2),
(45, 76600, 2),
(46, 7660, 2),
(47, 76600, 2),
(48, 76600, 1),
(49, 76600, 2),
(50, 76600, 2),
(51, 76600, 2),
(52, 76600, 2),
(53, 76600, 2),
(54, 76600, 2),
(55, 76600, 2),
(56, 76600, 2),
(57, 76600, 2),
(58, 76600, 2),
(59, 76600, 2),
(60, 76600, 2),
(61, 76600, 2),
(62, 76600, 2),
(63, 76600, 2),
(64, 634649, 2),
(65, 76600, 2),
(66, 634649, 2),
(67, 634649, 2),
(68, 417859, 2),
(69, 76600, 2),
(70, 76600, 2),
(71, 453395, 2),
(72, 76600, 2),
(73, 76600, 2),
(74, 830784, 2),
(75, 1013860, 2),
(76, 634649, 2),
(77, 76600, 2),
(78, 76600, 2),
(79, 106646, 2),
(80, 634649, 2),
(81, 634649, 2),
(82, 634649, 2),
(83, 436270, 2),
(84, 436270, 2),
(85, 76600, 2),
(86, 634649, 2),
(87, 76600, 2),
(88, 673, 2),
(89, 673, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `password`, `username`, `address`) VALUES
(1, 'dimitri1998@hotmail.es', 'Dimitri', '$2a$08$/1IJCtHuGloVu7PibPLz8uVc6liO9.rSv0P7v5K1BR3FeSUoaq.Vm', 'dimi_rodri', 'calle vereda 7'),
(2, 'paco@gmail.com', 'Paco', '$2a$08$BL9ylDEIgXWi5WP4ruDEK.1cXAQGpX55VQRFiXs2VeVIhH8xFV91i', 'paco123', 'asdasjdaskm'),
(4, 'ville22@hotmail.com', 'Alejandro villegas', '$2a$08$gANcvZedEWZj88QV45KH.e6zJgTL0DOb4fGhz.XzDqyChdlyevkEi', 'ville22', 'calle granada 3'),
(5, 'dimitri1998@hotmail.es', 'fran', '$2a$08$9ywaPHSv42imRZSBtPWHaONIWZuPvR63zuanji28qv202QWTXEzae', 'francisco', 'asdad');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `punctuate`
--
ALTER TABLE `punctuate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `film_id` (`film_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `film_id` (`film_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `punctuate`
--
ALTER TABLE `punctuate`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `record`
--
ALTER TABLE `record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `punctuate`
--
ALTER TABLE `punctuate`
  ADD CONSTRAINT `punctuate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `punctuate_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `film` (`id`),
  ADD CONSTRAINT `punctuate_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `film` (`id`),
  ADD CONSTRAINT `record_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
