use master 
go

create database DeptEmp
on primary (
	name = 'DeptEmp_dat',
	filename = 'E:\DeptEmp.mdf',
	size = 10MB,
	maxsize = 100MB, 
	filegrowth = 10MB
)
log on (
	name = 'DeptEmp_log',
	filename = 'E:\DeptEmp.ldf',
	size = 1MB,
	maxsize = 5MB, 
	filegrowth = 20%
)

use DeptEmp
go
create table Department
(
	DepartmentNo integer primary key,
	DepartmentName char(25), 
	Location char(25)
)
create table Employee
(
	EmpNo INTEGER PRIMARY KEY,
	Fname VARCHAR(15) NOT NULL,
	Lname VARCHAR(15) NOT NULL,
	Job VARCHAR(25) NOT NULL,
	HireDate DATETIME NOT NULL,
	Salary NUMERIC NOT NULL,
	Commision NUMERIC,
	DepartmentNo INTEGER NOT NULL,
	constraint FK_Em_De foreign key(DepartmentNo)
		references Department(DepartmentNo)
)

insert into Department values(10, 'Accounting', 'Melbourne')
insert into Department values(20, 'Research', 'Adealide')
insert into Department values(30, 'Sales', 'Sydney')
insert into Department values(40, 'Operations', 'Perth')

insert into Employee values(1, 'John', 'Smith', 'Clerk', '1980-Dec-17', 800, null, 20)
insert into Employee values(2, 'Peter', 'Allen', 'Salesman', '1981-Feb-20', 1600, 300, 30)
insert into Employee values(3, 'Kate', 'Ward', 'Salesman', '1981-Feb-22', 1250, 500, 30)
insert into Employee values(4, 'Jact', 'Jones', 'Manager', '1981-Apr-02', 2975, null, 20)
insert into Employee values(5, 'Joe', 'Martin', 'Salesman', '1981-Sep28', 1250, 1400, 30)
   