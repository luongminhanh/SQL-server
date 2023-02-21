use QLBH
go

create trigger insert_HD
on HoaDon
for insert 
as
begin
	declare @mahang nchar(10)
	set @mahang = (select mahang from inserted)
	if (not exists(select * from Hang where mahang = @mahang))
		begin
			raiserror(N'Khong ton tai ma hang', 16, 1)
			rollback transaction
		end
	else 
		begin
			declare @sl int
			set @sl = (select soluong from Hang where mahang = @mahang)
			declare @slb int
			set @slb = (select soluongban from inserted)
			if (@sl < @slb) 
				begin
					raiserror(N'Khong du hang', 16, 1)
					rollback transaction
				end
			else 
				update Hang
				set soluong = @sl - @slb
				where mahang = @mahang
		end
end

select * from Hang
select * from HoaDon

insert into HoaDon values('H09', 'Ha02', 50, '2023-02-21')