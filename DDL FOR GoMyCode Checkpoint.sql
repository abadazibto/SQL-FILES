CREATE DATABASE DDL;

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


