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

--a (2đ). Hãy Đưa ra tổng tiền nhập của mỗi nhân viên trong tháng 8 – năm 2018 có tổng giá trị lớn hơn 100.000
select MaNV, SUM(SoLuongN*DonGiaN) as 'TongTienN' from Nhap
inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
where month(NgayNhap) = 8 and year(NgayNhap) = 2018
group by MaNV

--b, (2đ). Hãy Đưa ra danh sách các sản phẩm đã nhập nhưng chưa xuất bao giờ.
Select SanPham.MaSP,TenSP
From SanPham Inner join nhap on SanPham.MaSP = Nhap.MaSP
Where SanPham.MaSP in (select MaSP from Nhap) and SanPham.MaSP not in (select MaSP From Xuat)

--c (2đ). Hãy Đưa ra danh sách các sản phẩm đã nhập năm 2020 và đã xuất năm 2020.
select SanPham.MaSP, TenSP from Nhap
inner join SanPham on SanPHam.MaSP = Nhap.MaSP
inner join Pnhap on Nhap.SoHDN = PNhap.SoHDN
inner join Xuat on Xuat.MaSP = SanPham.MaSP
inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
where year(NgayNhap) = 2020 and year(NgayXuat) = 2020

--d (2đ). Hãy Đưa ra danh sách các nhân viên vừa nhập vừa xuất.
select MaNV, TenNV from NhanVien
where MaNV in (select MaNV from PXuat) and MaNV in (select MaNV from PXuat)

--e (2đ). Hãy Đưa ra danh sách các nhân viên không tham gia việc nhập và xuất.
select MaNV, TenNV from NhanVien
where MaNV not in (select MaNV from PXuat) and MaNV not in (select MaNV from PXuat)