WITH PASSENGERS_COUNT AS (
    SELECT
        a."Airport_Code",
        SUM(sub.Total_Flights * cr."Capacity") AS Total_Passengers
    FROM
        (
            SELECT
                "Departure_Airport_Code",
                "Aircraft_Id",
                COUNT(*) AS Total_Flights
            FROM
                individual_flights
            GROUP BY
                "Departure_Airport_Code", "Aircraft_Id"
        ) AS sub
    JOIN
        aircraft AS cr ON sub."Aircraft_Id" = cr."Aircraft_Id"
    JOIN
        airports AS a ON sub."Departure_Airport_Code" = a."Airport_Code"
    GROUP BY
        a."Airport_Code"
)

SELECT a.*, pc.Total_Passengers
FROM airports a
LEFT JOIN PASSENGERS_COUNT pc
ON a."Airport_Code" = pc."Airport_Code"