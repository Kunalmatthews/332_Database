# ************************************************************
# Sequel Pro SQL dump
# Version 4237
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table courses
# ------------------------------------------------------------


DROP TABLE IF EXISTS `courses`;

CREATE TABLE `courses` (
  `number` int(11) unsigned NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `textbook` varchar(100) NOT NULL DEFAULT '',
  `units` int(1) NOT NULL,
  `department_number` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`number`),
  KEY `department_number` (`department_number`),
  CONSTRAINT `courses_department_number_foreign` FOREIGN KEY (`department_number`) REFERENCES `departments` (`number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;

INSERT INTO `courses` (`number`, `title`, `textbook`, `units`, `department_number`)
VALUES
	(16012,'CPSC 121 (C++ Object Oriented Progeramming)','Advanced C++',1,NULL),
	(16084,'CPSC 323 (Compliers)','Compilers and Computer Systems',1,NULL),
	(16125,'CPSC 240 (Assembly Language)','Assembly for Dummies',2,NULL),
	(18995,'CPSC 315 (Social and Ethical Issues in Computing)','Ethics and Social Responsibility',1,NULL);

/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table course_prerequisite
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course_prerequisite`;

CREATE TABLE `course_prerequisite` (
  `parent_course` int(11) unsigned NOT NULL,
  `child_course` int(11) unsigned NOT NULL,
  PRIMARY KEY (`parent_course`,`child_course`),
  KEY `course_prerequisite_child_course_foreign` (`child_course`),
  CONSTRAINT `course_prerequisite_child_course_foreign` FOREIGN KEY (`child_course`) REFERENCES `courses` (`number`) ON DELETE CASCADE,
  CONSTRAINT `course_prerequisite_parent_course_foreign` FOREIGN KEY (`parent_course`) REFERENCES `courses` (`number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `course_prerequisite` WRITE;
/*!40000 ALTER TABLE `course_prerequisite` DISABLE KEYS */;

INSERT INTO `course_prerequisite` (`parent_course`, `child_course`)
VALUES
	(16012,16084),
	(16012,18995),
	(16012,16125);

/*!40000 ALTER TABLE `course_prerequisite` ENABLE KEYS */;
UNLOCK TABLES;




# Dump of table professors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `professors`;

CREATE TABLE `professors` (
  `ssn` int(9) NOT NULL,
  `department_number` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sex` enum('male','female') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'male',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salary` int(6) NOT NULL,
  `college_degrees` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone` int(10) NOT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

LOCK TABLES `professors` WRITE;
/*!40000 ALTER TABLE `professors` DISABLE KEYS */;

INSERT INTO `professors` (`ssn`, `department_number`, `name`, `sex`, `title`, `salary`, `college_degrees`, `address`, `phone`)
VALUES
	( 100371749 ,NULL,'Mrs. Annie Carter II','female','Miss',`41389`,'BS Computer Science','6317 Watsica Cliffs Abrahamhaven CA 55568' ,'7147595473'),
	( 108942985 ,NULL,'Mr. Alex Smith','male','Dr.',70475,'BS Computer History','987 Torp Manor Suite 825 Runolfssonview TN 59064','5846014943'),
	( 121277058 ,NULL,'Keith Kloch','male','Ms.',57094,'BS Computer Science','9039 Bailey Lake Apt. 428 Ritchiefort AK 27858', '8943111344');

/*!40000 ALTER TABLE `professors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table students
# ------------------------------------------------------------

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `cwid` int(11) unsigned NOT NULL,
  `fname` varchar(255) NOT NULL DEFAULT '',
  `lname` varchar(255) NOT NULL DEFAULT '',
  `address_street` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_state` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_zip` int(5) NOT NULL,
  `phone_area` int(3) NOT NULL,
  `phone_number` int(7) NOT NULL,,
  `telephone` varchar(20) DEFAULT '',
  `major` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`cwid`),
  KEY `students_major_foreign` (`major`),
  CONSTRAINT `students_major_foreign` FOREIGN KEY (`major`) REFERENCES `departments` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;

INSERT INTO `students` (`cwid`, `fname`, `lname`, `address_street`, `address_city`, `address_state`, `address_zip`, `phone_area`,`phone_number`, `major`)
VALUES
	(645256969,'James','Bern','11254 Kensingtion Drive', 'Lillyhammer', 'CA', '92870','714', '8547412',NULL),
	(985651474,'David','Pantoja','12565 Jameson Lane', 'Lodi', 'CA', '65214','949', '8569812',NULL)
	(698523252,'Christopher','Johnson','25487 Dawnning Hill', 'Silverton', 'CA', '56847','417', '9856321',NULL)
	(325654747,'Kelly','Lindenberg','134 Shoemaker Avenue', 'Norwalk', 'CA', '93528','562', '9296358',NULL)
	(365269858,'Cathrine','Boyd','1154 Mulemaker Bulevard', 'Drake', 'CA', '56478','585', '8547412',NULL)
	(625478412,'Lenoard','Alverez','1351 Laketown Street', 'Montabello', 'CA', '92865','714', '5256454',NULL)
	(156478595,'John','Smith','568 Houghton Lane', 'Montauk', 'CA', '63598','686', '7895885',NULL)
	(456325252,'Kennith','Wang','13525 Washington Avenue', 'Jamestown', 'CA', '96345','714', '1452365',NULL)
	(632589585,'Gabriel','Sanchez','65894 Peculiar Lane', 'Kingstown', 'CA', '98585','714', '6589652',NULL)
	(112547474,'Joshefine','Bernardo','112 Flamingo Street', 'Fullerton', 'CA', '63254','714', '7413652',NULL)
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table departments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `number` int(11) unsigned NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `telephone` varchar(20) NOT NULL DEFAULT '',
  `office_location` varchar(50) NOT NULL DEFAULT '',
  `chair_person` int(9) NOT NULL,
  PRIMARY KEY (`number`),
  KEY `department_chair_person_foreign` (`chair_person`),
  CONSTRAINT `department_chair_person_foreign` FOREIGN KEY (`chair_person`) REFERENCES `professors` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;

INSERT INTO `departments` (`number`, `name`, `telephone`, `office_location`, `chair_person`)
VALUES
	(42849,'Computer Engineering','(657) 278-3725','CS-502',121277058)
	(42849,'Computer Science','(657) 278-4501','CS-525',108942985);

/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table enrollment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enrollment`;

CREATE TABLE `enrollment` (
  `student_cwid` int(11) unsigned NOT NULL,
  `section_number` int(10) unsigned NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`student_cwid`,`section_number`),
  KEY `enrollment_section_number_foreign` (`section_number`),
  CONSTRAINT `enrollment_section_number_foreign` FOREIGN KEY (`section_number`) REFERENCES `sections` (`number`),
  CONSTRAINT `enrollment_student_cwid_foreign` FOREIGN KEY (`student_cwid`) REFERENCES `students` (`cwid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;

INSERT INTO `enrollment` (`student_cwid`, `section_number`, `grade`)
VALUES
	(645256969,1053,'A-'),
	(645256969,1068,'C+'),
	(985651474,1208,'D+'),
	(985651474,1366,'A-'),
	(698523252,1372,'C'),
	(698523252,1366,'B+'),
	(325654747,1346,'C+'),
	(325654747,1372,'B+'),
	(365269858,1366,'B+'),
	(365269858,1372,'B+'),
	(625478412,1366,'A-'),
	(625478412,1346,'B+'),
	(156478595,1372,'A-'),
	(156478595,1346,'B+'),
	(456325252,5976,'B+'),
	(456325252,1366,'C+'),
	(632589585,1372,'B+'),
	(632589585,1208,'A-'),
	(456325252,1068,'B-'),
	(698523252,1068,'A-'),
	(156478595,1068,'A+'),
	(112547474,1068,'A-'),
	(632589585,1068,'A-'),
	(985651474,1068,'C-'),
	(112547474,1053,'B+');

/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `number` int(11) unsigned NOT NULL,
  `professor_ssn` int(11) DEFAULT NULL,
  `course_number` int(10) unsigned NOT NULL,
  `classroom` varchar(50) NOT NULL DEFAULT '',
  `meeting_days` varchar(50) NOT NULL DEFAULT '',
  `beginning_time` varchar(10) NOT NULL DEFAULT '',
  `end_time` varchar(10) NOT NULL DEFAULT '',
  `seats` int(5) NOT NULL,
  PRIMARY KEY (`number`),
  KEY `course_number` (`course_number`),
  KEY `sections_professor_ssn_foreign` (`professor_ssn`),
  CONSTRAINT `sections_course_number_foreign` FOREIGN KEY (`course_number`) REFERENCES `courses` (`number`) ON DELETE CASCADE,
  CONSTRAINT `sections_professor_ssn_foreign` FOREIGN KEY (`professor_ssn`) REFERENCES `professors` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='meeting_days could possibly be a separate one-to-many table to specify and categorize days and times depending on the needs of the application';

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`number`, `professor_ssn`, `course_number`, `classroom`, `meeting_days`, `beginning_time`, `end_time`, `seats`)
VALUES
	(1053,181542697,82559,'CS 104','M','1:00','5:00',42),
	(1068,313408381,82559,'CS 104','M','18:00','22:00',37),
	(1208,641771255,63928,'CS 104','F','5:00','6:00',61),
	(1321,609062851,53710,'CS 340','MW','8:00','9:00',87),
	(1346,164072571,55626,'CS 405','TTh','19:00','20:00',23),
	(1357,571024026,18995,'CS 304','S','7:00','10:00',60),
	(1366,947557130,82559,'CS 125','T','17:00','19:00',20),
	(1372,602942582,16084,'EC 116','TTh','13:00','16:00',72);

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;








