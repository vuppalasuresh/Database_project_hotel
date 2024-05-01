CREATE VIEW booking_year_month_counts AS
SELECT 
    YEAR(checkin) AS Year, 
    MONTH(checkin) AS Month, 
    COUNT(*) AS BookingCount
FROM 
    booking
GROUP BY 
    YEAR(checkin), 
    MONTH(checkin)
ORDER BY 
    Year, 
    Month;
