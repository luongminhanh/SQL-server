use master
go
create database QLBanHangQA
on primary (
	name = 'QLBanHangQA_dat',
	filename = 'E:\QLBanHang_mdf',
	size = 10MB,
	maxsize = 50MB,
	filegrowth = 10MB
)
log on (
	name = 'QLBanhHangQA_log',
	filename = 'E:\QLBanHangQA.ldf',
	size = 1MB,
	maxsize = 5MB,
	filegrowth = 20%
)

--mô tả sp kiểu ntext

go 
use QLBanHangQA
go 

create table HangSX
(
	MaHangSX nchar(10) not null primary key,
	TenHang nvarchar(20) not null,
	DiaChi nvarchar(30),
	SoDT nvarchar(20),
	Email nvarchar(30)
)
create table NhanVien 
(
	MaNV nchar(10) not null primary key,
	TenNV nvarchar(20) not null,
	GioiTinh nvarchar(20) not null,
	DiaChi nvarchar(30),
	SoDT nvarchar(20) not null,
	Email nvarchar(30), 
	TenPhong nvarchar(20)
)
create table SanPham
(	
	MaSP nchar(10) not null primary key,
	MaHangSX nchar(10) not null,
	TenSP nvarchar(20),
	SoLuong int not null,
	MauSac nchar(20),
	GiaBan money,
	DonViTinh nchar(10),
	Mota ntext,
	constraint FK_SP_HSX foreign key(MaHangSX)
		references HangSX(MaHangSX)
)
create table PNhap 
(
	SoHDN nchar(10) not null primary key,
	NgayNhap date not null,
	MaNV nchar(10) not null,
	constraint FK_PN_NV foreign key(MaNV)
		references NhanVien(MaNV)
)
create table PXuat
(
	SoHDX nchar(10) not null primary key,
	NgayXuat date not null,
	MaNV nchar(10),
	constraint FK_PX_NV foreign key(MaNV)
		references NhanVien(MaNV)
)
create table Nhap
(
	SoHDN nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongN int,
	DonGiaN money,
	constraint PK_Nhap primary key(SoHDN, MaSP),
	constraint FK_N_PN foreign key(SoHDN)
		references PNhap(SoHDN),
	constraint FK_N_SP foreign key(MaSP)
		references SanPham(MaSP)
)
create table Xuat 
(
	SoHDX nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongX int,
	constraint PK_Xuat primary key(SoHDX, MaSP),
	constraint FK_X_PX foreign key(SoHDX)
		references PXuat(SoHDX),
	constraint FK_X_SP foreign key(MaSP)
		references SanPham(MaSP)
)

insert into HangSX values('H01', 'Samsung', 'Korea', '011-08271717', 'ss@gmail.com')
insert into HangSX values('H02', 'OPPO', 'China', '081-08626262', 'oppo@gmail.com.cn')
insert into HangSX values('H03', 'Vinfone', N'Việt nam', '084-098262626', 'vf@gmail.com.vn')

insert into NhanVien values('NV01', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', '0982626521', 'thu@gmail.com', N'Kế toán')
insert into NhanVien values('NV02', N'Lê Văn Nam', 'Nam', N'Bắc Ninh', '0972525252', 'nam@gmail.com', N'vật tư')
insert into NhanVien values('NV03', 'Trần Hòa Bình', N'Nữ', N'Hà Nội', '0328388388', 'hb@gmail.com', N'Kế toán')

insert into SanPham values('SP01', 'H02', 'F1 Plus', 100, N'Xám', 7000000, N'Chiếc', N'Hàng cận cao cấp')
insert into SanPham values('SP02', 'H01', 'Galaxy Note11', 50, N'Đỏ', 19000000, N'Chiếc', N'Hàng cao cấp')
insert into SanPham values('SP03', 'H02', 'F3 Lite', 200, N'Nâu', 3000000, N'Chiếc', 'Hàng phổ thông')
insert into SanPham values('SP04', 'H03', 'Vjoy3', 200, N'Xám', 1500000, N'Chiếc', N'Hàng phổ thông')
insert into SanPham values('SP05', 'H01', 'Galaxy V21', 500, N'Nâu', 8000000, N'Chiếc', N'Hàng cận cao cấp')

insert into PNhap values('N01', '02-05-2019', 'NV01')
insert into PNhap values('N02', '04-07-2020', 'NV02')
insert into PNhap values('N03', '05-17-2020', 'NV02')
insert into PNhap values('N04', '03-22-2020', 'NV03')
insert into PNhap values('N05', '07-07-2020', 'NV01')

insert into Nhap values('N01', 'SP02', 10, 17000000)
insert into Nhap values('N02', 'SP01', 30, 6000000)
insert into Nhap values('N03', 'SP04', 20, 1200000)
insert into Nhap values('N04', 'SP01', 10, 6200000)
insert into Nhap values('N05', 'SP05', 20, 7000000)

insert into PXuat values('X01', '06-14-2020', 'NV02')
insert into PXuat values('X02', '03-05-2019', 'NV03')
insert into PXuat values('X03', '12-12-2020', 'NV01')
insert into PXuat values('X04', '06-02-2020', 'NV02')
insert into PXuat values('X05', '05-18-2020', 'NV01')

insert into Xuat values('X01', 'SP03', 5)
insert into Xuat values('X02', 'SP01', 3)
insert into Xuat values('X03', 'SP02', 1)
insert into Xuat values('X04', 'SP03', 2)
insert into Xuat values('X05', 'SP05', 1)

--a (2.5đ). Đưa ra 10 mặt hàng có SoLuongN nhiều nhất trong năm 2019
select top 10 SanPham.MaSP, TenSP from Nhap
inner join SanPham on Nhap.MaSP = SanPham.MaSP
inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where year(NgayNhap) = 2019
order by SoLuongN DESC

--b (2.5đ). Đưa ra MaSP,TenSP của các sản phẩm do công ty ‘Samsung’ sản xuất do nhân viên có mã ‘NV01’ nhập.
select SanPham.MaSP,TenSP from SanPham 
inner join HangSX on HangSX.MaHangSX = SanPham.MaHangSX
inner join Nhap on SanPham.MaSP = Nhap.MaSP
inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where TenHang = 'Samsung' and MaNV = 'NV01'

--c (2.5đ). Đưa ra SoHDN,MaSP,SoLuongN,ngayN của mặt hàng có MaSP là ‘SP02’, được nhân viên ‘NV02’ xuất.
select Nhap.SoHDN, Nhap.MaSP, SoLuongN, NgayNhap from PNhap 
inner join Nhap on PNhap.SoHDN = Nhap.SoHDN
inner join NhanVien on NhanVien.MaNV = PNhap.MaNV
inner join PXuat on PXuat.MaNV = NhanVien.MaNV
where Nhap.MaSP = 'SP02' and PXuat.MaNV = 'NV02'

--d (2.5đ). Đưa ra manv,TenNV đã xuất mặt hàng có mã ‘SP02’ ngày ‘03-02-2020’select NhanVien.MaNV, TenNV from PXuat inner join NhanVien on NhanVien.MaNV = PXuat.MaNVinner join Xuat on Xuat.SoHDX = PXuat.SoHDXwhere MaSP = 'SP02' and NgayXuat = '2020-02-03'