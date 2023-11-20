WITH FLIGHTCOUNT AS (
    SELECT "Aircraft_Id", COUNT(*) AS FLIGHTCOUNT
    FROM individual_flights
    GROUP BY "Aircraft_Id"
)
SELECT a.*, fc.FLIGHTCOUNT
FROM aircraft a
LEFT JOIN FLIGHTCOUNT fc 
ON a."Aircraft_Id" = fc."Aircraft_Id"