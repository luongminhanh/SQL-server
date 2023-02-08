create database QLKHO
go
use QLKHO
go
create table Nhap (
	SoHDN nchar(10),
	MaVT nchar(10),
	SoLuongN int,
	DonGiaN money,
	NgayN date
)
create table Xuat (
	SoHDX nchar(10),
	MaVT nchar(10),
	SoLuongX int,
	DonGiaX money,
	NgayX date
)
create table Ton (
	MaVT nchar(10),
	TenVT nvarchar(20),
	SoLuongT int
)

insert into Nhap
values ('N001', 'VT002', 20, 230, '2021-02-21'),
('N002', 'VT002', 25, 200, '2021-03-31'),
('N003', 'VT005', 2, 210, '2021-02-22')

insert into Xuat 
values ('X001', 'VT002', 17, 230, '2021-02-21'),
('X002', 'VT003', 20, 200, '2021-03-31')

insert into Ton 
values ('VT001', 'Xe may', 2),
('VT002', 'Xe dap', 1),
('VT003', 'Thuyen', 1),
('VT004', 'Tau', 1),
('VT005', 'O to', 1)

--Thống kê tiền bán theo mã vật tư gồm MaVT, TenVT, TienBan (TienBan=SoLuongX*DonGiaX) 
CREATE VIEW CAU2
as
select Xuat.MaVT, TenVT, sum(SoLuongX*DonGiaX) as 'TienBan'
from Ton inner join Xuat on Ton.MaVT = Xuat.MaVT
group by Xuat.MaVT, TenVT

--Thống kê soluongxuat theo tên vattu
create view CAU3
as 
select TenVT, sum(SoLuongX) as 'TongLuongXuat'
from Xuat inner join Ton on Xuat.MaVT = Ton.MaVT
group by TenVT

--Thống kê soluongnhap theo tên vật tư
create view CAU4
as 
select TenVT, sum(SoLuongN) as 'TongLuongNhap'
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
group by TenVT

--Đưa ra tổng soluong còn trong kho biết còn = nhap – xuất + tồn theo từng 
--nhóm vật tư

create view CAU5
as
select TenVT, sum(SoluongN-SoluongX+SoLuongT) as 'SoLuong'
from Nhap inner join Xuat on Nhap.MaVT = Xuat.MaVT
inner join Ton on Nhap.MaVT = Ton.MaVT
group by TenVT

