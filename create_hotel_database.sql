CREATE DATABASE IF NOT EXISTS hotel;

USE hotel;

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `Email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userType` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
);
 
DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phoneNumber` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);
 
DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phoneNumber` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);
 
DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `Roomid` int NOT NULL,
  `Roomtype` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Roomid`)
);
 
DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `review` text COLLATE utf8mb4_general_ci,
  `customerID` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  KEY `customerID` (`customerID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`id`)
);
 
DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `ServiceID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `RoomID` int DEFAULT NULL,
  `ServiceType` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ServiceID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `RoomID` (`RoomID`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`id`),
  CONSTRAINT `services_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `room` (`Roomid`)
);
 
DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `amenity_id` int NOT NULL,
  `amenity_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`amenity_id`)
) ;
 
DROP TABLE IF EXISTS `roomamenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomamenities` (
  `room_id` int NOT NULL,
  `amenity_id` int NOT NULL,
  PRIMARY KEY (`room_id`,`amenity_id`),
  KEY `amenity_id` (`amenity_id`),
  CONSTRAINT `roomamenities_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`Roomid`),
  CONSTRAINT `roomamenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`amenity_id`)
);

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `bookingId` int NOT NULL AUTO_INCREMENT,
  `checkin` date DEFAULT NULL,
  `checkout` date DEFAULT NULL,
  `No_of_people` int DEFAULT NULL,
  `days` int DEFAULT NULL,
  `breakfast` varchar(5) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer` int DEFAULT NULL,
  `roomId` int DEFAULT NULL,
  `staffID` int DEFAULT NULL,
  PRIMARY KEY (`bookingId`),
  KEY `customer` (`customer`),
  KEY `roomId` (`roomId`),
  KEY `staffID` (`staffID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer`) REFERENCES `customer` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`roomId`) REFERENCES `room` (`Roomid`),
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`)
);
 
DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `receiptId` int NOT NULL AUTO_INCREMENT,
  `checkedin` datetime DEFAULT NULL,
  `checkedout` datetime DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `bookingID` int DEFAULT NULL,
  PRIMARY KEY (`receiptId`),
  KEY `bookingID` (`bookingID`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`bookingID`) REFERENCES `booking` (`bookingId`)
);
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