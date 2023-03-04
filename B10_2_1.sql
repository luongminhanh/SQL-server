CREATE TRIGGER HoaDon_Xoa ON HoaDon AFTER DELETE
AS
BEGIN
	DECLARE @MaHang VARCHAR(10), @SoLuongBan INT

	SELECT @MaHang = MaHang, @SoLuongBan = SoLuongBan
	FROM deleted

	UPDATE Hang
	SET SoLuong += @SoLuongBan
	WHERE MaHang = @MaHang
END