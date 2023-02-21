use QLBH
go

create trigger delete_HD
on HoaDon
for delete 
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from deleted)
	declare @slb int
	set @slb = (select soluongban from deleted)
	update Hang
	set soluong = soluong + @slb
	where mahang = @mahang
end

create trigger update_HoaDon
on HoaDon
for update
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from deleted)

	declare @sltruoc int
	set @sltruoc = (select soluongban from deleted)
	declare @slsau int
	set @slsau = (select soluongban from inserted)
	declare @sl int
	set @sl = (select soluong from Hang 
					where mahang = @mahang)
	if (@sl < @slsau-@sltruoc)
	begin
		raiserror (N'Khong du hang', 16, 1)
		rollback tran
	end
	else 
		update Hang
		set soluong = soluong - (@slsau - @sltruoc)
		where mahang = @mahang
end

select * from Hang
select * from HoaDon

update HoaDon
set soluongban = 5
where mahd = 'H06'
select * from Hang
select * from HoaDon
