CREATE TRIGGER HoaDon_CapNhat ON HoaDon AFTER UPDATE
AS
BEGIN
	DECLARE @MaHang VARCHAR(10), @SoLuongBan1 INT, @SoLuongBan2 INT

	SELECT @MaHang = MaHang, @SoLuongBan1 = SoLuongBan
	FROM deleted

	SELECT @SoLuongBan2 = SoLuongBan
	FROM inserted

	UPDATE Hang
	SET SoLuong -= (@SoLuongBan2 - @SoLuongBan1)
	WHERE MaHang = @MaHang
END