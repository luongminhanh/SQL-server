use QLBanHang 
go
--cau c
alter view cauc
as
select sum(DonGiaN) as 'TongN'
from Nhap inner join SanPham on Nhap.MaSP = SanPham.MaSP
inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
inner join PNhap on PNhap.SoHDN = Nhap.SoHDN
where TenHang = 'Samsung' and year(NgayNhap) = 2020

select * from cauc

--cau c
create view caud
as
select sum(GiaBan * SoLuongX) as 'TongX' 
from SanPham
inner join Xuat on Xuat.MaSP = SanPham.MaSP
inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
where NgayXuat = '2020-06-14'

select * from caud

--cau e
create view caue
as
select Nhap.SoHDN, NgayNhap from PNhap
inner join Nhap on Nhap.SoHDN = PNhap.SoHDN
where SoLuongN * DonGiaN >= all(select SoLuongN * DonGiaN
from Nhap) and year(NgayNhap) = 2020

select * from caue

--cau f

create view cauf
as
select HangSX.MaHangSX, count(MaSP) as 'SoSP'
from HangSX inner join SanPham on HangSX.MaHangSX = SanPham.MaHangSX
group by HangSX.MaHangSX

select * from cauf

--cau h
create view cauh
as
select MaSP, sum(SoLuongX)
from Xuat
inner join PXuat on Xuat.SoHDX = PXuat.SoHDX
where year(NgayXuat) = 2020
group by MaSP

select * from cauh

--cau i 
create view caui
as
select TenPhong, count(MaNV) 
from NhanVien
where GioiTinh= 'Nam'
group by TenPhong

select * from caui

--cau k
create view cauk
select MaNV, sum(GiaBan * SoLuongX)
from Xuat 
inner join PXuat on Xuat.SoHDX = PXuat.SoHDX
inner join SanPham on Xuat.MaSP = SanPham.MaSP
group by MaNV

select * from cauk


