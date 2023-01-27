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
	Theory tinyint,
	Practical tinyint,
	Date date,
	constraint PK_Mark primary key(StudentID, SubjectID)
)

insert into Students values('AV087005', N'Mai Trung Hiếu', '1989-10-11', N'trunghieu@yahoo.com', '0904115116', 'AV1')
insert into Students values(N'AV0807006', N'Nguyễn Quý Hùng', '19881202', N'quyhung@yahoo.com', '0955667787', 'AV2')
insert into Students values('AV0807007', N'Đỗ Đắc Huỳnh', '19900102', N'dachuynh@yahoo.com', N'0988574747', 'AV2')
insert into Students values (N'AV0807009', N'An Đăng Khuê', '19860306', N'dangkhue@yahoo.comStudentID, SubjectID, DateM, Theory, Practical, Date', '0986757463', 'AV1') 
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

--1. Hiển thị nội dung bảng Students
select * from Students

--2. Hiển thị nội dung danh sách sinh viên lớp AV1
select * from Students
where Class='AV1'

--3. Sử dụng lệnh UPDATE để chuyển sinh viên có mã AV0807012 sang lớp AV2
update Students
set Class='AV2'
where StudentID='AV0807012'

--4. Tính tổng số sinh viên của từng lớp
select Class, count(StudentID) from Students
group by Class

--5. Hiển thị danh sách sinh viên lớp AV2 được sắp xếp tăng dần theo StudentName
select StudentName from Students
where Class='AV2'
order by StudentName ASC

--6. Hiển thị danh sách sinh viên không đạt lý thuyết môn S001 (theory<10) thi ngày 6/5/2008
select StudentName from Students
inner join Mark on Students.StudentID = Mark.StudentID
where SubjectID = 'S001' and (Theory<10) and (Date = '2008-05-06')

--7. Hiển thị tổng số sinh viên không đạt lý thuyết môn S001. (theory <10)
select count(Students.StudentID) from Students
inner join Mark on Students.StudentID = Mark.StudentID
where SubjectID = 'S001' and (Theory<10)

--8. Hiển thị Danh sách sinh viên học lớp AV1 và sinh sau ngày 1/1/1980
select StudentName, Year(DateofBirth) from Students
where Class='AV1' and ((Year(DateofBirth)-Year(1980)>0) or 
(Year(DateofBirth)=1980 and Day(DateofBirth)>1 and Month(DateofBirth)>=1))

--9. Xoá sinh viên có mã AV0807011
delete from Students
where StudentID='AV0807011'

--10.Hiển thị danh sách sinh viên dự thi môn có mã S001 ngày 6/5/2008 bao gồm các trường sau: 
--StudentID, StudentName, SubjectName, Theory, Practical, Dat
select Students.StudentID, StudentName, SubjectName, Theory, Practical, Date
from Students
inner join Mark on Students.StudentID = Mark.StudentID
inner join Subjects on Subjects.SubjectID = Mark.SubjectID
where Mark.SubjectID = 'S001' and Date = '2008-05-06'
