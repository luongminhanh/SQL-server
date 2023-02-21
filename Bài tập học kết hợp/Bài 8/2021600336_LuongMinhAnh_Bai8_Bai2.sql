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
create proc nhapkhoa(@makhoa nchar(10), @tenkhoa nvarchar(20), @dt nvarchar(20), @trave1 int output)
as
begin
	if (not exists (select * from Khoa where TenKhoa = @tenkhoa))
		begin
			insert into Khoa values (@makhoa, @tenkhoa, @dt)
		end
	else 
		set @trave1 = 0
	return @trave1
end

--thuc thi
select * from Khoa
declare @bien1 int
exec nhapkhoa 'K05', 'Khoa du lich', '0975233', @bien1 output
select @bien1
declare @bien2 int
exec nhapkhoa 'K12', 'Khoa nn', '0973333', @bien2 output
select @bien2


--cau 2
create proc nhaplop2(@malop nchar(10), @tenlop nvarchar(20), 
					@khoa nvarchar(20), @hedt nvarchar(20),
					@nam int, @makhoa nchar(10), @trave int output)
as
begin
	if (exists (select * from Lop where TenLop = @tenlop))
		set @trave = 0
	else 
		if (not exists (select * from Khoa where MaKhoa = @makhoa))
		set @trave = 1
	else 
		begin
			insert into Lop values(@malop, @tenlop, @khoa, @hedt, @nam, @makhoa)
			set @trave = 2
		end
	return @trave
end

select * from Lop
select * from Khoa
declare @bien3 int
exec nhaplop2 'L07', '12a6', '12', 'dai hoc', 2021, 'K05', @bien3 output
select @bien3
