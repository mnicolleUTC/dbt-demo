WITH ASM_Per_Year AS (
    SELECT
        "Airline_Code",
        DATE_TRUNC('YEAR', TO_DATE("Date", 'DD/MM/YYYY')) AS Year,
        AVG("ASM_Domestic") AS Avg_ASM_Domestic,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY AVG("ASM_Domestic") DESC) AS Rank
    FROM
        flight_summary_data
    GROUP BY
        "Airline_Code", Year
),
BEST_ASM_Airline AS (
SELECT
    "Airline_Code",
    Year,
    Avg_ASM_Domestic AS MAX_ASM
FROM
    ASM_Per_Year
WHERE
    Rank = 1
ORDER BY
    "Airline_Code"
)
SELECT a.*, BEST_ASM_Airline.MAX_ASM
FROM airlines a
LEFT JOIN BEST_ASM_Airline
ON a."Airline_Code" = BEST_ASM_Airline."Airline_Code"