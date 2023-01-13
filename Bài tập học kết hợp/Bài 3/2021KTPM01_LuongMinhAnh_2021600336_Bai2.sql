use master
go
create database ThucTap
on primary (
	name = 'E:\ThucTap_dat',
	filename = 'E:\ThucTap.mdf',
	size = 10MB,
	maxsize = 100MB,
	filegrowth = 10MB
)
log on (
	name = 'E:\ThucTap_log',
	filename = 'E:\ThucTap.ldf',
	size = 1MB,
	maxsize = 5MB,
	filegrowth = 10%
)

use ThucTap
go
create table Khoa
(
	makhoa char(10) primary key,
	tenkhoa char(30) not null,
	dienthoai char(10) not null,
)
create table GiangVien
(
	magv int primary key,
	hotengv char(30) not null,
	luong decimal(5, 2) not null,
	makhoa char(10),
	constraint FK_GV foreign key(makhoa)
		references Khoa(makhoa)
)
create table SinhVien 
(
	masv int primary key,
	hotensv char(30),
	makhoa char(10), 
	namsinh int, 
	quequan char(10),
	constraint FK_SV foreign key(makhoa)
		references Khoa(makhoa)
)
create table DeTai
(
	madt char(10) primary key, 
	tendt char(30) not null,
	kinhphi int not null,
	NoiThucTap char(30) not null,
)
create table HuongDan
(
	masv int, 
	madt char(10), 
	magv int,
	ketqua decimal(5,2),
	constraint PK_HD primary key(masv),
	constraint FK_HD_SV foreign key(masv)
		references SinhVien(masv),
	constraint FK_HD_GV foreign key(magv)
		references GiangVien(magv),
	constraint FK_HD_DT foreign key(madt)
		references DeTai(madt)
)

insert into Khoa values('K01', 'CONG NGHE SINH HOC', '0985666777')
insert into Khoa values('K02', 'TOAN', '0987321222')
insert into Khoa values('K03', 'NGOAI NGU', '0987769222')
insert into Khoa values('K04', 'KINH TE', '0987323332')
insert into Khoa values('K05', 'DIA LY va QLTN', '0987898779')


insert into GiangVien values(111, 'Nguyen Thi Van', 12.55, 'K05')
insert into GiangVien values(112, 'Nguyen Thi Linh', 12.32, 'K02')
insert into GiangVien values(113, 'Le Tuan Nghia', 21.34, 'K01')
insert into GiangVien values(114, 'Tran Van Tuan', 11.22, 'K01')
insert into GiangVien values(115, 'Ly Van Nam', 30.11, 'K05')
insert into GiangVien values(116, 'Tran son', 32.11, 'K02')

insert into SinhVien values(211, 'Le van son', 'K01', 2003, 'Hai Duong')
insert into SinhVien values(212, 'Nguyen Thanh Nam', 'K02', 2002, 'Ha Noi')
insert into SinhVien values(213, 'Le Thi Thu', 'K01', 2003, 'Hai Phong')
insert into SinhVien values(214, 'Le Trung Nam', 'K03', 2003, 'Tay Ninh')
insert into SinhVien values(215, 'Nguyen Thi Tam', 'K02', 2001, 'Quang Binh')
insert into SinhVien values(216, 'Nguyen Nam Minh', 'K03', 2000, 'Ha Nam')
insert into SinhVien values(217, 'Nguyen Nam Minh', 'K05', 2001, 'Ha Noi')
insert into SinhVien values(218, 'Nguyen Nam', 'K03', 2000, 'Ha Nam')
insert into SinhVien values(219, 'Nguyen Minh', 'K05', 2001, 'Ha Noi')

insert into DeTai values ('D01', 'Robot', 1000000, 'FPT')
insert into DeTai values ('D02', 'May Tien', 2000000, 'Hoa Phat')
insert into DeTai values ('D03', 'An ninh mang', 3000000, 'VNPT')
insert into DeTai values ('D04', 'Van hoa giao duc', 3000000, 'Van Linh')
insert into DeTai values ('D05', 'Tam ly', 3000000, 'Tang Phu')
insert into DeTai values ('D06', 'Thuoc', 3000000, 'Ha Nam')
insert into DeTai values ('D07', 'Ca nhac', 3000000, 'Ha Noi')

insert into HuongDan values (211, 'D01', 111, 5.22)
insert into HuongDan values (213, 'D01', 115, 9.21)
insert into HuongDan values (212, 'D01', 112, 7.92)
insert into HuongDan values (214, 'D03', 116, 10.21)
insert into HuongDan values (215, 'D02', 116, 7.52)
insert into HuongDan values (216, 'D02', 116, 0)
insert into HuongDan values (217, 'D02', 116, 9.01)
insert into HuongDan values (218, 'D06', 116, 0)
insert into HuongDan values (219, 'D07', 116, 9.01)

--1. Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
select DeTai.madt, tendt
from HuongDan
inner join GiangVien on HuongDan.magv = GiangVien.magv
inner join DeTai on HuongDan.madt = DeTai.madt
where hotengv = 'Tran son'

--2. Cho biết tên đề tài không có sinh viên nào thực tập
select tendt 
from DeTai
where DeTai.madt not in (select madt from HuongDan)

--3. Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên  trở lên.
select GiangVien.magv, hotengv, tenkhoa
from GiangVien
inner join HuongDan on GiangVien.magv = HuongDan.magv
inner join Khoa on Khoa.makhoa = GiangVien.makhoa
group by GiangVien.magv, hotengv, tenkhoa
having count(distinct masv)>=3

--4. Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
select madt, tendt 
from DeTai
where kinhphi >= all(select MAX(kinhphi) from DeTai)

--5. Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select DeTai.madt, tendt
from DeTai
inner join HuongDan on DeTai.madt = HuongDan.madt
group by DeTai.madt, tendt
having count(masv)>=2

--6. Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
select SinhVien.masv, hotensv, ketqua
from SinhVien
inner join HuongDan on SinhVien.masv = HuongDan.masv
inner join Khoa on Khoa.makhoa = SinhVien.makhoa
where tenkhoa = 'DIA LY va QLTN'

--7. Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
select tenkhoa, count(masv) as SoSV
from Khoa
inner join SinhVien on Khoa.makhoa = SinhVien.makhoa
group by tenkhoa

--8. Cho biết thông tin về các sinh viên thực tập tại quê nhà
select SinhVien.masv, hotensv, makhoa, namsinh, quequan from SinhVien
inner join HuongDan on SinhVien.masv = HuongDan.masv
inner join DeTai on DeTai.madt = HuongDan.madt
where quequan = NoiThucTap

--9. Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
select SinhVien.masv, hotensv, makhoa, namsinh, quequan
from SinhVien
inner join HuongDan on SinhVien.masv = HuongDan.masv 
where ketqua = null

--10.Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
select SinhVien.masv, hotensv
from SinhVien
inner join HuongDan on SinhVien.masv = HuongDan.masv 
where ketqua = 0
