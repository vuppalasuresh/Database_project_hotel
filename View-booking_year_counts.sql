CREATE VIEW booking_year_counts AS
SELECT 
    YEAR(checkin) AS Year, 
    COUNT(*) AS BookingCount
FROM 
    booking
WHERE
    YEAR(checkin) IN (2012, 2022, 2023, 2024, 2025, 2026, 2027)
GROUP BY 
    YEAR(checkin)
ORDER BY 
    Year;
