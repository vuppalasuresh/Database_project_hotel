SET @@SESSION.SQL_LOG_BIN= 0;
SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;

USE hotel;
SET GLOBAL log_bin_trust_function_creators = 1;
#########################################################################################################################
CREATE TRIGGER calculate_days_trigger
BEFORE INSERT ON booking
FOR EACH ROW 
SET NEW.days = DATEDIFF(NEW.checkout, NEW.checkin);
##########################################################################################################################
DELIMITER //
DROP PROCEDURE IF EXISTS CalculateAndUpdatePrice;
 
DELIMITER //

CREATE PROCEDURE CalculateAndUpdatePrice(
    IN bookid INT,
    IN days INT
)
BEGIN
    DECLARE roomPrice DECIMAL(10, 2);
    DECLARE totalPrice DECIMAL(10, 2);
 
    -- Get the price from the room table based on bookingId
    SELECT r.price INTO roomPrice
    FROM room r
    INNER JOIN booking b ON b.roomId = r.Roomid
    WHERE b.bookingId = bookid;
 
    -- Debug: Print roomPrice
    -- SELECT roomPrice AS debug_roomPrice;
    -- SELECT bookid AS debug_roomPrice;
 
    -- Calculate the total price
    SET totalPrice = roomPrice * days;
 
    -- Debug: Print totalPrice
    -- Debug: Print bookingId
 
    -- Update the receipt table with the calculated price for each row
    UPDATE receipt
    SET Amount = totalPrice
    WHERE bookingID = bookid;
END //
 
DELIMITER ;
##########################################################################################################################