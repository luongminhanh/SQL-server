--1. Viết hàm thống kê xem mỗi lớp có bao nhiêu sinh viên với malop là tham số truyền vào 
--từ bàn phím.
Create function thong_ke(@malop nchar(10))
returns int
as
begin
	declare @sl int
	set @sl = (select count(MaSV)
	from SV, LOP
	where SV.MaLop = LOP.MaLop and SV.MaLop = @malop
	group by TenLop)
	return @sl
end

select dbo.thong_ke('L02')

--2. Đưa ra danh sách sinh viên(masv,tensv) học lớp với tenlop được truyền vào từ bàn phím.
create function fn_timSV(@tenlop nvarchar(10))
returns @bang table(
				MaSV nchar(10),
				TenSV nvarchar(30)
				)
as
begin
	insert into @bang 
					select MaSV, TenSV 
					from SV inner join LOP on SV.MaLop = LOP.MaLop
					where TenLop = @tenlop
	return 
end

select * from dbo.fn_timSV('12A')

--3. Đưa ra hàm thống kê sinhvien: malop,tenlop,soluong sinh viên trong lớp, với tên lớp 
--được nhập từ bàn phím. Nếu lớp đó chưa tồn tại thì thống kê tất cả các lớp, ngược lại nếu 
--lớp đó đã tồn tại thì chỉ thống kê mỗi lớp đó.
alter function fn_tkSV(@tenlop nvarchar(10))
returns @bang table(
					malop nchar(10),
					tenlop nvarchar(10),
					soluong int
					)
as
begin
	if (not exists (select TenLop from LOP where TenLop = @tenlop)) 
	insert into @bang 
					select SV.MaLop, TenLop, count(MaSV)
					from SV inner join LOP on SV.MaLop = LOP.MaLop
					group by SV.MaLop, TenLop
	else
	insert into @bang 
					select SV.MaLop, TenLop, count(MaSV)
					from SV inner join LOP on SV.MaLop = LOP.MaLop
					where TenLop = @tenlop
					group by SV.MaLop, TenLop
	return
end

select * from dbo.fn_tkSV('12C')

--4. Đưa ra phòng học của tên sinh viên nhập từ bàn phím.
create function fn_phong(@tensv nvarchar(30))
returns nvarchar(20)
as
begin
	declare @phong nvarchar(20)
	set @phong = (select Phong from LOP
					inner join SV on LOP.MaLop = SV.MaLop
					where TenSV = @tensv)
	return @phong
end

select dbo.fn_phong('Nguyen Van A')

--5. Đưa ra thống kê masv,tensv, tenlop với tham biến nhập từ bàn phím là phòng. Nếu phòng 
--không tồn tại thì đưa ra tất cả các sinh viên và các phòng. Neu phòng tồn tại thì đưa ra các 
--sinh vien của các lớp học phòng đó (Nhiều lớp học cùng phòng).
alter function fn_inforSV(@phong nvarchar(20))
returns @bang table (
					masv nchar(10),
					tensv nvarchar(30),
					tenlop nvarchar(10)
					)
as
begin
	if (not exists(select Phong from Lop where Phong = @phong))
		insert into @bang 
				select MaSV, TenSV, TenLop from SV 
				inner join LOP on SV.MaLop = LOP.MaLop
	else 
		insert into @bang 
				select MaSV, TenSV, TenLop from SV 
				inner join LOP on SV.MaLop = LOP.MaLop
				where Phong = @phong
	return
end

select * from dbo.fn_inforSV('P11')


--6. Viết hàm thống kê xem mỗi phòng có bao nhiêu lớp học. Nếu phòng không tồn tại trả
--về giá trị 0. 
create function fn_lop(@phong nvarchar(20))
returns int 
as
begin
	declare @sl int
	if (exists (select Phong from LOP where Phong = @phong))
		set @sl = (select count(MaLop) from LOP
					where Phong = @phong
					group by Phong)
	else set @sl = 0
	return @sl
end

select dbo.fn_lop('P01')