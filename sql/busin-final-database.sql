-- phpMyAdmin SQL Dump
-- version 5.1.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql-busin.alwaysdata.net
-- Generation Time: May 29, 2022 at 08:23 PM
-- Server version: 10.6.7-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `busin_main`
--
CREATE DATABASE IF NOT EXISTS `busin_main` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `busin_main`;

-- --------------------------------------------------------

--
-- Table structure for table `Announcement`
--

CREATE TABLE `Announcement` (
  `announcement_id` int(11) NOT NULL,
  `announcement_title` varchar(45) NOT NULL,
  `announcement_body` varchar(600) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


--
-- Table structure for table `AnnouncementReceiver`
--

CREATE TABLE `AnnouncementReceiver` (
  `announcement_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `time_saw` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `has_seen` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



--
-- Table structure for table `Company`
--

CREATE TABLE `Company` (
  `company_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Company`
--

INSERT INTO `Company` (`company_id`, `name`) VALUES
(1, 'Facebook'),
(2, 'Meta'),
(3, 'Bluezão Corps'),
(4, 'Disney');

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `department_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`department_id`, `name`, `company_id`) VALUES
(2, 'Accounting', 1),
(4, 'Sales', 1),
(5, 'Human Resources', 1),
(6, 'Quality Insurance', 1),
(7, 'Owner', 3),
(8, 'Owner', 4),
(9, 'IT Department', 4),
(10, 'Human Resources', 4),
(11, 'Testers', 1),
(12, 'Warehouse', 1),
(13, 'Testers', 4);

-- --------------------------------------------------------

--
-- Table structure for table `GroupMessage`
--

CREATE TABLE `GroupMessage` (
  `group_message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_body` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


--
-- Table structure for table `Message`
--

CREATE TABLE `Message` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_body` varchar(200) NOT NULL,
  `parent_message_id` int(11) DEFAULT NULL,
  `was_seen` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `email` varchar(320) DEFAULT NULL,
  `password` varchar(225) DEFAULT NULL,
  `profile_picture` longblob DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `is_adm` tinyint(4) NOT NULL,
  `is_owner` tinyint(4) NOT NULL DEFAULT 0,
  `reg_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`user_id`, `name`, `surname`, `position`, `email`, `password`, `profile_picture`, `department_id`, `is_adm`, `is_owner`, `reg_code`) VALUES
(2, 'Gabriel', 'Teste', 'Tester', 'teste2@gmail.com', '$2b$10$viGu2lUWsmUuoDP4RlZW/etV8h.NMW6MYljp0T.kNyVqdD0hMum4a', NULL, 2, 1, 0, 'UfMxz'),
(3, 'Omar', 'Cha', 'Backend Developer', 'teste1@gmail.com', '$2b$10$v/NPHEexcwA/KB4STre.8umkMZ8PBKjl.NEjSMbQywZ7BS1joVewy', NULL, 2, 1, 0, '00000'),
(4, 'Bluezão', 'Flausino', 'CEO', 'bluezao@gmail.com', '$2b$10$GQ42coIcXSFzQXGgWgvsVuuo8YL5p..XYWYGtqwK97G9nw1z6EMIG', NULL, 7, 0, 0, NULL),
(5, 'The', 'Owner', 'Singer', 'mickey@gmail.com', '$2b$10$iic.Ibc6nOmqhodZU9mObuJYLBKAPvDfDxcVGKy2N4BfMhC3KwXeG', NULL, 8, 1, 1, NULL),
(6, 'Not', 'Musk', 'Web Dev', 'noleksum@gmail.com', '$2b$10$0GvZw3LTqLmo5OOiQLLO..lTSnIjoT79jJPiB5IOYlcdMADtN93JC', NULL, 9, 0, 0, 'uYCRj'),
(7, 'Omar', 'Chá', 'Programmer', 'omar@gmail.com', '$2b$10$cqDCOMDdEN.QLIoehahXDumcUHYWYWVb.VU.1bb/9thtnEzAEUL.G', NULL, 9, 0, 0, 'xoUCG'),
(8, 'Arnorld', 'Reeves', 'Tester', NULL, NULL, NULL, 9, 0, 0, 'E8NSa'),
(9, 'Letizia', 'Vilariça', 'Recruiter', 'leticia@gmail.com', '$2b$10$gPxf0S2nzZjxE6xKXohhuO0rDsARY8RhM98Fj.FRlnl/1KtU4/SLe', NULL, 10, 0, 0, '2XAbV'),
(11, 'Alexandru', 'Póvoas', 'Manager', 'alexandre@gmail.com', '$2b$10$g811RHNlk4Jvg0IYnDEN9uG.xMC2rQOwV1LqNzb18pTbuKK7SfVjO', NULL, 10, 0, 0, 'MmOvb'),
(12, 'Richard', 'Gomes', 'Therapist', NULL, NULL, NULL, 5, 0, 0, 'iure1'),
(13, 'Jan', 'Xisto', 'Tester', 'jan@gmail.com', '$2b$10$Udtf0Q71PUk/XYVFj8sd.uL0ttNtAhhNZB32w9v1FqrxUygA9Hfry', NULL, 9, 0, 0, 'XQCES'),
(14, 'Lena', 'Brásio', 'Senior Developer', 'lena@gmail.com', '$2b$10$AfH2fu7aHVkBsd7JBfG/qunYmFOjnuVHsyBjzc8FRJ8EI3rDcd4NG', NULL, 9, 0, 0, '7ua2l'),
(16, 'Vanessa', 'Marcondes', 'Designer', 'vanessa@gmail.com', '$2b$10$fURDUyHDtu70414wht3Mee8Pp4UtL2ppnerXv6xTvop9P8Z5hSj7O', NULL, 9, 0, 0, 'tWVUo'),
(17, 'Shelby', 'Nash', 'Support', NULL, NULL, NULL, 10, 0, 0, '97KYR'),
(18, 'Terry', 'Yates', 'DevOps', NULL, NULL, NULL, 9, 0, 0, 'A9htZ'),
(19, 'Mariana', 'Nosoy Blanco', 'Tester', 'mariana@gmail.com', '$2b$10$rLo/QOf0tLVqyMZWj37RUOs31qFyftaB1hCZDNT3jdHlgiXtAw6By', NULL, 11, 0, 0, 'WVuuC'),
(23, 'Pedre', 'Silve', 'Recrutadore', 'pedre@gmail.com', '$2b$10$diw.V5N63GTJTLTpGQ2fjedNC4.inKxONFZU92L8rTfivy8QU69kG', NULL, 10, 0, 0, '5xcSy'),
(24, 'Jair', 'Bolsonaro', 'Capitão', 'bolsonaro@gmail.com', '$2b$10$br7kbw5Ynp4.aDzMHxDTTewA5X7xI2n1jfAAIdGxlpa8UG7i7IcLK', NULL, 13, 0, 0, 'gIAqK');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Announcement`
--
ALTER TABLE `Announcement`
  ADD PRIMARY KEY (`announcement_id`),
  ADD UNIQUE KEY `announcement_id_UNIQUE` (`announcement_id`),
  ADD KEY `sender_id_idx` (`sender_id`);

--
-- Indexes for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  ADD PRIMARY KEY (`announcement_id`,`receiver_id`),
  ADD KEY `receiver_id_idx` (`receiver_id`);

--
-- Indexes for table `Company`
--
ALTER TABLE `Company`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `idCompany_UNIQUE` (`company_id`);

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `department_id_UNIQUE` (`department_id`),
  ADD KEY `company_id_idx` (`company_id`);

--
-- Indexes for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  ADD PRIMARY KEY (`group_message_id`),
  ADD UNIQUE KEY `chat_message_id_UNIQUE` (`group_message_id`),
  ADD KEY `user_id_idx` (`sender_id`),
  ADD KEY `fk_GroupMessage_department_id_idx` (`department_id`);

--
-- Indexes for table `Message`
--
ALTER TABLE `Message`
  ADD PRIMARY KEY (`message_id`),
  ADD UNIQUE KEY `message_id_UNIQUE` (`message_id`),
  ADD KEY `fk_Message_User1_idx` (`sender_id`),
  ADD KEY `fk_Message_User2_idx` (`receiver_id`),
  ADD KEY `fk_Message_Message1_idx` (`parent_message_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  ADD UNIQUE KEY `reg_code_UNIQUE` (`reg_code`),
  ADD KEY `department_id_idx` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Announcement`
--
ALTER TABLE `Announcement`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `Company`
--
ALTER TABLE `Company`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Department`
--
ALTER TABLE `Department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  MODIFY `group_message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `Message`
--
ALTER TABLE `Message`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=458;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Announcement`
--
ALTER TABLE `Announcement`
  ADD CONSTRAINT `fk_Announcement_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `AnnouncementReceiver`
--
ALTER TABLE `AnnouncementReceiver`
  ADD CONSTRAINT `fk_AnnouncementReceiver_announcement_id` FOREIGN KEY (`announcement_id`) REFERENCES `Announcement` (`announcement_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_AnnouncementReceiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Department`
--
ALTER TABLE `Department`
  ADD CONSTRAINT `fk_Department_company_id` FOREIGN KEY (`company_id`) REFERENCES `Company` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `GroupMessage`
--
ALTER TABLE `GroupMessage`
  ADD CONSTRAINT `fk_GroupMessage_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_parent_message` FOREIGN KEY (`group_message_id`) REFERENCES `GroupMessage` (`group_message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_GroupMessage_user_id` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `fk_Message_Message1` FOREIGN KEY (`parent_message_id`) REFERENCES `Message` (`message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Receiver` FOREIGN KEY (`receiver_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Message_User_Sender` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `fk_User_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
