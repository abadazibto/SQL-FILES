CREATE DATABASE DQL;

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

--1. Write a query to retrieve the names of employees who are assigned to more than one project, including the total number of projects for each employee.
SELECT E.Employee_Name, COUNT(P.Project_ID) AS Total_Projects
FROM Employee AS E
JOIN Employee_Project AS EP
ON E.Employee_ID = EP.Employee_ID
JOIN Project P 
ON EP.Project_ID = P.Project_ID
GROUP BY E.Employee_ID, E.Employee_Name
HAVING COUNT(P.Project_ID) > 1;

--2. Write a query to retrieve the list of projects managed by each department, including the department label and manager’s name.
SELECT P.Title, D.Department_Label, D.Manager_Name 
FROM Project P
JOIN Department D
ON P.Department_ID = D.Department_ID;

--3. Write a query to retrieve the names of employees working on the project "Website Redesign," including their roles in the project.
SELECT E.Employee_Name, P.Title, EP.Employee_Project_Role AS Roles_In_Project
FROM Employee E
JOIN Employee_Project EP
ON E.Employee_ID = EP.Employee_ID
JOIN Project P
ON P.Project_ID = EP.Project_ID
WHERE Title = 'Website Redesign';

--4. Write a query to retrieve the department with the highest number of employees, including the department label, manager name, and the total number of employees.
SELECT TOP 1 WITH TIES D.Department_ID, D.Department_Label, D.Manager_Name,  COUNT(E.Employee_ID) AS total_number_of_employees
FROM Department D
JOIN Employee E
ON D.Department_ID = E.Department_ID
GROUP BY D.Department_ID, D.Department_Label, D.Manager_Name
ORDER BY total_number_of_employees DESC;

--5. Write a query to retrieve the names and positions of employees earning a salary greater than 60,000, including their department names.
SELECT E.Employee_Name, E.Position, E. Salary, D.Department_Label
FROM Employee E
JOIN Department D
ON E.Department_ID = D.Department_ID
WHERE Salary > 60000;

--6. Write a query to retrieve the number of employees assigned to each project, including the project title.
SELECT P.Project_ID, P.Title, COUNT(E.Employee_ID) number_of_employees
FROM Project P
JOIN Employee E
ON P.Department_ID = E.Department_ID
GROUP BY P.Project_ID, P.Title
ORDER BY P.Title;

--7. Write a query to retrieve a summary of roles employees have across different projects, including the employee name, project title, and role.
SELECT E.Employee_Name, P.Title, EP.Employee_Project_Role AS Role
FROM Employee E
JOIN Project P
ON P.Department_ID = E.Department_ID
JOIN Employee_Project EP
ON E.Employee_ID = EP.Employee_ID
ORDER BY E.Employee_Name, P.Title;

--8. Write a query to retrieve the total salary expenditure for each department, including the department label and manager name.
SELECT D.Department_ID, D.Department_Label, D.Manager_Name, SUM(E.Salary) AS Total_Salary_Expenditure
FROM Department D
JOIN Employee E
ON  D.Department_ID = E.Department_ID
GROUP BY  D.Department_ID, D.Department_Label, D.Manager_Name
ORDER BY Total_Salary_Expenditure DESC;
