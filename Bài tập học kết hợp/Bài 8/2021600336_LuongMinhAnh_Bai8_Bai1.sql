use master
go

create database QLKhoa
on primary (
	name = 'QLKhoa_dat',
	filename = 'E:\QLKhoa.mdf',
	size = 10MB,
	maxsize = 50MB,
	filegrowth = 10MB
)
log on (
	name = 'QLKhoa_log',
	filename = 'E:\QLKhoa.ldf',
	size = 1MB,
	maxsize = 5MB,
	filegrowth = 20%
)

use QLKhoa 
go

--cau 1
create proc nhap(@makhoa nchar(10), @tenkhoa nvarchar(20), @dt nvarchar(20))
as
begin
	if (not exists (select * from Khoa where TenKhoa = @tenkhoa))
		insert into Khoa values (@makhoa, @tenkhoa, @dt)
	else 
		print @tenkhoa +' da ton tai'
end

--thuc thi
select * from Khoa
exec nhap 'K05', 'Khoa du lich', '0975233'

--cach 2: su dung bien dem
create proc nhap2(@makhoa nchar(10), @tenkhoa nvarchar(20), @dt nvarchar(20))
as
begin
	declare @dem int
	select @dem = count(*) from Khoa where TenKhoa = @tenkhoa
	if (@dem=0) 
		insert into Khoa values (@makhoa, @tenkhoa, @dt)
	else 
		print @tenkhoa +' da ton tai'
end

--thuc thi
select * from Khoa
exec nhap2 'K06', 'Khoa ngoai ngu', '09752899'


--cau 2
create proc nhaplop(@malop nchar(10), @tenlop nvarchar(20), 
					@khoa nvarchar(20), @hedt nvarchar(20),
					@nam int, @makhoa nchar(10))
as
begin
	if (exists (select * from Lop where TenLop = @tenlop))
		print N'Da ton tai lop nay'
	else 
		if (not exists (select * from Khoa where MaKhoa = @makhoa))
			print N'khoa nay chua ton tai'
	else 
		insert into Lop values(@malop, @tenlop, @khoa, @hedt, @nam, @makhoa)
end

select * from Lop
select * from Khoa
exec nhaplop 'L07', '12a6', '12', 'dai hoc', 2021, 'K09'
