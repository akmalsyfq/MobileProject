-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 13, 2022 at 12:00 AM
-- Server version: 5.7.36-cll-lve
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ppdkpcom_bellacosashopdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(10000) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `name`, `address`, `phone`, `email`) VALUES
(13, 'AKMAL', '52, CITY CENTRE, KUALA LUMPUR, 55000, WILAYAH PERSEKUTUAN JITRA, MALAYSIA', '0136678855', 'jon7140@sfdi.site');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `email` varchar(50) NOT NULL,
  `code` varchar(10) NOT NULL,
  `cartquan` int(10) NOT NULL,
  `cartid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `historder`
--

CREATE TABLE `historder` (
  `receiptid` varchar(10) NOT NULL,
  `orderprocode` varchar(10) NOT NULL,
  `buyquan` varchar(10) NOT NULL,
  `custid` varchar(100) NOT NULL,
  `amountpaid` varchar(10) NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historder`
--

INSERT INTO `historder` (`receiptid`, `orderprocode`, `buyquan`, `custid`, `amountpaid`, `date`) VALUES
('tchbjz7d', '146323', '1', 'akmalsyfq@gmail.com', '47', '2022-02-06 11:37:04.476235'),
('tchbjz7d', '196360', '1', 'akmalsyfq@gmail.com', '19', '2022-02-06 11:37:04.477731'),
('tchbjz7d', '193264', '1', 'akmalsyfq@gmail.com', '25', '2022-02-06 11:37:04.478426'),
('qbsawrd0', '146323', '1', 'akmalsyfq@gmail.com', '47', '2022-02-06 11:40:14.927240'),
('qbsawrd0', '142563', '1', 'akmalsyfq@gmail.com', '25', '2022-02-06 11:40:14.928754'),
('qbsawrd0', '196360', '1', 'akmalsyfq@gmail.com', '19', '2022-02-06 11:40:14.929807'),
('qbsawrd0', '193264', '1', 'akmalsyfq@gmail.com', '25', '2022-02-06 11:40:14.930643'),
('d0yxj0xb', '146323', '2', 'akmalsyfq@gmail.com', '94', '2022-02-10 23:01:07.511132'),
('d0yxj0xb', '142563', '1', 'akmalsyfq@gmail.com', '25', '2022-02-10 23:01:07.514286'),
('d0yxj0xb', '196360', '1', 'akmalsyfq@gmail.com', '19', '2022-02-10 23:01:07.516476'),
('d0yxj0xb', '174935', '1', 'akmalsyfq@gmail.com', '37', '2022-02-10 23:01:07.518504'),
('hn1t4dq9', '146323', '1', 'akmalsyfq@gmail.com', '47', '2022-02-10 23:13:19.233224'),
('htokjl0o', '146323', '1', 'akmalsyfq@gmail.com', '47', '2022-02-11 19:35:01.437911'),
('pyynmttf', '193264', '1', 'akmalsyfq@gmail.com', '25', '2022-02-12 01:36:34.730444'),
('hy2kpjhm', '194684', '1', 'akmalsyfq@gmail.com', '43', '2022-02-12 01:40:30.116438'),
('fsycgrfr', '174484', '1', 'akmalsyfq@gmail.com', '18', '2022-02-12 01:43:21.424873'),
('pqbp4rj5', '185639', '1', 'akmalsyfq@gmail.com', '35', '2022-02-12 01:44:28.601421'),
('lkybvai3', '142563', '1', 'akmalsyfq@gmail.com', '25', '2022-02-12 15:55:32.620380'),
('kqfjtg62', '146323', '1', 'akmalsyfq@gmail.com', '47', '2022-02-12 22:17:38.759021'),
('kqfjtg62', '196360', '1', 'akmalsyfq@gmail.com', '19', '2022-02-12 22:17:38.760765'),
('2feqgtep', '196360', '2', 'kidiyon595@alfaceti.com', '38', '2022-02-12 22:43:12.620274'),
('2feqgtep', '193264', '1', 'kidiyon595@alfaceti.com', '25', '2022-02-12 22:43:12.621944'),
('2feqgtep', '194684', '2', 'kidiyon595@alfaceti.com', '86', '2022-02-12 22:43:12.622796'),
('ciq1iwa0', '194684', '1', 'jon7140@buntatukapro.com', '43', '2022-02-12 22:57:40.445601'),
('ciq1iwa0', '174484', '1', 'jon7140@buntatukapro.com', '18', '2022-02-12 22:57:40.447528'),
('wwm0tvdl', '193264', '2', 'jon7140@sfdi.site', '50', '2022-02-12 23:55:14.474547');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payid` int(5) NOT NULL,
  `payreceipt` varchar(10) NOT NULL,
  `payown` varchar(100) NOT NULL,
  `paypaid` varchar(100) NOT NULL,
  `paydate` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payid`, `payreceipt`, `payown`, `paypaid`, `paydate`) VALUES
