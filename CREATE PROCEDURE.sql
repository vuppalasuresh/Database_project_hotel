USE hotel;
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