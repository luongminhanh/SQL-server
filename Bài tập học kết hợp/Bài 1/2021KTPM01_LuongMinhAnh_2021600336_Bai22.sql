use master
go
create database QLBanHang
on primary(
	name='QLBH_dat',
	filename='E:\QLBH.mdf',
	size=10MB,
	maxsize=100MB,
	filegrowth=10MB
)
log on(
	name='QLBH_log',
	filename='E:\QLBH.ldf',
	size=1MB,
	maxsize=5MB,
	filegrowth=20%
)

use QLBanHang
go
create table Congty (
	MaCT nchar(10) not null primary key,
	TenCT nvarchar(20) not null,
	TrangThai nvarchar(20),
	ThanhPho nvarchar(20),
)
create table SanPham (
	MaSP nchar(10) not null primary key,
	TenSP nvarchar(20) not null,
	MauSac nvarchar(10) default N'Đỏ',
	Gia money not null,
	SoLuongCo int not null,
	constraint unique_SP unique(TenSP),
)
create table Cungung (
	MaCT nchar(10) not null,
	MaSP nchar(10) not null, 
	SoLuongBan int not null,
	constraint PK_CT Primary Key(MaCT, MaSP),
	constraint chk_SLB check(SoLuongBan>0),
	constraint FK_CU_CT foreign key(MaCT)
		references CongTy(MaCT),
	constraint FK_CU_SP foreign key(MaSP)
		references SanPham(MaSP)
)

insert into CongTy (MaCT, TenCT, TrangThai, ThanhPho) values ('HN001', 'Tan Nam', 'Dang hoat dong', 'Ha Noi')
insert into CongTy (MaCT, TenCT, TrangThai, ThanhPho) values ('TN301', 'Van Son', 'Dang hoat dong', 'Tay Ninh')
insert into CongTy (MaCT, TenCT, TrangThai, ThanhPho) values ('LC081', 'Phu Son', 'Dang hoat dong', 'Lao Cai')

insert into SanPham (MaSP, TenSP, Gia, SoLuongCo) values ('001', 'Banh Quy', 1000, 10000)
insert into SanPham (MaSP, TenSP, Gia, SoLuongCo) values ('002', 'Keo bo', 2000, 20000)
insert into SanPham (MaSP, TenSP, Gia, SoLuongCo) values ('003', 'Nuoc ngot', 3000, 10000)

insert into Cungung (MaCT, MaSP, SoLuongBan) values ('HN001', '001', 500)
insert into Cungung (MaCT, MaSP, SoLuongBan) values ('TN301', '003', 2000)
insert into Cungung (MaCT, MaSP, SoLuongBan) values ('LC081', '001', 100)
insert into Cungung (MaCT, MaSP, SoLuongBan) values ('HN001', '002', 200)
insert into Cungung (MaCT, MaSP, SoLuongBan) values ('TN301', '001', 100)
insert into Cungung (MaCT, MaSP, SoLuongBan) values ('LC081', '002', 100)
