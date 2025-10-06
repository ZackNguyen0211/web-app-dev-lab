CREATE DATABASE IF NOT EXISTS UniversityERD
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE UniversityERD;

CREATE TABLE Student (
  StudentID   INT          PRIMARY KEY,
  StudentName VARCHAR(100) NOT NULL,
  DoB         DATE,
  Major       VARCHAR(100)
);

CREATE TABLE Course (
  CourseID   INT          PRIMARY KEY,
  CourseName VARCHAR(100) NOT NULL
);

CREATE TABLE Department (
  DepartmentID   INT          PRIMARY KEY,
  DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Lecturer (
  LecturerID   INT          PRIMARY KEY,
  LecturerName VARCHAR(100) NOT NULL,
  DepartmentID INT,
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Register (
  StudentID INT,
  CourseID  INT,
  PRIMARY KEY (StudentID, CourseID),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
  FOREIGN KEY (CourseID)  REFERENCES Course(CourseID)
);

CREATE TABLE Teach (
  LecturerID INT,
  CourseID   INT,
  PRIMARY KEY (LecturerID, CourseID),
  FOREIGN KEY (LecturerID) REFERENCES Lecturer(LecturerID),
  FOREIGN KEY (CourseID)   REFERENCES Course(CourseID)
);
