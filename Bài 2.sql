USE rikkeiclinicdb;

DELIMITER //

CREATE TRIGGER PreventStatusRevert
BEFORE UPDATE ON appointments
FOR EACH ROW
BEGIN
	IF NEW.status = 'Completed' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT  = 'Lỗi Không thể tao tác với lịch khám này';
	END IF;
END //
DELIMITER ;

UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 104;

-- LỖI LÀ KHI NGƯỜI DÙNG SET GIÁ TRỊ MỚI VÀ SO SÁNH GIÁ TRỊ MỚI ĐÓ
-- CHỨ KHÔNG PHẢI LÀ DÙNG GIÁ TRỊ CŨ ĐỂ SO SÁNH XONG ĐÓ MỚI THAY GIÁ TRỊ MỚI VÀO
-- Ở ĐAY PHẢI SỬ DỤNG GIÁ TRỊ CŨ

DROP TRIGGER IF EXISTS PreventStatusRevert;

-- SỬA LẠI
DELIMITER //

CREATE TRIGGER PreventStatusRevert
BEFORE UPDATE ON appointments
FOR EACH ROW
BEGIN
	IF OLD.status = 'Completed' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT  = 'Lỗi Không thể tao tác với lịch khám này';
	END IF;
END //
DELIMITER ;

-- CHẠY TEST LẠI VÀ THÀNH CÔNG NẤU CHẠY 1 LẦN
UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 104;