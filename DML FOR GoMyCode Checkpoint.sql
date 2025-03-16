CREATE DATABASE DML;

CREATE TABLE Department (
Department_ID INT PRIMARY KEY,
Department_Label VARCHAR (255),
Manager_Name VARCHAR (255)
);

CREATE TABLE Employee (
Employee_ID INT PRIMARY KEY,
Employee_Name VARCHAR(255),
Position VARCHAR (255),
Salary DECIMAL(10,2),
Department_ID INT 
FOREIGN KEY (Department_ID)
REFERENCES Department (Department_ID)
);

CREATE TABLE Project (
Project_ID INT PRIMARY KEY,
Title VARCHAR (255),
Start_Date DATE,
End_Date DATE,
Department_ID INT 
FOREIGN KEY (Department_ID)
REFERENCES Department (Department_ID)
);

CREATE TABLE Employee_Project (
Employee_ID INT FOREIGN KEY REFERENCES Employee (Employee_ID),
Project_ID INT FOREIGN KEY REFERENCES Project (Project_ID),
Employee_Project_Role VARCHAR(255)
);

--INSERTION OF RECORDS
INSERT INTO Department (Department_ID, Department_Label, Manager_Name)
VALUES (1, 'IT', 'Alice Johnson'),
	   (2, 'HR', 'Bob Smith'),
	   (3, 'Marketing', 'Clara Benneth');

INSERT INTO Employee (Employee_ID,Employee_Name, Position, Salary,Department_ID)
VALUES (101, 'John Doe', 'Developer', 60000.00, 1),
	   (102, 'Jane Smith', 'Analyst', 55000.00, 2),
	   (103, 'Mike Brown', 'Designer', 50000.00, 3),
	   (104, 'Sarah Johnson', 'Data Scientist', 70000.00, 1),
	   (105, 'Emma Wilson', 'HR Specialist', 52000.00, 2);

INSERT INTO Project (Project_ID, Title, Start_Date, End_Date, Department_ID)
VALUES (201, 'Website Redesign', '2024-01-15', '2024-06-30', 1),
	   (202, 'Employee Onboarding', '2024-03-01', '2024-09-01', 2),
	   (203, 'Market Research', '2024-02-01', '2024-07-31', 3),
	   (204, 'IT Infrastructure Setup', '2024-04-01', '2024-12-31', 1);

INSERT INTO Employee_Project (Employee_ID, Project_ID, Employee_Project_Role)
VALUES (101, 201, 'Frontend Developer'),
	   (104, 201, 'Backend Developer'),
	   (102, 202, 'Trainer'),
	   (105, 202, 'Coordinator'),
	   (103, 203, 'Research Lead'),
	   (101, 204, 'Network Specialist');

--UPDATING A RECORD
UPDATE Employee_Project
SET Employee_Project_Role = 'Full Stack Developer'
WHERE Employee_ID = 101;

--DELETING A RECORD
DELETE FROM Employee_Project
WHERE Employee_ID = 103;

DELETE FROM Employee
WHERE Employee_ID = 103;