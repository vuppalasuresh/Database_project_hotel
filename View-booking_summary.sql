CREATE VIEW booking_summary AS
SELECT
    SUM(CASE WHEN breakfast = 'on' THEN 1 ELSE 0 END) AS Customers_who_had_breakfast,
    SUM(CASE WHEN breakfast IS NULL THEN 1 ELSE 0 END) AS Customers_who_did_not_have_breakfast
FROM
    booking;
