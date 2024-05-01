CREATE VIEW rating_counts AS
SELECT
    rating,
    COUNT(*) AS count
FROM
    reviews
WHERE
    rating >= 1 AND rating <= 5
GROUP BY
    rating;
