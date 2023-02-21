use QLNV
go

create proc SP_Them_Nhan_Vien @manv nvarchar(4), 
							  @macv nvarchar(2),
							  @tennv nvarchar(30),
							  @ngaysinh datetime,
							  @luongcb float,
							  @ngaycong int, 
							  @phucap float
as
begin
	if (exists (select MaCV from ChucVu where MaCV = @macv))
		insert into NhanVien values ( @manv, @macv, @tennv, @ngaysinh, @luongcb, @ngaycong, @phucap)
	else 
		print 'MaCV khong ton tai'
end

select * from NhanVien
exec SP_Them_Nhan_Vien 'NV11', 'BV', N'Nguyễn Thi Van', '2/9/1999', '1200000', '36', '1233'

alter proc SP_CapNhat_Nhan_Vien @manv nvarchar(4), 
							  @macv nvarchar(2),
							  @tennv nvarchar(30),
							  @ngaysinh datetime,
							  @luongcb float,
							  @ngaycong int, 
							  @phucap float
as
begin
	if (exists(select MaCV from ChucVu where MaCV = @macv))
		update NhanVien
			set MaNV = @manv,
			TenNV = @tennv,
			NgaySinh = @ngaysinh,
			LuongCanBan = @luongcb,
			NgayCong = @ngaycong,
			PhuCap = @phucap
		where MaCV = @macv and MaNV = @manv
	else 
		print N'Khong co chuc vu nay'
end

select * from NhanVien
exec SP_CapNhat_Nhan_Vien 'NV01', 'GD', N'Nguyễn Thi Van', '2/9/1999', '1200000', '36', '1233'

alter proc SP_LuongLN @luong float output
as
begin
	select @luong = LuongCanBan * NgayCong + PhuCap
	from NhanVien
	return @luong
end

declare @bien float 
exec SP_LuongLN @bien output
select @bien

alter proc SP_Chen_Nhan_Vien @manv nvarchar(4), 
							  @macv nvarchar(2),
							  @tennv nvarchar(30),
							  @ngaysinh datetime,
							  @luongcb float,
							  @ngaycong int, 
							  @phucap float,
							  @flag int output
as
begin
	if (not exists(select MaCV from ChucVu where MaCV = @macv))
		set @flag = 0;
	else if (not exists (select * from NhanVien where MaCV = @macv and MaNV = @manv and @ngaycong<=30))
		set @flag = 0;
	else 
		update NhanVien
			set TenNV = @tennv,
			NgaySinh = @ngaysinh,
			LuongCanBan = @luongcb,
			NgayCong = @ngaycong,
			PhuCap = @phucap
		where MaCV = @macv and MaNV = @manv
	return @flag
end

select * from NhanVien
declare @bien int
exec SP_Chen_Nhan_Vien 'NV02', 'BV', N'Nguyễn Thi Tấn', '2/9/1980', '1200000', '30', '1233', @bien output
select @bien