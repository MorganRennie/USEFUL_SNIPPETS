-- Julian Date can come in two main formats:
-- CYYDDD (i.e. 124001 would be one day after the 24th year in the second centurary - Jan 1st 2024)
-- or the number of days since "Julian Day", Jan 1st 4713BC (i.e.  Jan 1st 2024 has the Julian Date of 2460310)

-- CREATE TESTING TABLE
CREATE TABLE JULIAN_DATE_PARSING
  (EXAMPLE_NUMBER TEXT,
  JULIAN_DATE_FORMAT TEXT,
  JULIAN_DATE TEXT);

-- WITH 2 TESTING VALUES
INSERT INTO JULIAN_DATE_PARSING
  VALUES
    (1,CYYDDD,124001),
    (2,DAYS_SINCE,2460310);

-- in the first example, the solution is as follows
-- Standard SQL // Snowflake SQL
  SELECT
        DATE(CONCAT(
            (LEFT('JULIAN_DATE',1)::INT + 19)
            , RIGHT(LEFT('JULIAN_DATE',3),2)
            ,'-01-01'))) AS NEW_DATE
  FROM JULIAN_DATE_PARSING
  WHERE EXAMPLE_NUMBER="1";

-- MYSQL
  SELECT
    ADDDATE(
      DATE(CONCAT(
         (LEFT(JULIAN_DATE,1)+19) 
         ,RIGHT(LEFT(JULIAN_DATE,3),2)
         ,"-01","-01")),
      INTERVAL 
      RIGHT(JULIAN_DATE,3) 
      DAY) AS 'NEW_DATE'
    FROM JULIAN_DATE_PARSING
    WHERE EXAMPLE_NUMBER="1";
 
-- MS SQL
  SELECT
    DATEADD(day, 
            CAST(RIGHT(JULIAN_DATE,3) AS INT),
            CONCAT(
              (LEFT(JULIAN_DATE,1) + 19)
              ,RIGHT(LEFT(JULIAN_DATE,3),2)
      	      ,'-01-01')
    ) AS NEW_DATE
  FROM JULIAN_DATE_PARSING
  WHERE EXAMPLE_NUMBER="1";

-- For the second Julian data type,
-- Standard SQL // Snowflake SQL - as SQL cannot handle negative year dates, an adjustment must be made.
SELECT
  DATEADD(day, 
    (JULIAN_DATE - 2400000), 
    '1858/11/16') AS NEW_DATE
FROM JULIAN_DATE_PARSING
WHERE EXAMPLE_NUMBER="2";

-- MYSQL
  SELECT
    ADDDATE(
      '1858/11/16'
      INTERVAL 
      (JULIAN_DATE- 2400000)
      DAY) AS 'NEW_DATE'
    FROM JULIAN_DATE_PARSING
    WHERE EXAMPLE_NUMBER="2";
 
-- MS SQL
  SELECT
    DATEADD(
      day, 
      JULIAN_DATE- 2400000),
      '1858/11/16'
      ) AS NEW_DATE
  FROM JULIAN_DATE_PARSING
  WHERE EXAMPLE_NUMBER="2";

