use DeptEmp
go

--1. Hiển thị nội dung bảng Department
select * from Department

--2. Hiển thị nội dung bảng Employee
select * from Employee

--3. Hiển thị employee number, employee first name và employee last name từ
--bảng Employee mà employee first name có tên là ‘Kate’.
select EmpNo, Fname, Lname 
from Employee
where Fname = 'Kate'

--4. Hiển thị ghép 2 trường Fname và Lname thành Full Name, Salary, 
--10%Salary (tăng 10% so với lương ban đầu). 
select Fname +' '+ Lname as 'Full Name', Salary, 0.1*Salary as '10%Salary' 
from Employee

--5. Hiển thị Fname, Lname, HireDate cho tất cả các Employee có HireDate là 
--năm 1981 và sắp xếp theo thứ tự tăng dần của Lname.
select Fname, Lname, HireDate 
from Employee
where Year((HireDate)) = '1981'
order by Lname ASC

--6. Hiển thị trung bình(average), lớn nhất (max) và nhỏ nhất(min) của 
--lương(salary) cho từng phòng ban trong bảng Employee.
select AVG(Salary) as LuongTB, Max(Salary) as 'LuongMax', Min(Salary) as 'LuongMin' 
from Employee
group by DepartmentNo

--7. Hiển thị DepartmentNo và số người có trong từng phòng ban có trong bảng 
--Employee.
select DepartmentNo, count(EmpNo) 
from Employee
group by DepartmentNo

--8. Hiển thị DepartmentNo, DepartmentName, FullName (Fname và Lname), 
--Job, Salary trong bảng Department và bảng Employee.
select Department.DepartmentNo, DepartmentName, Fname + ' ' + Lname as 'FullName', Job, Salary 
from Department
inner join Employee on Department.DepartmentNo = Employee.DepartmentNo

--9. Hiển thị DepartmentNo, DepartmentName, Location và số người có trong 
--từng phòng ban của bảng Department và bảng Employee.
select Department.DepartmentNo, DepartmentName, Location, count(EmpNo) 
from Department 
inner join Employee on Department.DepartmentNo = Employee.DepartmentNo
group by Department.DepartmentNo, DepartmentName, Location

--10. Hiển thị tất cả DepartmentNo, DepartmentName, Location và số người có 
--trong từng phòng ban của bảng Department và bảng Employee
select Department.DepartmentNo, DepartmentName, Location, count(EmpNo) 
from Department 
inner join Employee on Department.DepartmentNo = Employee.DepartmentNo
group by Department.DepartmentNo, DepartmentName, Location


