ALTER TRIGGER HoaDon_KiemTra ON HoaDon AFTER INSERT
AS
BEGIN
	DECLARE @MaHang VARCHAR(10), @SoLuongBan INT

	SELECT @MaHang = MaHang, @SoLuongBan = SoLuongBan
	FROM inserted
	IF NOT EXISTS(	SELECT MaHang
					FROM Hang
					WHERE MaHang = @MaHang)
	BEGIN
		RAISERROR(N'Tên hàng không tồn tại', 16, 1)
		ROLLBACK TRAN
		RETURN
	END
	DECLARE @SoLuong INT
	SET @SoLuong = (	SELECT SoLuong
						FROM Hang
						WHERE MaHang = @MaHang)
	IF @SoLuong < @SoLuongBan
	BEGIN
		RAISERROR(N'Không đủ số lượng bán', 16, 1)
		ROLLBACK TRAN
		RETURN
	END
	UPDATE Hang
	SET SoLuong -= @SoLuongBan
	WHERE MaHang = @MaHang
END