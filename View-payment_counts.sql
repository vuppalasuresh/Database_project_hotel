USE `cosc 640`;
CREATE VIEW payment_counts AS
SELECT
    'Cash' AS payment_type,
    COUNT(*) AS count
FROM
    booking
WHERE
    payment = 'cash'
UNION
SELECT
    'Credit Card' AS payment_type,
    COUNT(*) AS count
FROM
    booking
WHERE
    payment = 'Credit Card'
UNION
SELECT
    'Debit Card' AS payment_type,
    COUNT(*) AS count
FROM
    booking
WHERE
    payment = 'Debit Card';
