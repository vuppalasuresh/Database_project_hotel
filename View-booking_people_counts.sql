USE `cosc 640`;
CREATE VIEW booking_people_counts AS
SELECT
    SUM(CASE WHEN No_of_people >= 1 AND No_of_people <= 3 THEN 1 ELSE 0 END) AS One_or_More_than_one_person,
    SUM(CASE WHEN No_of_people > 3 AND No_of_people <= 5 THEN 1 ELSE 0 END) AS More_than_three_people,
    SUM(CASE WHEN No_of_people > 5 THEN 1 ELSE 0 END) AS More_than_five_people
FROM
    booking;

