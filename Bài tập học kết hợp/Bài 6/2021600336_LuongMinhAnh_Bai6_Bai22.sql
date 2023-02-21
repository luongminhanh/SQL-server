use QLKHO
go
--cau 2
select TenVT
from Ton
where SoLuongT = (select max(SoLuongT) from Ton)
--cau 3
select TenVT
from Ton
inner join Xuat on Ton.MaVT = Xuat.MaVT
group by TenVT
having sum(SoLuongX) > 100
--cau 4
create view cau4
as
select Month(NgayX) as 'Thang', Year(NgayX) as 'Nam', sum(SoluongX) as 'TongX'
from Xuat
group by Month(NgayX), Year(NgayX)

select * from cau4
--cau 5
create view cau5
as
select Nhap.MaVT, TenVT, sum(SoLuongN) as 'TongSLN', 
sum(DonGiaN) as 'DonGiaN', sum(SoLuongX) as 'TongSLX',
sum(DonGiaX) as 'DonGiaX', Day(NgayN) as 'NgayN', Day(NgayX) as 'NgayX'
from Nhap inner join Ton on Nhap.MaVT = Ton.MaVT
inner join Xuat on Nhap.MaVT = Xuat.MaVT
group by Nhap.MaVT, TenVT, NgayN, NgayX

select * from cau5
--cau 6
create view cau6
as
select Ton.MaVT, TenVT, sum(SoLuongN) - sum(SoLuongX) + sum(SoLuongT) as 'Con'
from Ton inner join Nhap on Ton.MaVT = Nhap.MaVT
inner join Xuat on Ton.MaVT = XUat.MaVT
where year(NgayN) = 2015
group by Ton.MaVT, TenVT


select * from cau6


