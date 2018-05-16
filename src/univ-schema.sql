CREATE DATABASE university;

CREATE TABLE `course_prerequisite` (
  `parent_course` int(11) unsigned NOT NULL,
  `child_course` int(11) unsigned NOT NULL,
  PRIMARY KEY (`parent_course`,`child_course`),
  KEY `course_prerequisite_child_course_foreign` (`child_course`),
  CONSTRAINT `course_prerequisite_child_course_foreign` FOREIGN KEY (`child_course`) REFERENCES `courses` (`number`) ON DELETE CASCADE,
  CONSTRAINT `course_prerequisite_parent_course_foreign` FOREIGN KEY (`parent_course`) REFERENCES `courses` (`number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `enrollment` (
  `student_cwid` int(11) unsigned NOT NULL,
  `section_number` int(10) unsigned NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`student_cwid`,`section_number`),
  KEY `enrollment_section_number_foreign` (`section_number`),
  CONSTRAINT `enrollment_section_number_foreign` FOREIGN KEY (`section_number`) REFERENCES `sections` (`number`),
  CONSTRAINT `enrollment_student_cwid_foreign` FOREIGN KEY (`student_cwid`) REFERENCES `students` (`cwid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `professors` (
  `ssn` int(9) NOT NULL,
  `department_number` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sex` enum('male','female') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'male',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salary` int(6) NOT NULL,
  `college_degrees` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `telephone` varchar(20) DEFAULT '',
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='name => {fname, lname} // should we include a middle name?';

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

CREATE TABLE `student_minor` (
  `student_cwid` int(11) unsigned NOT NULL,
  `minor_department` int(11) unsigned NOT NULL,
  PRIMARY KEY (`student_cwid`,`minor_department`),
  KEY `student_minor_minor_department_foreign` (`minor_department`),
  CONSTRAINT `student_minor_minor_department_foreign` FOREIGN KEY (`minor_department`) REFERENCES `departments` (`number`) ON DELETE CASCADE,
  CONSTRAINT `student_minor_student_cwid_foreign` FOREIGN KEY (`student_cwid`) REFERENCES `students` (`cwid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `students` (
  `cwid` int(11) unsigned NOT NULL,
  `fname` varchar(255) NOT NULL DEFAULT '',
  `lname` varchar(255) NOT NULL DEFAULT '',
  `major` int(11) unsigned DEFAULT NULL,
  `address_street` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_state` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address_zip` int(10) NOT NULL,
  `phone_area` int(3) NOT NULL,
  `phone_number` int(7) NOT NULL,
  PRIMARY KEY (`cwid`),
  KEY `students_major_foreign` (`major`),
  CONSTRAINT `students_major_foreign` FOREIGN KEY (`major`) REFERENCES `departments` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Specification dictates an address, but does not specify it as a composite field so we will just use one column to hold the address';
