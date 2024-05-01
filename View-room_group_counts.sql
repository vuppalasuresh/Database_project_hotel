USE `cosc 640`;
CREATE VIEW room_group_counts AS
SELECT
    CASE
        WHEN roomID IN ('101', '102', '103') THEN 'Group 1'
        WHEN roomID IN ('104', '105', '106') THEN 'Group 2'
        WHEN roomID IN ('107', '108', '109') THEN 'Group 3'
    END AS roomGroup,
    COUNT(*) AS count
FROM
    booking
WHERE
    roomID IN ('101', '102', '103', '104', '105', '106', '107', '108', '109')
GROUP BY
    roomGroup;
