-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 03:45 PM
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
-- Database: `saledb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tborder`
--

CREATE TABLE `tborder` (
  `id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  `order_num` int(11) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `order_status` varchar(50) NOT NULL DEFAULT 'ยังไม่ชำระเงิน',
  `order_slip` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tborder`
--

INSERT INTO `tborder` (`id`, `user_name`, `product_id`, `order_num`, `order_date`, `order_status`, `order_slip`) VALUES
(1, 'handsome', 'CF0001', 1, '2024-10-16 09:55:14', 'ยังไม่ชำระเงิน', ''),
(2, 'handsome', 'CF0001', 1, '2024-10-16 09:55:15', 'ยังไม่ชำระเงิน', ''),
(3, 'handsome', 'CF0001', 1, '2024-10-16 09:55:15', 'ยังไม่ชำระเงิน', ''),
(4, 'handsome', 'CF0001', 1, '2024-10-16 09:55:15', 'ยังไม่ชำระเงิน', ''),
(5, 'handsome', 'CF0001', 1, '2024-10-16 09:55:16', 'ยังไม่ชำระเงิน', ''),
(6, 'handsome', 'CF0001', 1, '2024-10-16 09:55:16', 'ยังไม่ชำระเงิน', ''),
(7, 'handsome', 'CF0001', 1, '2024-10-16 09:55:16', 'ยังไม่ชำระเงิน', ''),
(8, 'handsome', 'CF0001', 1, '2024-10-16 10:04:04', 'ยังไม่ชำระเงิน', ''),
(9, 'handsome', 'CF0008', 3, '2024-10-16 11:07:45', 'ยังไม่ชำระเงิน', ''),
(10, 'handsome', 'CF0001', 1, '2025-09-18 16:29:50', 'ยังไม่ชำระเงิน', ''),
(11, 'handsome', 'CF0001', 1, '2025-09-18 16:30:06', 'ยังไม่ชำระเงิน', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbproducts`
--

CREATE TABLE `tbproducts` (
  `product_id` varchar(10) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_price` float NOT NULL,
  `product_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbproducts`
--

INSERT INTO `tbproducts` (`product_id`, `product_name`, `product_price`, `product_image`) VALUES
('CF0001', 'Espresso', 65, 'images/coffee01.png'),
('CF0002', 'Latte', 45, 'images/coffee02.png'),
('CF0003', 'Cappuccino', 99, 'images/coffee03.png'),
('CF0004', 'Mocha', 120, 'images/coffee04.png'),
('CF0005', 'Americano', 80, 'images/coffee05.png'),
('CF0006', 'Macchiato', 55, 'images/coffee06.png'),
('CF0007', 'Flat White', 50, 'images/coffee07.png'),
('CF0008', 'Drip Coffee', 50, 'images/coffee08.png'),
('CF0009', 'Siphon Coffee', 100, 'images/coffee09.png'),
('CF0010', 'Affogato', 102, 'images/coffee10.png'),
('CF0011', 'Cold Brew', 60, 'images/coffee11.png');

-- --------------------------------------------------------

--
-- Table structure for table `tbusers`
--

CREATE TABLE `tbusers` (
  `user_name` varchar(50) NOT NULL,
  `pass_word` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `user_status` varchar(10) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbusers`
--

INSERT INTO `tbusers` (`user_name`, `pass_word`, `firstname`, `lastname`, `user_status`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 'สตางค์', 'พารวย', 'admin'),
('handsome', '3eb7b41e6f51dab06e324b3c81b4d5f4', 'บารมี', 'สายบุตร', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tborder`
--
ALTER TABLE `tborder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbproducts`
--
ALTER TABLE `tbproducts`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `tbusers`
--
ALTER TABLE `tbusers`
  ADD PRIMARY KEY (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tborder`
--
ALTER TABLE `tborder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
