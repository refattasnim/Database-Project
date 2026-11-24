-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2026 at 04:56 AM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `full_name`, `email`) VALUES
(1, 'admin', 'Administrator', 'admin@examsystem.com');

-- --------------------------------------------------------

--
-- Table structure for table `admin_logins`
--

CREATE TABLE `admin_logins` (
  `admin_id` int(11) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `security_question_id` int(11) NOT NULL DEFAULT 1,
  `security_answer_hash` varchar(255) NOT NULL DEFAULT '',
  `reset_attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reset_locked_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `complete_exam_routine`
-- (See below for the actual view)
--
CREATE TABLE `complete_exam_routine` (
`course_code` varchar(20)
,`course_name` varchar(100)
,`exam_date` date
,`start_time` time
,`end_time` time
,`intake_section` varchar(10)
,`building` varchar(30)
,`room_number` varchar(20)
,`allocated_seats` int(11)
,`total_students` bigint(21)
,`invigilators` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credit` decimal(3,1) NOT NULL,
  `department` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_code`, `course_name`, `credit`, `department`) VALUES
(1, 'CSE 207', 'Database System', 3.0, 'CSE'),
(2, 'CSE 341', 'Advanced Programming', 3.0, 'CSE'),
(3, 'CSE 209', 'Operating System', 3.0, 'CSE'),
(4, 'CSE 221', 'Data Structure', 3.0, 'CSE'),
(5, 'CSE 205', 'Digital Logic Design', 3.0, 'CSE'),
(6, 'CSE 231', 'Algorithms', 3.0, 'CSE');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `semester` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `semester`) VALUES
(1, 55101, 1, '5th Semester'),
(2, 55101, 2, '5th Semester'),
(3, 55101, 3, '5th Semester'),
(4, 55102, 1, '5th Semester'),
(5, 55102, 2, '5th Semester'),
(6, 55102, 3, '5th Semester'),
(7, 55103, 1, '5th Semester'),
(8, 55103, 2, '5th Semester'),
(9, 55103, 3, '5th Semester'),
(10, 55104, 1, '5th Semester'),
(11, 55104, 2, '5th Semester'),
(12, 55104, 3, '5th Semester'),
(13, 55105, 1, '5th Semester'),
(14, 55105, 2, '5th Semester'),
(15, 55105, 3, '5th Semester'),
(16, 55106, 1, '5th Semester'),
(17, 55106, 2, '5th Semester'),
(18, 55106, 3, '5th Semester'),
(19, 55107, 1, '5th Semester'),
(20, 55107, 2, '5th Semester'),
(21, 55107, 3, '5th Semester'),
(22, 55108, 1, '5th Semester'),
(23, 55108, 2, '5th Semester'),
(24, 55108, 3, '5th Semester'),
(25, 55109, 1, '5th Semester'),
(26, 55109, 2, '5th Semester'),
(27, 55109, 3, '5th Semester'),
(28, 55110, 1, '5th Semester'),
(29, 55110, 2, '5th Semester'),
(30, 55110, 3, '5th Semester'),
(31, 55111, 1, '5th Semester'),
(32, 55111, 2, '5th Semester'),
(33, 55111, 3, '5th Semester'),
(34, 55112, 1, '5th Semester'),
(35, 55112, 2, '5th Semester'),
(36, 55112, 3, '5th Semester'),
(37, 55113, 1, '5th Semester'),
(38, 55113, 2, '5th Semester'),
(39, 55113, 3, '5th Semester'),
(40, 55114, 1, '5th Semester'),
(41, 55114, 2, '5th Semester'),
(42, 55114, 3, '5th Semester'),
(43, 55115, 1, '5th Semester'),
(44, 55115, 2, '5th Semester'),
(45, 55115, 3, '5th Semester'),
(46, 55116, 1, '5th Semester'),
(47, 55116, 2, '5th Semester'),
(48, 55116, 3, '5th Semester'),
(49, 55117, 1, '5th Semester'),
(50, 55117, 2, '5th Semester'),
(51, 55117, 3, '5th Semester'),
(52, 55118, 1, '5th Semester'),
(53, 55118, 2, '5th Semester'),
(54, 55118, 3, '5th Semester'),
(55, 55119, 1, '5th Semester'),
(56, 55119, 2, '5th Semester'),
(57, 55119, 3, '5th Semester'),
(58, 55120, 1, '5th Semester'),
(59, 55120, 2, '5th Semester'),
(60, 55120, 3, '5th Semester'),
(61, 55121, 1, '5th Semester'),
(62, 55121, 2, '5th Semester'),
(63, 55121, 3, '5th Semester'),
(64, 55122, 1, '5th Semester'),
(65, 55122, 2, '5th Semester'),
(66, 55122, 3, '5th Semester'),
(67, 55123, 1, '5th Semester'),
(68, 55123, 2, '5th Semester'),
(69, 55123, 3, '5th Semester'),
(70, 55124, 1, '5th Semester'),
(71, 55124, 2, '5th Semester'),
(72, 55124, 3, '5th Semester'),
(73, 55125, 1, '5th Semester'),
(74, 55125, 2, '5th Semester'),
(75, 55125, 3, '5th Semester'),
(76, 55126, 1, '5th Semester'),
(77, 55126, 2, '5th Semester'),
(78, 55126, 3, '5th Semester'),
(79, 55127, 1, '5th Semester'),
(80, 55127, 2, '5th Semester'),
(81, 55127, 3, '5th Semester'),
(82, 55128, 1, '5th Semester'),
(83, 55128, 2, '5th Semester'),
(84, 55128, 3, '5th Semester'),
(85, 55129, 1, '5th Semester'),
(86, 55129, 2, '5th Semester'),
(87, 55129, 3, '5th Semester'),
(88, 55130, 1, '5th Semester'),
(89, 55130, 2, '5th Semester'),
(90, 55130, 3, '5th Semester'),
(91, 55131, 1, '5th Semester'),
(92, 55131, 2, '5th Semester'),
(93, 55131, 3, '5th Semester'),
(94, 55132, 1, '5th Semester'),
(95, 55132, 2, '5th Semester'),
(96, 55132, 3, '5th Semester'),
(97, 55133, 1, '5th Semester'),
(98, 55133, 2, '5th Semester'),
(99, 55133, 3, '5th Semester'),
(100, 55134, 1, '5th Semester'),
(101, 55134, 2, '5th Semester'),
(102, 55134, 3, '5th Semester'),
(103, 55135, 1, '5th Semester'),
(104, 55135, 2, '5th Semester'),
(105, 55135, 3, '5th Semester'),
(106, 55136, 1, '5th Semester'),
(107, 55136, 2, '5th Semester'),
(108, 55136, 3, '5th Semester'),
(109, 55137, 1, '5th Semester'),
(110, 55137, 2, '5th Semester'),
(111, 55137, 3, '5th Semester'),
(112, 55138, 1, '5th Semester'),
(113, 55138, 2, '5th Semester'),
(114, 55138, 3, '5th Semester'),
(115, 55139, 1, '5th Semester'),
(116, 55139, 2, '5th Semester'),
(117, 55139, 3, '5th Semester'),
(118, 55140, 1, '5th Semester'),
(119, 55140, 2, '5th Semester'),
(120, 55140, 3, '5th Semester'),
(121, 56101, 4, '4th Semester'),
(122, 56101, 5, '4th Semester'),
(123, 56101, 6, '4th Semester'),
(124, 56102, 4, '4th Semester'),
(125, 56102, 5, '4th Semester'),
(126, 56102, 6, '4th Semester'),
(127, 56103, 4, '4th Semester'),
(128, 56103, 5, '4th Semester'),
(129, 56103, 6, '4th Semester'),
(130, 56104, 4, '4th Semester'),
(131, 56104, 5, '4th Semester'),
(132, 56104, 6, '4th Semester'),
(133, 56105, 4, '4th Semester'),
(134, 56105, 5, '4th Semester'),
(135, 56105, 6, '4th Semester'),
(136, 56106, 4, '4th Semester'),
(137, 56106, 5, '4th Semester'),
(138, 56106, 6, '4th Semester'),
(139, 56107, 4, '4th Semester'),
(140, 56107, 5, '4th Semester'),
(141, 56107, 6, '4th Semester'),
(142, 56108, 4, '4th Semester'),
(143, 56108, 5, '4th Semester'),
(144, 56108, 6, '4th Semester'),
(145, 56109, 4, '4th Semester'),
(146, 56109, 5, '4th Semester'),
(147, 56109, 6, '4th Semester'),
(148, 56110, 4, '4th Semester'),
(149, 56110, 5, '4th Semester'),
(150, 56110, 6, '4th Semester'),
(151, 56111, 4, '4th Semester'),
(152, 56111, 5, '4th Semester'),
(153, 56111, 6, '4th Semester'),
(154, 56112, 4, '4th Semester'),
(155, 56112, 5, '4th Semester'),
(156, 56112, 6, '4th Semester'),
(157, 56113, 4, '4th Semester'),
(158, 56113, 5, '4th Semester'),
(159, 56113, 6, '4th Semester'),
(160, 56114, 4, '4th Semester'),
(161, 56114, 5, '4th Semester'),
(162, 56114, 6, '4th Semester'),
(163, 56115, 4, '4th Semester'),
(164, 56115, 5, '4th Semester'),
(165, 56115, 6, '4th Semester'),
(166, 56116, 4, '4th Semester'),
(167, 56116, 5, '4th Semester'),
(168, 56116, 6, '4th Semester'),
(169, 56117, 4, '4th Semester'),
(170, 56117, 5, '4th Semester'),
(171, 56117, 6, '4th Semester'),
(172, 56118, 4, '4th Semester'),
(173, 56118, 5, '4th Semester'),
(174, 56118, 6, '4th Semester'),
(175, 56119, 4, '4th Semester'),
(176, 56119, 5, '4th Semester'),
(177, 56119, 6, '4th Semester'),
(178, 56120, 4, '4th Semester'),
(179, 56120, 5, '4th Semester'),
(180, 56120, 6, '4th Semester'),
(181, 56121, 4, '4th Semester'),
(182, 56121, 5, '4th Semester'),
(183, 56121, 6, '4th Semester'),
(184, 56122, 4, '4th Semester'),
(185, 56122, 5, '4th Semester'),
(186, 56122, 6, '4th Semester'),
(187, 56123, 4, '4th Semester'),
(188, 56123, 5, '4th Semester'),
(189, 56123, 6, '4th Semester'),
(190, 56124, 4, '4th Semester'),
(191, 56124, 5, '4th Semester'),
(192, 56124, 6, '4th Semester'),
(193, 56125, 4, '4th Semester'),
(194, 56125, 5, '4th Semester'),
(195, 56125, 6, '4th Semester'),
(196, 56126, 4, '4th Semester'),
(197, 56126, 5, '4th Semester'),
(198, 56126, 6, '4th Semester'),
(199, 56127, 4, '4th Semester'),
(200, 56127, 5, '4th Semester'),
(201, 56127, 6, '4th Semester'),
(202, 56128, 4, '4th Semester'),
(203, 56128, 5, '4th Semester'),
(204, 56128, 6, '4th Semester'),
(205, 56129, 4, '4th Semester'),
(206, 56129, 5, '4th Semester'),
(207, 56129, 6, '4th Semester'),
(208, 56130, 4, '4th Semester'),
(209, 56130, 5, '4th Semester'),
(210, 56130, 6, '4th Semester'),
(211, 56131, 4, '4th Semester'),
(212, 56131, 5, '4th Semester'),
(213, 56131, 6, '4th Semester'),
(214, 56132, 4, '4th Semester'),
(215, 56132, 5, '4th Semester'),
(216, 56132, 6, '4th Semester'),
(217, 56133, 4, '4th Semester'),
(218, 56133, 5, '4th Semester'),
(219, 56133, 6, '4th Semester'),
(220, 56134, 4, '4th Semester'),
(221, 56134, 5, '4th Semester'),
(222, 56134, 6, '4th Semester'),
(223, 56135, 4, '4th Semester'),
(224, 56135, 5, '4th Semester'),
(225, 56135, 6, '4th Semester'),
(226, 56136, 4, '4th Semester'),
(227, 56136, 5, '4th Semester'),
(228, 56136, 6, '4th Semester'),
(229, 56137, 4, '4th Semester'),
(230, 56137, 5, '4th Semester'),
(231, 56137, 6, '4th Semester'),
(232, 56138, 4, '4th Semester'),
(233, 56138, 5, '4th Semester'),
(234, 56138, 6, '4th Semester'),
(235, 56139, 4, '4th Semester'),
(236, 56139, 5, '4th Semester'),
(237, 56139, 6, '4th Semester'),
(238, 56140, 4, '4th Semester'),
(239, 56140, 5, '4th Semester'),
(240, 56140, 6, '4th Semester');

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `exam_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `exam_type` varchar(50) NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`exam_id`, `course_id`, `exam_type`, `academic_year`, `semester`) VALUES
(1, 1, 'Final Exam', '2026', '5th Semester'),
(2, 2, 'Final Exam', '2026', '5th Semester'),
(3, 3, 'Final Exam', '2026', '5th Semester'),
(4, 4, 'Final Exam', '2026', '4th Semester'),
(5, 5, 'Final Exam', '2026', '4th Semester'),
(6, 6, 'Final Exam', '2026', '4th Semester');

