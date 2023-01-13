use master
go
create database QLSV
on primary(
	name='QLSV_dat',
	filename='E:\QLSV.mdf',
	size=10MB,
	maxsize=100MB,
	filegrowth=10MB
)
log on(
	name='QLSV_log',
	filename='E:\QLSV.ldf',
	size=1MB,
	maxsize=5MB,
	filegrowth=20%
)

use QLSV
go
create table SV (
	MaSV nchar(10) not null primary key,
	TenSV nvarchar(20) not null,
	Que nvarchar(20)
)
create table MON (
	MaMH nchar(10) not null primary key,
	TenMH nvarchar(20) not null,
	Sotc int,
	constraint unique_MH unique(TenMH),
	constraint chk_Sotc check(Sotc <= 5 and Sotc>=2)
)
create table KQ (
	MaSV nchar(10) not null,
	MaMH nchar(10) not null, 
	Diem int,
	constraint PK_KQ Primary Key(MaSV, MaMH),
	constraint chk_Diem check(Diem>=0 and Diem<=10),
	constraint FK_KQ_SV foreign key(MaSV)
		references SV(MaSV),
	constraint FK_KQ_MON foreign key(MaMH)
		references MON(MaMH)
)

insert into SV (MaSV, TenSV, Que) values ('2021405222', 'Nguyen Van A', 'Thai Binh')
insert into SV (MaSV, TenSV, Que) values ('2020421332', 'Tran Khanh Du', 'Nam Dinh')
insert into SV (MaSV, TenSV, Que) values ('2019222131', 'Ly Thi Nam', 'Ha Nam')

insert into MON (MaMH, TenMH, Sotc) values ('IT6018', 'Giai tich', 3)
insert into MON (MaMH, TenMH, Sotc) values ('TP2311', 'TPLVCN', 2)
insert into MON (MaMH, TenMH, Sotc) values ('IT6008', 'Java', 3)

insert into KQ (MaSV, MaMH, Diem) values ('2021405222', 'TP2311', 9)
insert into KQ (MaSV, MaMH, Diem) values ('2020421332', 'IT6008', 10)
insert into KQ (MaSV, MaMH, Diem) values ('2021405222', 'IT6018', 9)
insert into KQ (MaSV, MaMH, Diem) values ('2020421332', 'TP2311', 9)
insert into KQ (MaSV, MaMH, Diem) values ('2019222131', 'IT6018', 10)
insert into KQ (MaSV, MaMH, Diem) values ('2019222131', 'IT6008', 9)