(18, 'tchbjz7d', 'akmalsyfq@gmail.com', '91', '2022-02-06 11:37:04.479260'),
(21, 'hn1t4dq9', 'akmalsyfq@gmail.com', '47.0', '2022-02-10 23:13:19.237317'),
(23, 'pyynmttf', 'akmalsyfq@gmail.com', '25', '2022-02-12 01:36:34.733467'),
(29, 'lkybvai3', 'akmalsyfq@gmail.com', '25', '2022-02-12 15:55:32.623191'),
(31, 'kqfjtg62', 'akmalsyfq@gmail.com', '66', '2022-02-12 22:17:38.761764'),
(32, '2feqgtep', 'kidiyon595@alfaceti.com', '87', '2022-02-12 22:43:12.623780'),
(33, 'ciq1iwa0', 'jon7140@buntatukapro.com', '61', '2022-02-12 22:57:40.448450'),
(34, 'wwm0tvdl', 'jon7140@sfdi.site', '50.0', '2022-02-12 23:55:14.477145');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `prodesc` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `code`, `name`, `prodesc`, `quantity`, `price`) VALUES
(1, 146323, 'Zip Up Hoodie', 'Black plain hoodie easy for leisure wear. ', 30, 47),
(2, 142563, 'Space Tee', 'Red tee with astronaut graphics.', 29, 25),
(3, 196360, 'Tropical Top', 'Batwing sleeve top can be weared on many occasion.', 42, 19),
(4, 193264, 'Tee Set', 'White tee shirt that comes with short pants.', 27, 25),
(5, 175257, 'Black Cardigan', 'Blank black cardigan ready to be weared anytime.', 20, 35),
(6, 174935, 'Text Sweatshirt ', 'Olive green colored sweatshirt with text.', 18, 37),
(7, 194684, 'Graphics Sweatshirt', 'Cute sweatshirt with comfortable fabric cotton.', 19, 43),
(8, 128426, 'Green Shawl', 'Premium shawl with breathable material.', 25, 18),
(9, 174484, 'Black Shawl', 'Premium black shawl for muslimah', 21, 18),
(10, 185639, 'Barbie Shawl', 'Limited edition barbie shawl', 8, 35),
(11, 183974, 'Disney Shawl', 'Limited edition disney shawl.', 10, 35),
(12, 196357, 'Pleated Shawl', 'Pink pleated shawl with easy ironing material. ', 20, 14),
(13, 193574, 'Face Mask', 'Premium face mask for hijabis.', 50, 20),
(14, 185353, 'Princess Jubah', 'Jubah collection with exclusive fabric', 15, 48),
(15, 153468, 'Queen Jubah', 'New jubah collection handmade.', 20, 48);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_phone` int(100) DEFAULT NULL,
  `otp` int(6) NOT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_name`, `email`, `password`, `user_phone`, `otp`, `address`) VALUES
(9, 'admin', 'admin@shop.com', '8cb2237d0679ca88db6464eac60da96345513964', 147483647, 1, 'eeerwer'),
(10, 'akmalsyfq', 'akmalsyfq@gmail.com', '8cb2237d0679ca88db6464eac60da96345513964', 147542269, 1, 'kedaiwqnodwndiwondwiodnwiodnwqniowdnidniwdniodniwdnwiodnqwidnqwdqwidnqd'),
(48, 'Akmal', 'jon7140@sfdi.site', 'e0c0d1e31afcc5cd64c83de6b9b9685c1f5d5ee7', 136684566, 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartid`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payid`),
  ADD UNIQUE KEY `payreceipt` (`payreceipt`),
  ADD UNIQUE KEY `payid` (`payid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
