-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2022 at 06:51 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `polldesk`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `image`, `country_id`, `created_date`) VALUES
(1, 'admin', 'admin@gmail.com', '$2a$10$wkeKiqJnr5uebjJgSnDzVeGFx4YrZHwz8dk1xNtPP03F/IzK.OVcm', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `heading` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `create_date` datetime NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `update_date` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `company_id`, `heading`, `description`, `create_date`, `start_date`, `end_date`, `update_date`, `is_delete`) VALUES
(1, 1, 'Helllo ', 'Sanjay', '0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', 0),
(2, 1, 'dsadsadsad', 'fsefsdgdsgs', '0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', 0),
(3, 1, 'dsadsadsad', 'vhgjhgyjghj', '0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', 0),
(4, 1, 'sagfhjgs', 'fhdsgfds', '0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', 0),
(5, 1, 'dsadsa', 'fdfdfdfdfd', '2022-07-16 00:00:00', '2022-07-17 02:00:00', '2022-07-28 05:00:00', '2022-07-17 12:00:00', 0),
(6, 1, 'dsadsadsad', 'fsafsadfs', '2022-07-17 12:00:00', '2022-07-27 12:00:00', '2022-07-30 12:00:00', '2022-07-17 12:00:00', 1),
(7, 1, 'Elections in India for Parliament and State Legislatures are conducted by', 'Elections in India for Parliament and State Legislatures are conducted by', '2022-07-18 12:00:00', '2022-07-13 11:00:00', '2022-07-30 11:00:00', '2022-07-18 12:00:00', 0),
(8, 1, '3.  Members of Election Commission are appointed by........', '3.  Members of Election Commission are appointed by........\r\n\r\n', '2022-07-18 12:00:00', '2022-07-19 11:00:00', '2022-07-19 11:00:00', '2022-07-19 12:00:00', 0),
(9, 3, 'bje', 'party', '2022-07-26 12:00:00', '2022-07-27 11:00:00', '2022-08-05 11:00:00', '2022-07-26 12:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `company_id` varchar(30) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `contact` varchar(11) NOT NULL,
  `address` text NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 1 = Delete',
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `company_id`, `name`, `email`, `password`, `contact`, `address`, `is_delete`, `create_date`, `update_date`) VALUES
(1, NULL, 'ssw', 'ssw@gmail.com', '123456', '7485968577', 'test address', 1, '2022-07-14 20:03:45', '2022-07-17 06:49:08'),
(2, '2022SAN2', 'sanjay', 'sanjay@gmail.com', '123456', '7485968584', 'dsds', 1, '2022-07-24 16:48:11', '0000-00-00 00:00:00'),
(3, '2022SAN3', 'ssw', 'ssw@gmail.com', '$2b$10$BdrsSEr0tZVK1eIYAQ2fc.qCGyhJ7Spqix/SG2UauYOdduj05RVjS', '7485968584', 'dsad', 0, '2022-07-24 16:50:04', '0000-00-00 00:00:00'),
(4, '2022SAH4', 'sahaj', 'sahja@gmail.com', '$2b$10$TS0lWss6vmPHY3lLN6L/f.4YHFIi30jdau0J34FPbRLFIO5DnI18q', '7485968574', 'test test', 1, '2022-07-25 17:20:14', '2022-07-25 17:20:37');

-- --------------------------------------------------------

--
-- Table structure for table `enquiry`
--

CREATE TABLE `enquiry` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(250) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enquiry`
--

INSERT INTO `enquiry` (`id`, `user_id`, `title`, `description`, `image`, `created_date`) VALUES
(1, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:08:09'),
(2, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:08:46'),
(3, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:08:46'),
(4, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:11:27'),
(5, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:12:25'),
(6, 1, 'gh', 'vh', 'Screenshot 2022-03-19 170223.png', '2022-07-23 18:13:00');

-- --------------------------------------------------------

--
-- Table structure for table `question_answera`
--

CREATE TABLE `question_answera` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `a` varchar(256) NOT NULL,
  `b` varchar(256) NOT NULL,
  `c` varchar(256) NOT NULL,
  `d` varchar(256) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question_answera`
--

INSERT INTO `question_answera` (`id`, `company_id`, `category_id`, `question`, `a`, `b`, `c`, `d`, `create_date`, `update_date`, `is_delete`) VALUES
(1, 1, 3, '      Which of the following is not a feature of Election system in India?', 'Universal ', 'Secret ', 'Reservation ', 'Communal ', '2022-07-16 00:00:00', '2022-07-24 00:00:00', 0),
(2, 1, 1, 'dsfds', 'fdsfds', 'fsa', 'ds', 'fs', '2022-07-18 00:00:00', '2022-07-18 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `fcm` text DEFAULT NULL,
  `otp` varchar(6) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `otp_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1="verified"',
  `pruchase_number` tinyint(1) DEFAULT 0 COMMENT '1=''purchased''',
  `created_date` datetime DEFAULT NULL,
  `passport_data` text DEFAULT NULL,
  `passport_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1="verified"'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enquiry`
--
ALTER TABLE `enquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `question_answera`
--
ALTER TABLE `question_answera`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `enquiry`
--
ALTER TABLE `enquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `question_answera`
--
ALTER TABLE `question_answera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
