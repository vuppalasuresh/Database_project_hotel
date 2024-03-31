USE hotel;


-- Set the global variable to allow trigger creation
SET GLOBAL log_bin_trust_function_creators = 1;

-- Create the trigger
DELIMITER //
CREATE TRIGGER calculate_days_trigger
BEFORE INSERT ON booking
FOR EACH ROW 
BEGIN
    SET NEW.days = DATEDIFF(NEW.checkout, NEW.checkin);
END;
//
DELIMITER ;