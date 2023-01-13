use master 
go

create database MarkManagement
on primary (
	name = 'MarkManagement_dat',
	filename = 'E:\MarkManagement.mdf',
	size = 10MB,
	maxsize = 100MB, 
	filegrowth = 10MB
)
log on (
	name = 'MarkManagement_log',
	filename = 'E:\MarkManagement.ldf',
	size = 1MB,
	maxsize = 5MB, 
	filegrowth = 20%
)

use MarkManagement
go
create table Students
(
	StudentID nvarchar(12) primary key,
	StudentName nvarchar(25) not null,
	DateofBirth datetime not null,
	Email nvarchar(40),
	Phone nvarchar(12),
	Class Nvarchar(10)	
)
create table Subjects
(
	SubjectID nvarchar(10) primary key,
	SubjectName nvarchar(25) not null
)
create table Mark
(	
	StudentID nvarchar(12),
	SubjectID nvarchar(10),
	DateM datetime,
	Theory tinyint,
	Practical tinyint,
	constraint PK_Mark primary key(StudentID, SubjectID)
)

insert into Students values('AV087005', N'Mai Trung Hiếu', '1989-10-11', N'trunghieu@yahoo.com', '0904115116', 'AV1')
insert into Students values(N'AV0807006', N'Nguyễn Quý Hùng', '19881202', N'quyhung@yahoo.com', '0955667787', 'AV2')
insert into Students values('AV0807007', N'Đỗ Đắc Huỳnh', '19900102', N'dachuynh@yahoo.com', N'0988574747', 'AV2')
insert into Students values (N'AV0807009', N'An Đăng Khuê', '19860306', N'dangkhue@yahoo.com', '0986757463', 'AV1') 
insert into Students values(N'AV0807010', N'Nguyễn T. Tuyết Lan', '19890712', N'tuyetlan@gmail.com', '0983310342', 'AV2')
insert into Students values(N'AV0807011', N'Đinh Phụng Long', '19901202', N'phunglong@yahoo.com', '', 'AV1' )
insert into Students values(N'AV0807012', N'Nguyễn Tuấn Nam', '19900302', N'tuannam@yahoo.com', '', 'AV1')

insert into Subjects values('S001', 'SQL')
insert into Subjects values('S002', 'Java Simpliefield')
insert into Subjects values('S003', 'Active Server Page')

insert into Mark values('AV0807005', 'S001', 8, 25, '2008-05-06')
insert into Mark values('AV0807006', 'S002', 16, 30, '2008-05-06')
insert into Mark values('AV0807007', 'S001', 10, 25, '2008-05-06')
insert into Mark values('AV0807009', 'S003', 7, 13, '2008-05-06')
insert into Mark values('AV0807010', 'S003', 9, 16, '2008-05-06')
insert into Mark values('AV0807011', 'S002', 8, 30, '2008-05-06')
insert into Mark values('AV0807012', 'S001', 7, 31, '2008-05-06')
insert into Mark values('AV0807005', 'S002', 12, 11, '2008-06-06')
insert into Mark values('AV08070010', 'S001', 7, 6, '2008-06-06')