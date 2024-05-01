USE `cosc 640`;
CREATE VIEW review_details AS
SELECT
    r.reviewID,
    r.review,
    r.created_at,
    r.rating,
    c.Name,
    c.email
FROM
    reviews r
JOIN
    customer c ON c.id = r.customerID;
