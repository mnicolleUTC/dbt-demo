WITH RPM_Summary AS (
    SELECT
        "Airline_Code",
        DATE_TRUNC('YEAR', TO_DATE("Date", 'DD/MM/YYYY')) AS Year,
        SUM(COALESCE("RPM_Domestic", 0)) AS Total_RPM_Domestic,
        SUM(COALESCE("RPM_International", 0)) AS Total_RPM_International,
        SUM(COALESCE("RPM_Domestic", 0) + COALESCE("RPM_International", 0)) AS Total_RPM
    FROM
        raw.public.flight_summary_data
    GROUP BY
        "Airline_Code", Year
),
Ranked_RPM AS (
    SELECT
        "Airline_Code",
        Year,
        Total_RPM_Domestic,
        Total_RPM_International,
        Total_RPM,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM_Domestic DESC) AS Rank_Domestic,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM_International DESC) AS Rank_International,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM DESC) AS Rank_Total
    FROM
        RPM_Summary
),
BEST_YEARS AS (
    SELECT
        "Airline_Code",
        Year,
        Total_RPM_Domestic,
        Total_RPM_International,
        Total_RPM
    FROM
        Ranked_RPM
    WHERE
        Rank_Domestic = 1 OR Rank_International = 1 OR Rank_Total = 1
)
SELECT a.*, BEST_YEARS.Year, BEST_YEARS.Total_RPM
FROM airlines a
LEFT JOIN BEST_YEARS
ON a."Airline_Code" = BEST_YEARS."Airline_Code"
