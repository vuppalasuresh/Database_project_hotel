USE `cosc 640`;
CREATE VIEW service_details AS
SELECT
    s.ServiceID,
    s.serviceType,
    s.created_at,
    s.RoomID,
    c.email,
    c.Name AS customer_name
FROM
    services s
JOIN
    customer c ON s.customerID = c.id;
