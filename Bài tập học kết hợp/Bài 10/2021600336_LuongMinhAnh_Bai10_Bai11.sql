use master 
go
create database QLBH
use QLBH
go

--a
create trigger trg_nhatkybanhang_insert
on Nhatkybanhang
for insert 
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from inserted)
	if (not exists(select * from MATHANG where mahang = @mahang))
	begin
		raiserror('Khong ton tai ma hang', 16, 1)
		rollback tran
	end
	else 
	begin
		declare @sl int
		set @sl = (select soluong from MATHANG where mahang = @mahang)
		declare @slb int
		set @slb = (select soluong from inserted)
		if (@sl<@slb)
		begin
			raiserror('Khong ton tai ma hang', 16, 1)
			rollback tran
		end
		else
			update MATHANG
			set soluong = soluong - @slb
			where mahang = @mahang
	end
end

select * from MATHANG
select * from Nhatkybanhang

insert into Nhatkybanhang values('2', '1999-02-3', 'cd', 3, 10, 30)

--b
alter trigger trg_nhatkybanhang_update_soluong
on Nhatkybanhang
for update
as
begin
	if (select count(*) from deleted)>1
		begin
			raiserror('Chi duoc xoa 1 ban ghi', 16, 1)
			rollback tran
			return
		end
	else 
	begin
		declare @mahang nchar(10)
		set @mahang = (select mahang from deleted)
		declare @slt int
		set @slt = (select soluong from deleted)
		declare @sls int
		set @sls = (select soluong from inserted)
		declare @sl int
		set @sl = (select soluong from MATHANG where mahang = @mahang)
		if (@sl < @sls-@slt)
		begin
			raiserror('Không đủ hàng', 16, 1)
			rollback tran
		end
		else 
			update MATHANG
			set soluong = soluong - (@sls - @slt)
			where mahang = @mahang
	end
end

select *from MATHANG 
select * from Nhatkybanhang
update Nhatkybanhang
set soluong = 5
where stt = 2
select *from MATHANG 
select * from Nhatkybanhang

; 
Disable trigger trg_nhatkybanhang_insert on Nhatkybanhang;
Disable trigger trg_nhatkybanhang_update_soluong on Nhatkybanhang;

--c
create trigger trg_nhatkybanhang_insert1
on Nhatkybanhang
for insert 
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from inserted)
	if (not exists(select * from MATHANG where mahang = @mahang))
	begin
		raiserror('Khong ton tai ma hang', 16, 1)
		rollback tran
	end
	else 
	begin
		declare @sl int
		set @sl = (select soluong from MATHANG where mahang = @mahang)
		declare @slb int
		set @slb = (select soluong from inserted)
		if (@sl<@slb)
		begin
			raiserror('Khong ton tai ma hang', 16, 1)
			rollback tran
		end
		else
			update MATHANG
			set soluong = soluong - @slb
			where mahang = @mahang
	end
end

select * from MATHANG
select * from Nhatkybanhang

insert into Nhatkybanhang values('2', '1999-02-3', 'cd', 3, 10, 30)

--d
create trigger trg_nhatkybanhang_update1_soluong
on Nhatkybanhang
for update
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from inserted)
	if (select count(*) from inserted ) >1
		begin
			raiserror('Khong duoc sua qua 1 dong lenh', 16, 1)
			rollback tran
			return
		end
	else 
		begin
			declare @sl int
			set @sl = (select soluong from MATHANG where mahang = @mahang)
			declare @slb int
			set @slb = (select soluong from inserted)
			if (@sl<@slb)
				begin
					raiserror('Khong ton tai ma hang', 16, 1)
					rollback tran
				end
			else
				update MATHANG
				set soluong = soluong - @slb
				where mahang = @mahang
		end
end

--e
create trigger trg_nhatkybanhang_delete 
on Nhatkybanhang
for delete
as
begin
	if (select count(*) from deleted)>1
		begin
			raiserror('Chi duoc xoa 1 ban ghi', 16, 1)
			rollback tran
			return
		end
	else
		begin
			declare @mahang nchar(10)
			select @mahang = mahang from deleted
			declare @slb int
			select @slb = soluong from deleted
			update MATHANG
			set soluong = soluong + @slb
			where mahang = @mahang
		end
end

select * from MATHANG
select * from Nhatkybanhang
delete from Nhatkybanhang
where stt = 2
select * from MATHANG
select * from Nhatkybanhang

create trigger trg_nhatkybanhang_update2
on Nhatkybanhang
for update
as
begin
	if (select count(*) from deleted)>1
		begin
			raiserror('Chi duoc update 1 ban ghi', 16, 1)
			rollback tran
			return
		end
	else 
		begin
			declare @mahang nchar(10)
			set @mahang = (select mahang from deleted)
			declare @slt int
			set @slt = (select soluong from deleted)
			declare @sls int
			set @sls = (select soluong from inserted)
			declare @sl int
			set @sl = (select soluong from MATHANG where mahang = @mahang)
			if (@sl < @sls-@slt)
			begin
				raiserror(N'Sai cập nhật', 16, 1)
				rollback tran
				return
			end
			else if (@slt = @sls)
			begin
			print ('bang')
				raiserror(N'Không cần cập nhật', 16, 1)
				rollback tran
				return
			end
			else
				update MATHANG
				set soluong = soluong - (@sls - @slt)
				where mahang = @mahang
		end
end

select *from MATHANG 
select * from Nhatkybanhang
update Nhatkybanhang
set soluong = 100
where stt = 1 
select *from MATHANG 
select * from Nhatkybanhang
;
disable trigger trg_nhatkybanhang_delete on Nhatkybanhang

--g
create proc delete_mathang @mh int
as
begin
	if (not exists(select * from mathang where mahang = @mh))
		begin
			print(N'Không tồn tại mã hàng')
			return
		end
	else 
		begin
			delete from MATHANG 
			where mahang = @mh
		end
end

select * from MATHANG
select * from Nhatkybanhang
exec delete_mathang 2
select * from MATHANG
select * from Nhatkybanhang

--h
create function tongtien_Nhatkybanhang (@th nvarchar(20))
returns float
begin
	declare @t float
	set @t = (select sum(MATHANG.soluong * giaban)
				from MATHANG
				inner join Nhatkybanhang
				on MATHANG.mahang = Nhatkybanhang.mahang
				where tenhang = @th)
	return @t 
end

select dbo.tongtien_Nhatkybanhang('Keo') as 'TongTien'
