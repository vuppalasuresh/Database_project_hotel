USE hotel;

DELIMITER //
CREATE TRIGGER calculate_days_trigger
BEFORE INSERT ON booking
FOR EACH ROW 
BEGIN
    SET NEW.days = DATEDIFF(NEW.checkout, NEW.checkin);
END;
//
DELIMITER ;