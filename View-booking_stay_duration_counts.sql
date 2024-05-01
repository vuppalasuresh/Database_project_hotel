CREATE VIEW booking_stay_duration_counts AS
SELECT
    SUM(CASE WHEN days >= 1 AND days <= 2 THEN 1 ELSE 0 END) AS One_or_More_than_one_day,
    SUM(CASE WHEN days > 2 AND days <= 5 THEN 1 ELSE 0 END) AS more_than_two_days,
    SUM(CASE WHEN days > 5 AND days <= 10 THEN 1 ELSE 0 END) AS more_than_five_days,
    SUM(CASE WHEN days > 10 THEN 1 ELSE 0 END) AS more_than_ten_days
FROM
    booking;