-- --------------------------------------------------------

--
-- Table structure for table `exam_room_allocations`
--

CREATE TABLE `exam_room_allocations` (
  `allocation_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `intake_section` varchar(10) NOT NULL,
  `allocated_seats` int(11) NOT NULL
) ;

--
-- Dumping data for table `exam_room_allocations`
--

INSERT INTO `exam_room_allocations` (`allocation_id`, `schedule_id`, `room_id`, `intake_section`, `allocated_seats`) VALUES
(1, 1, 1, '55-1', 20),
(2, 1, 2, '55-2', 20),
(3, 2, 4, '55-1', 20),
(4, 2, 5, '55-2', 20),
(5, 3, 2, '55-1', 20),
(6, 3, 3, '55-2', 20),
(7, 4, 3, '56-1', 20),
(8, 4, 4, '56-2', 20),
(9, 5, 1, '56-1', 20),
(10, 5, 2, '56-2', 20),
(11, 6, 4, '56-1', 20),
(12, 6, 5, '56-2', 20);

--
-- Triggers `exam_room_allocations`
--
DELIMITER $$
CREATE TRIGGER `validate_room_insert` BEFORE INSERT ON `exam_room_allocations` FOR EACH ROW BEGIN


    DECLARE room_capacity INT;
    DECLARE existing_seats INT;


    SELECT capacity
    INTO room_capacity
    FROM rooms
    WHERE room_id = NEW.room_id;


    SELECT COALESCE(SUM(allocated_seats), 0)
    INTO existing_seats
    FROM exam_room_allocations
    WHERE room_id = NEW.room_id
      AND schedule_id = NEW.schedule_id;


    -- Check room capacity
    IF NEW.allocated_seats <= 0
       OR existing_seats + NEW.allocated_seats > room_capacity THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Room capacity exceeded! Allocation cannot be inserted.';


    END IF;


    -- Check room time conflict
    IF EXISTS (
        SELECT 1
        FROM exam_room_allocations a


        JOIN exam_schedules es
            ON a.schedule_id = es.schedule_id


        JOIN exam_schedules new_es
            ON new_es.schedule_id = NEW.schedule_id


        WHERE a.room_id = NEW.room_id
          AND es.schedule_id <> NEW.schedule_id


          AND es.exam_date = new_es.exam_date


          AND new_es.start_time < es.end_time
          AND new_es.end_time > es.start_time


    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Room is already booked! Allocation cannot be inserted.';


    END IF;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_room_update` BEFORE UPDATE ON `exam_room_allocations` FOR EACH ROW BEGIN


    DECLARE room_capacity INT;
    DECLARE existing_seats INT;
    DECLARE assigned_students INT;


    SELECT capacity
    INTO room_capacity
    FROM rooms
    WHERE room_id = NEW.room_id;


    SELECT COALESCE(SUM(allocated_seats), 0)
    INTO existing_seats
    FROM exam_room_allocations
    WHERE room_id = NEW.room_id
      AND schedule_id = NEW.schedule_id
      AND allocation_id <> OLD.allocation_id;


    -- Check already assigned students
    SELECT COUNT(*)
    INTO assigned_students
    FROM exam_room_students
    WHERE allocation_id = OLD.allocation_id;


    -- Prevent seats from becoming less than assigned students
    IF NEW.allocated_seats < assigned_students THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Allocated seats cannot be less than assigned students!';


    END IF;


    -- Check room capacity
    IF NEW.allocated_seats <= 0
       OR existing_seats + NEW.allocated_seats > room_capacity THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Room capacity exceeded! Allocation cannot be updated.';


    END IF;


    -- Check room time conflict
    IF EXISTS (
        SELECT 1
        FROM exam_room_allocations a


        JOIN exam_schedules es
            ON a.schedule_id = es.schedule_id


        JOIN exam_schedules new_es
            ON new_es.schedule_id = NEW.schedule_id


        WHERE a.room_id = NEW.room_id
          AND a.allocation_id <> OLD.allocation_id
          AND a.schedule_id <> NEW.schedule_id
          AND es.exam_date = new_es.exam_date
          AND new_es.start_time < es.end_time
          AND new_es.end_time > es.start_time


    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Room is already booked! Allocation cannot be updated.';


    END IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `exam_room_students`
--

CREATE TABLE `exam_room_students` (
  `id` int(11) NOT NULL,
  `allocation_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_room_students`
--

INSERT INTO `exam_room_students` (`id`, `allocation_id`, `student_id`) VALUES
(1, 1, 55101),
(2, 1, 55102),
(3, 1, 55103),
(4, 1, 55104),
(5, 1, 55105),
(6, 1, 55106),
(7, 1, 55107),
(8, 1, 55108),
(9, 1, 55109),
(10, 1, 55110),
(11, 1, 55111),
(12, 1, 55112),
(13, 1, 55113),
(14, 1, 55114),
(15, 1, 55115),
(16, 1, 55116),
(17, 1, 55117),
(18, 1, 55118),
(19, 1, 55119),
(20, 1, 55120),
(21, 2, 55121),
(22, 2, 55122),
(23, 2, 55123),
(24, 2, 55124),
(25, 2, 55125),
(26, 2, 55126),
(27, 2, 55127),
(28, 2, 55128),
(29, 2, 55129),
(30, 2, 55130),
(31, 2, 55131),
(32, 2, 55132),
(33, 2, 55133),
(34, 2, 55134),
(35, 2, 55135),
(36, 2, 55136),
(37, 2, 55137),
(38, 2, 55138),
(39, 2, 55139),
(40, 2, 55140),
(41, 3, 55101),
(42, 3, 55102),
(43, 3, 55103),
(44, 3, 55104),
(45, 3, 55105),
(46, 3, 55106),
(47, 3, 55107),
(48, 3, 55108),
(49, 3, 55109),
(50, 3, 55110),
(51, 3, 55111),
(52, 3, 55112),
(53, 3, 55113),
(54, 3, 55114),
(55, 3, 55115),
(56, 3, 55116),
(57, 3, 55117),
(58, 3, 55118),
(59, 3, 55119),
(60, 3, 55120),
(61, 4, 55121),
(62, 4, 55122),
(63, 4, 55123),
(64, 4, 55124),
(65, 4, 55125),
(66, 4, 55126),
(67, 4, 55127),
(68, 4, 55128),
(69, 4, 55129),
(70, 4, 55130),
(71, 4, 55131),
(72, 4, 55132),
(73, 4, 55133),
(74, 4, 55134),
(75, 4, 55135),
(76, 4, 55136),
(77, 4, 55137),
(78, 4, 55138),
(79, 4, 55139),
(80, 4, 55140),
(81, 5, 55101),
(82, 5, 55102),
(83, 5, 55103),
(84, 5, 55104),
(85, 5, 55105),
(86, 5, 55106),
(87, 5, 55107),
(88, 5, 55108),
(89, 5, 55109),
(90, 5, 55110),
(91, 5, 55111),
(92, 5, 55112),
(93, 5, 55113),
(94, 5, 55114),
(95, 5, 55115),
(96, 5, 55116),
(97, 5, 55117),
(98, 5, 55118),
(99, 5, 55119),
(100, 5, 55120),
(101, 6, 55121),
(102, 6, 55122),
(103, 6, 55123),
(104, 6, 55124),
(105, 6, 55125),
(106, 6, 55126),
(107, 6, 55127),
(108, 6, 55128),
(109, 6, 55129),
(110, 6, 55130),
(111, 6, 55131),
(112, 6, 55132),
(113, 6, 55133),
(114, 6, 55134),
(115, 6, 55135),
(116, 6, 55136),
(117, 6, 55137),
(118, 6, 55138),
(119, 6, 55139),
(120, 6, 55140),
(121, 7, 56101),
(122, 7, 56102),
(123, 7, 56103),
(124, 7, 56104),
(125, 7, 56105),
(126, 7, 56106),
(127, 7, 56107),
(128, 7, 56108),
(129, 7, 56109),
(130, 7, 56110),
(131, 7, 56111),
(132, 7, 56112),
(133, 7, 56113),
(134, 7, 56114),
(135, 7, 56115),
(136, 7, 56116),
(137, 7, 56117),
(138, 7, 56118),
(139, 7, 56119),
(140, 7, 56120),
(141, 8, 56121),
(142, 8, 56122),
(143, 8, 56123),
(144, 8, 56124),
(145, 8, 56125),
(146, 8, 56126),
(147, 8, 56127),
(148, 8, 56128),
(149, 8, 56129),
(150, 8, 56130),
(151, 8, 56131),
(152, 8, 56132),
(153, 8, 56133),
(154, 8, 56134),
(155, 8, 56135),
(156, 8, 56136),
(157, 8, 56137),
(158, 8, 56138),
(159, 8, 56139),
(160, 8, 56140),
(161, 9, 56101),
(162, 9, 56102),
(163, 9, 56103),
(164, 9, 56104),
(165, 9, 56105),
(166, 9, 56106),
(167, 9, 56107),
(168, 9, 56108),
(169, 9, 56109),
(170, 9, 56110),
(171, 9, 56111),
(172, 9, 56112),
(173, 9, 56113),
(174, 9, 56114),
(175, 9, 56115),
(176, 9, 56116),
(177, 9, 56117),
(178, 9, 56118),
(179, 9, 56119),
(180, 9, 56120),
(181, 10, 56121),
(182, 10, 56122),
(183, 10, 56123),
(184, 10, 56124),
(185, 10, 56125),
(186, 10, 56126),
(187, 10, 56127),
(188, 10, 56128),
(189, 10, 56129),
(190, 10, 56130),
(191, 10, 56131),
(192, 10, 56132),
(193, 10, 56133),
(194, 10, 56134),
(195, 10, 56135),
(196, 10, 56136),
(197, 10, 56137),
(198, 10, 56138),
(199, 10, 56139),
(200, 10, 56140),
(201, 11, 56101),
(202, 11, 56102),
(203, 11, 56103),
(204, 11, 56104),
(205, 11, 56105),
(206, 11, 56106),
(207, 11, 56107),
(208, 11, 56108),
(209, 11, 56109),
(210, 11, 56110),
(211, 11, 56111),
(212, 11, 56112),
(213, 11, 56113),
(214, 11, 56114),
(215, 11, 56115),
(216, 11, 56116),
(217, 11, 56117),
(218, 11, 56118),
(219, 11, 56119),
(220, 11, 56120),
(221, 12, 56121),
(222, 12, 56122),
(223, 12, 56123),
(224, 12, 56124),
(225, 12, 56125),
(226, 12, 56126),
(227, 12, 56127),
(228, 12, 56128),
(229, 12, 56129),
(230, 12, 56130),
(231, 12, 56131),
(232, 12, 56132),
(233, 12, 56133),
(234, 12, 56134),
(235, 12, 56135),
(236, 12, 56136),
(237, 12, 56137),
(238, 12, 56138),
(239, 12, 56139),
(240, 12, 56140);

-- --------------------------------------------------------

--
-- Table structure for table `exam_schedules`
--

CREATE TABLE `exam_schedules` (
  `schedule_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `exam_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ;

--
-- Dumping data for table `exam_schedules`
--

INSERT INTO `exam_schedules` (`schedule_id`, `exam_id`, `exam_date`, `start_time`, `end_time`) VALUES
(1, 1, '2026-12-01', '10:00:00', '12:00:00'),
(2, 2, '2026-12-03', '10:00:00', '12:00:00'),
(3, 3, '2026-12-05', '10:00:00', '12:00:00'),
(4, 4, '2026-12-01', '14:00:00', '16:00:00'),
(5, 5, '2026-12-03', '14:00:00', '16:00:00'),
(6, 6, '2026-12-05', '14:00:00', '16:00:00');

--
-- Triggers `exam_schedules`
--
DELIMITER $$
CREATE TRIGGER `validate_invigilator_conflict_on_schedule_update` BEFORE UPDATE ON `exam_schedules` FOR EACH ROW BEGIN


    IF NEW.start_time >= NEW.end_time THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid exam time!';


    END IF;


    IF EXISTS (
        SELECT 1
        FROM invigilator_assignments ia2


        JOIN exam_room_allocations era2
            ON era2.allocation_id = ia2.allocation_id


        JOIN exam_schedules es
            ON es.schedule_id = era2.schedule_id


        WHERE era2.schedule_id <> OLD.schedule_id


          AND ia2.invigilator_code IN (
              SELECT ia1.invigilator_code
              FROM invigilator_assignments ia1


              JOIN exam_room_allocations era1
                  ON era1.allocation_id = ia1.allocation_id


              WHERE era1.schedule_id = OLD.schedule_id
          )


          AND es.exam_date = NEW.exam_date
          AND NEW.start_time < es.end_time
          AND NEW.end_time > es.start_time


    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Invigilator conflict! Schedule cannot be updated.';


    END IF;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_room_conflict_on_schedule_update` BEFORE UPDATE ON `exam_schedules` FOR EACH ROW BEGIN
    IF NEW.start_time >= NEW.end_time THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid exam time!';
    END IF;


    IF EXISTS (
        SELECT 1
        FROM exam_room_allocations a2
        JOIN exam_schedules es
            ON a2.schedule_id = es.schedule_id
        WHERE a2.schedule_id <> OLD.schedule_id
          AND a2.room_id IN (
              SELECT a1.room_id
              FROM exam_room_allocations a1
              WHERE a1.schedule_id = OLD.schedule_id
          )
          AND es.exam_date = NEW.exam_date
          AND NEW.start_time < es.end_time
          AND NEW.end_time > es.start_time
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room conflict! Schedule cannot be updated.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_student_exam_conflict_insert` BEFORE INSERT ON `exam_schedules` FOR EACH ROW BEGIN
IF NEW.start_time >= NEW.end_time THEN


    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid exam time!';


END IF;


    IF EXISTS (
        SELECT 1
        FROM enrollments en1


        JOIN enrollments en2
            ON en1.student_id = en2.student_id


        JOIN exams e1
            ON en1.course_id = e1.course_id


        JOIN exams e2
            ON en2.course_id = e2.course_id


        JOIN exam_schedules es
            ON es.exam_id = e2.exam_id


        WHERE e1.exam_id = NEW.exam_id
          AND e1.exam_id <> e2.exam_id


          AND e1.academic_year = e2.academic_year
          AND e1.semester = e2.semester
AND en1.semester = e1.semester
AND en2.semester = e2.semester




          AND en1.semester = en2.semester


          AND es.exam_date = NEW.exam_date


          AND NEW.start_time < es.end_time
          AND NEW.end_time > es.start_time


    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Student has another exam! Schedule cannot be inserted.';


    END IF;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_student_exam_conflict_update` BEFORE UPDATE ON `exam_schedules` FOR EACH ROW BEGIN
IF NEW.start_time >= NEW.end_time THEN


    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid exam time!';


END IF;


    IF EXISTS (
        SELECT 1
        FROM enrollments en1


        JOIN enrollments en2
            ON en1.student_id = en2.student_id


        JOIN exams e1
            ON en1.course_id = e1.course_id


        JOIN exams e2
            ON en2.course_id = e2.course_id


        JOIN exam_schedules es
            ON es.exam_id = e2.exam_id


        WHERE e1.exam_id = NEW.exam_id
          AND e1.exam_id <> e2.exam_id


          AND es.schedule_id <> OLD.schedule_id
AND en1.semester = e1.semester
AND en2.semester = e2.semester




          AND e1.academic_year = e2.academic_year
          AND e1.semester = e2.semester


          AND en1.semester = en2.semester


          AND es.exam_date = NEW.exam_date


          AND NEW.start_time < es.end_time
          AND NEW.end_time > es.start_time


    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Student has another exam! Schedule cannot be updated.';


    END IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invigilators`
--

CREATE TABLE `invigilators` (
  `invigilator_id` int(11) NOT NULL,
  `invigilator_code` varchar(10) NOT NULL,
  `invigilator_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `department` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invigilators`
--

INSERT INTO `invigilators` (`invigilator_id`, `invigilator_code`, `invigilator_name`, `email`, `department`) VALUES
(1, 'MDSHA', 'Md. Shakil Ahmed', 'mdsha@bubt.edu.bd', 'CSE'),
(2, 'IN', 'Itisha Nowrin', 'in@bubt.edu.bd', 'CSE'),
(3, 'MANQ', 'M. A. Nur Quraishi', 'manq@bubt.edu.bd', 'CSE'),
(4, 'HMF', 'Humayra Ferdous', 'hmf@bubt.edu.bd', 'CSE'),
(5, 'MHB', 'Mahbuba Habiba', 'mhb@bubt.edu.bd', 'CSE'),
(6, 'BJM', 'Bijon Mallik', 'bjm@bubt.edu.bd', 'CSE');

-- --------------------------------------------------------

--
-- Table structure for table `invigilator_assignments`
--

CREATE TABLE `invigilator_assignments` (
  `assignment_id` int(11) NOT NULL,
  `allocation_id` int(11) NOT NULL,
  `invigilator_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invigilator_assignments`
--

INSERT INTO `invigilator_assignments` (`assignment_id`, `allocation_id`, `invigilator_code`) VALUES
(1, 1, 'IN'),
(2, 1, 'MDSHA'),
(3, 2, 'HMF'),
(4, 2, 'MANQ'),
(5, 3, 'MANQ'),
(6, 3, 'MHB'),
(7, 4, 'BJM'),
(8, 4, 'MDSHA'),
(9, 5, 'BJM'),
(10, 5, 'HMF'),
(11, 6, 'IN'),
(12, 6, 'MHB'),
(13, 7, 'IN'),
(14, 7, 'MANQ'),
(15, 8, 'HMF'),
(16, 8, 'MHB'),
(17, 9, 'BJM'),
(18, 9, 'MDSHA'),
(19, 10, 'IN'),
(20, 10, 'MANQ'),
(21, 11, 'HMF'),
(22, 11, 'MHB'),
(23, 12, 'BJM'),
(24, 12, 'MDSHA');

--
-- Triggers `invigilator_assignments`
--
DELIMITER $$
CREATE TRIGGER `validate_invigilator_insert` BEFORE INSERT ON `invigilator_assignments` FOR EACH ROW BEGIN


    IF EXISTS (
        SELECT 1
        FROM invigilator_assignments ia
        JOIN exam_room_allocations era
            ON era.allocation_id = ia.allocation_id
        JOIN exam_schedules es
            ON es.schedule_id = era.schedule_id


        JOIN exam_room_allocations new_era
            ON new_era.allocation_id = NEW.allocation_id
        JOIN exam_schedules new_es
            ON new_es.schedule_id = new_era.schedule_id


        WHERE ia.invigilator_code = NEW.invigilator_code
          AND es.exam_date = new_es.exam_date
          AND new_es.start_time < es.end_time
          AND new_es.end_time > es.start_time
    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Invigilator has another exam duty! Assignment cannot be inserted.';


    END IF;


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_invigilator_update` BEFORE UPDATE ON `invigilator_assignments` FOR EACH ROW BEGIN


    IF EXISTS (
        SELECT 1
        FROM invigilator_assignments ia
        JOIN exam_room_allocations era
            ON era.allocation_id = ia.allocation_id
        JOIN exam_schedules es
            ON es.schedule_id = era.schedule_id


        JOIN exam_room_allocations new_era
            ON new_era.allocation_id = NEW.allocation_id
        JOIN exam_schedules new_es
            ON new_es.schedule_id = new_era.schedule_id


        WHERE ia.invigilator_code = NEW.invigilator_code
          AND ia.assignment_id <> OLD.assignment_id
          AND es.exam_date = new_es.exam_date
          AND new_es.start_time < es.end_time
          AND new_es.end_time > es.start_time
    ) THEN


        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Invigilator has another exam duty! Assignment cannot be updated.';


    END IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invigilator_logins`
--

CREATE TABLE `invigilator_logins` (
  `invigilator_code` varchar(10) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `security_question_id` int(11) NOT NULL,
  `security_answer_hash` varchar(255) NOT NULL,
  `reset_attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reset_locked_until` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `building` varchar(30) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `capacity` int(11) NOT NULL
) ;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `building`, `room_number`, `capacity`) VALUES
(1, 'A', '301', 40),
(2, 'A', '302', 40),
(3, 'A', '303', 35),
(4, 'B', '401', 50),
(5, 'B', '402', 50);

-- --------------------------------------------------------

--
-- Stand-in structure for view `room_allocation_report`
-- (See below for the actual view)
--
CREATE TABLE `room_allocation_report` (
`course_code` varchar(20)
,`course_name` varchar(100)
,`exam_date` date
,`start_time` time
,`end_time` time
,`intake_section` varchar(10)
,`building` varchar(30)
,`room_number` varchar(20)
,`capacity` int(11)
,`allocated_seats` int(11)
,`total_students` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `security_questions`
--

CREATE TABLE `security_questions` (
  `question_id` int(11) NOT NULL,
  `question_text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `security_questions`
--

INSERT INTO `security_questions` (`question_id`, `question_text`) VALUES
(2, 'What is the name of your childhood best friend?'),
(5, 'What is the name of your favorite teacher?'),
(6, 'What is your favorite book?'),
(3, 'What is your favorite childhood memory?'),
(1, 'What was the name of your first school?'),
(4, 'What was your childhood nickname?');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `department` varchar(50) NOT NULL,
  `intake_section` varchar(10) NOT NULL,
  `semester` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_name`, `email`, `department`, `intake_section`, `semester`) VALUES
(55101, 'Luckman Rafique', '55101@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55102, 'Shah Rokan', '55102@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55103, 'Taimur Rahman', '55103@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55104, 'Samiul Islam', '55104@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55105, 'Most. Zannatul', '55105@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55106, 'Md. Jahid Hasan', '55106@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55107, 'Sayem All Imam', '55107@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55108, 'Simran Bintae', '55108@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55109, 'Asma Anwar', '55109@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55110, 'Halima Tus Sadia', '55110@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55111, 'Debjani Debi', '55111@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55112, 'Fahim Montasir', '55112@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55113, 'Md Showkotul', '55113@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55114, 'MD. Yousuf Ali', '55114@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55115, 'Shimul Islam', '55115@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55116, 'Md. Rafi Imam', '55116@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55117, 'Sadia Afrin Kona', '55117@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55118, 'Sadika Tabassum', '55118@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55119, 'Sabrina Sultana', '55119@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55120, 'Marzia Islam', '55120@cse.bubt.edu.bd', 'CSE', '55-1', '5th Semester'),
(55121, 'Safa Akter', '55121@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55122, 'MD. Adnan Sami', '55122@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55123, 'Md.Siam Khan', '55123@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55124, 'Fahim Islam', '55124@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55125, 'Tanber Hasan', '55125@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55126, 'Kazi Yeaj Morshed', '55126@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55127, 'Refat Tasnim', '55127@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55128, 'Sirajum Munira', '55128@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55129, 'Nusrat Jahan', '55129@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55130, 'Babnus Fardah', '55130@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55131, 'Tanvir Ahmed', '55131@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55132, 'Maria Akter', '55132@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55133, 'Md. Faria Mia', '55133@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55134, 'Md Shadib Hossain', '55134@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55135, 'Bobita Akter', '55135@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55136, 'Syeda Naima Nabi', '55136@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55137, 'Sonchita Pramanik', '55137@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55138, 'Hamim Islam', '55138@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55139, 'Ononna Ray', '55139@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(55140, 'Jannatul Fardushi', '55140@cse.bubt.edu.bd', 'CSE', '55-2', '5th Semester'),
(56101, 'Taky Anwar Shad', '56101@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56102, 'Nadimul Islam', '56102@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56103, 'Musfiq Hasan', '56103@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56104, 'Muntasa Shafiqa', '56104@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56105, 'Abdullah Mahmud', '56105@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56106, 'Md Shourob Ali', '56106@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56107, 'Tahmid Shahid', '56107@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56108, 'Mst.Mitanur Akter', '56108@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56109, 'Abdullah Kawser', '56109@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56110, 'Hasnain (Mahir)', '56110@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56111, 'Khairun Minha', '56111@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56112, 'Md.Rafsan', '56112@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56113, 'Maria Sultana', '56113@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56114, 'Tanveer Hossain', '56114@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56115, 'Md. Mahimur', '56115@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56116, 'Priya Bhowmick', '56116@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56117, 'Abul Hasnat Aky', '56117@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56118, 'MD Tanvir Ahmmed', '56118@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56119, 'SM Kawser Nahin', '56119@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56120, 'Oalid Khan', '56120@cse.bubt.edu.bd', 'CSE', '56-1', '4th Semester'),
(56121, 'Sadia Afrin Khan', '56121@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56122, 'Md. Zunayed', '56122@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56123, 'MD A R Rahman Mahin', '56123@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56124, 'Nahid Hassan', '56124@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56125, 'Maroful Islam', '56125@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56126, 'Mustafijul Islam Emon', '56126@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56127, 'Muhammad Amir Hamza Khan', '56127@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56128, 'S M Nafizul Islam', '56128@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56129, 'Mahmudul Hasan', '56129@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56130, 'Tanvir Ahmed Sifa', '56130@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56131, 'Susma Ahmed', '56131@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56132, 'Fazla Rabbi', '56132@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56133, 'Md. Rasedul Islam', '56133@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56134, 'Md Moshiur Rahman', '56134@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56135, 'Md.Jony Islam', '56135@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56136, 'Maruf Billah Anas', '56136@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56137, 'Tushar Mia', '56137@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56138, 'Md Rahad', '56138@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56139, 'Al-Amin Oyon', '56139@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester'),
(56140, 'Abdullah al kawser', '56140@cse.bubt.edu.bd', 'CSE', '56-2', '4th Semester');

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_course_report`
-- (See below for the actual view)
--
CREATE TABLE `student_course_report` (
`student_id` int(11)
,`student_name` varchar(100)
,`email` varchar(100)
,`department` varchar(50)
,`intake_section` varchar(10)
,`semester` varchar(20)
,`course_code` varchar(20)
,`course_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `student_logins`
--

CREATE TABLE `student_logins` (
  `student_id` int(11) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `security_question_id` int(11) NOT NULL,
  `security_answer_hash` varchar(255) NOT NULL,
  `reset_attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reset_locked_until` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `admin_logins`
--
ALTER TABLE `admin_logins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_code` (`course_code`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD UNIQUE KEY `student_id` (`student_id`,`course_id`,`semester`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`exam_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `exam_room_allocations`
--
ALTER TABLE `exam_room_allocations`
  ADD PRIMARY KEY (`allocation_id`),
  ADD UNIQUE KEY `schedule_id` (`schedule_id`,`room_id`,`intake_section`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `exam_room_students`
--
ALTER TABLE `exam_room_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `allocation_id` (`allocation_id`,`student_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `exam_schedules`
--
ALTER TABLE `exam_schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD UNIQUE KEY `exam_id` (`exam_id`);

--
-- Indexes for table `invigilators`
--
ALTER TABLE `invigilators`
  ADD PRIMARY KEY (`invigilator_id`),
  ADD UNIQUE KEY `invigilator_code` (`invigilator_code`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `invigilator_assignments`
--
ALTER TABLE `invigilator_assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD UNIQUE KEY `allocation_id` (`allocation_id`,`invigilator_code`),
  ADD KEY `invigilator_code` (`invigilator_code`);

--
-- Indexes for table `invigilator_logins`
--
ALTER TABLE `invigilator_logins`
  ADD PRIMARY KEY (`invigilator_code`),
  ADD KEY `fk_invigilator_security_question` (`security_question_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_number` (`room_number`,`building`);

--
-- Indexes for table `security_questions`
--
ALTER TABLE `security_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD UNIQUE KEY `question_text` (`question_text`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `student_logins`
--
ALTER TABLE `student_logins`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `fk_student_security_question` (`security_question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `exam_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exam_room_allocations`
--
ALTER TABLE `exam_room_allocations`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_room_students`
--
ALTER TABLE `exam_room_students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT for table `exam_schedules`
--
ALTER TABLE `exam_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invigilators`
--
ALTER TABLE `invigilators`
  MODIFY `invigilator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `invigilator_assignments`
--
ALTER TABLE `invigilator_assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `security_questions`
--
ALTER TABLE `security_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- --------------------------------------------------------

--
-- Structure for view `complete_exam_routine`
--
DROP TABLE IF EXISTS `complete_exam_routine`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `complete_exam_routine`  AS SELECT `c`.`course_code` AS `course_code`, `c`.`course_name` AS `course_name`, `es`.`exam_date` AS `exam_date`, `es`.`start_time` AS `start_time`, `es`.`end_time` AS `end_time`, `era`.`intake_section` AS `intake_section`, `r`.`building` AS `building`, `r`.`room_number` AS `room_number`, `era`.`allocated_seats` AS `allocated_seats`, count(distinct `ers`.`student_id`) AS `total_students`, group_concat(distinct concat(`i`.`invigilator_code`,' - ',`i`.`invigilator_name`) separator ', ') AS `invigilators` FROM (((((((`exam_room_allocations` `era` join `exam_schedules` `es` on(`es`.`schedule_id` = `era`.`schedule_id`)) join `exams` `e` on(`e`.`exam_id` = `es`.`exam_id`)) join `courses` `c` on(`c`.`course_id` = `e`.`course_id`)) join `rooms` `r` on(`r`.`room_id` = `era`.`room_id`)) left join `exam_room_students` `ers` on(`ers`.`allocation_id` = `era`.`allocation_id`)) left join `invigilator_assignments` `ia` on(`ia`.`allocation_id` = `era`.`allocation_id`)) left join `invigilators` `i` on(`i`.`invigilator_code` = `ia`.`invigilator_code`)) GROUP BY `era`.`allocation_id`, `c`.`course_code`, `c`.`course_name`, `es`.`exam_date`, `es`.`start_time`, `es`.`end_time`, `era`.`intake_section`, `r`.`building`, `r`.`room_number`, `era`.`allocated_seats` ;

-- --------------------------------------------------------

--
-- Structure for view `room_allocation_report`
--
DROP TABLE IF EXISTS `room_allocation_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `room_allocation_report`  AS SELECT `c`.`course_code` AS `course_code`, `c`.`course_name` AS `course_name`, `es`.`exam_date` AS `exam_date`, `es`.`start_time` AS `start_time`, `es`.`end_time` AS `end_time`, `era`.`intake_section` AS `intake_section`, `r`.`building` AS `building`, `r`.`room_number` AS `room_number`, `r`.`capacity` AS `capacity`, `era`.`allocated_seats` AS `allocated_seats`, count(distinct `ers`.`student_id`) AS `total_students` FROM (((((`exam_room_allocations` `era` join `exam_schedules` `es` on(`es`.`schedule_id` = `era`.`schedule_id`)) join `exams` `e` on(`es`.`exam_id` = `e`.`exam_id`)) join `courses` `c` on(`e`.`course_id` = `c`.`course_id`)) join `rooms` `r` on(`era`.`room_id` = `r`.`room_id`)) left join `exam_room_students` `ers` on(`ers`.`allocation_id` = `era`.`allocation_id`)) GROUP BY `era`.`allocation_id`, `c`.`course_code`, `c`.`course_name`, `es`.`exam_date`, `es`.`start_time`, `es`.`end_time`, `era`.`intake_section`, `r`.`building`, `r`.`room_number`, `r`.`capacity`, `era`.`allocated_seats` ;

-- --------------------------------------------------------

--
-- Structure for view `student_course_report`
--
DROP TABLE IF EXISTS `student_course_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_course_report`  AS SELECT `s`.`student_id` AS `student_id`, `s`.`student_name` AS `student_name`, `s`.`email` AS `email`, `s`.`department` AS `department`, `s`.`intake_section` AS `intake_section`, `s`.`semester` AS `semester`, `c`.`course_code` AS `course_code`, `c`.`course_name` AS `course_name` FROM ((`enrollments` `e` join `students` `s` on(`e`.`student_id` = `s`.`student_id`)) join `courses` `c` on(`e`.`course_id` = `c`.`course_id`)) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_logins`
--
ALTER TABLE `admin_logins`
  ADD CONSTRAINT `admin_logins_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `exam_room_allocations`
--
ALTER TABLE `exam_room_allocations`
  ADD CONSTRAINT `exam_room_allocations_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `exam_schedules` (`schedule_id`),
  ADD CONSTRAINT `exam_room_allocations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);

--
-- Constraints for table `exam_room_students`
--
ALTER TABLE `exam_room_students`
  ADD CONSTRAINT `exam_room_students_ibfk_1` FOREIGN KEY (`allocation_id`) REFERENCES `exam_room_allocations` (`allocation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_room_students_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_schedules`
--
ALTER TABLE `exam_schedules`
  ADD CONSTRAINT `exam_schedules_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`);

--
-- Constraints for table `invigilator_assignments`
--
ALTER TABLE `invigilator_assignments`
  ADD CONSTRAINT `invigilator_assignments_ibfk_1` FOREIGN KEY (`allocation_id`) REFERENCES `exam_room_allocations` (`allocation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invigilator_assignments_ibfk_2` FOREIGN KEY (`invigilator_code`) REFERENCES `invigilators` (`invigilator_code`) ON DELETE CASCADE;

--
-- Constraints for table `invigilator_logins`
--
ALTER TABLE `invigilator_logins`
  ADD CONSTRAINT `fk_invigilator_login` FOREIGN KEY (`invigilator_code`) REFERENCES `invigilators` (`invigilator_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_invigilator_security_question` FOREIGN KEY (`security_question_id`) REFERENCES `security_questions` (`question_id`) ON UPDATE CASCADE;

--
-- Constraints for table `student_logins`
--
ALTER TABLE `student_logins`
  ADD CONSTRAINT `fk_student_login` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_security_question` FOREIGN KEY (`security_question_id`) REFERENCES `security_questions` (`question_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
