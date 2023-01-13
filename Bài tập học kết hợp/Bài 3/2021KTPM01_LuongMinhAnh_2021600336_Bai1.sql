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

insert into SinhVien values(211, 'Le van son', 'K01', 2003, 'Hai Duong')
insert into SinhVien values(212, 'Nguyen Thanh Nam', 'K02', 2002, 'Ha Noi')
insert into SinhVien values(213, 'Le Thi Thu', 'K01', 2003, 'Hai Phong')
insert into SinhVien values(214, 'Le Trung Nam', 'K03', 2003, 'Tay Ninh')
insert into SinhVien values(215, 'Nguyen Thi Tam', 'K02', 2001, 'Quang Binh')

insert into DeTai values ('D01', 'Robot', 1000000, 'FPT')
insert into DeTai values ('D02', 'May Tien', 2000000, 'Hoa Phat')
insert into DeTai values ('D03', 'An ninh mang', 3000000, 'VNPT')

insert into HuongDan values (211, 'D01', 111, 5.22)
insert into HuongDan values (213, 'D01', 115, 9.21)
insert into HuongDan values (212, 'D01', 112, 7.92)

--Cau 2.1 Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên

select magv, hotengv, tenkhoa
from GiangVien
inner join Khoa on GiangVien.makhoa = Khoa.makhoa

--Cau 2.2 Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’select magv, hotengv, tenkhoa
from GiangVieninner join Khoa on GiangVien.makhoa = Khoa.makhoawhere tenkhoa = 'DIA LY va QLTN'
--Cau 2.3 Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’select count(masv) as 'SoSV'
from SinhVien 
inner join Khoa on SinhVien.makhoa = Khoa.makhoa
where tenkhoa = 'CONG NGHE SINH HOC'

--Cau 2.4 Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
select masv, hotensv, (year(getdate()) - SinhVien.namsinh) as 'tuoi'
from SinhVien
inner join Khoa on SinhVien.makhoa = Khoa.makhoa
where tenkhoa = 'TOAN'

--Cau 2.5 Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
select count(magv) as 'SoGV'
from GiangVien
inner join Khoa on GiangVien.makhoa = Khoa.makhoa
where tenkhoa = 'CONG NGHE SINH HOC'

--Cau 2.6  Cho biết thông tin về sinh viên không tham gia thực tậpselect * from SinhVienwhere masv not in (select masv from HuongDan)--Cau 2.7  Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoaselect Khoa.makhoa, tenkhoa, count(magv) as 'SoGV'from Khoa inner join GiangVien on Khoa.makhoa = GiangVien.makhoagroup by Khoa.makhoa, tenkhoa --Cau 2.8 ho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo họcselect Khoa.dienthoai from Khoainner join SinhVien on Khoa.makhoa = SinhVien.makhoawhere hotensv = 'Le van son'