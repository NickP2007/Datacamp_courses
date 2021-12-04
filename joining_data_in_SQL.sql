--- INTRODUCTION TO JOINS

--- Inner Join

-- Select all columns from cities
SELECT * 
FROM cities

SELECT * 
FROM cities
-- Inner join to countries
INNER JOIN countries
-- Match on the country codes
ON cities.country_code = countries.code;
    
-- Select name fields (with alias) and region 
SELECT cities.name AS city, countries.name AS country, region
-- JOINING DATA IN SQL
FROM cities 
INNER JOIN countries 
ON cities.country_code = countries.code;

--- Inner Join (2)

-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e 
-- Match on code
ON c.code = e.code;
  
-- Select fields
SELECT c.code, c.name, c.region, p.year,
  p.fertility_rate
-- From countries (alias as c)
FROM countries AS c
-- Join with populations (as p)
INNER JOIN populations AS p
-- Match on country code
ON c.code = p.country_code

-- Select fields
SELECT c.code, name, region, e.year, fertility_rate,
  e.unemployment_rate
-- From countries (alias as c)
FROM countries AS c
-- Join to populations (as p)
INNER JOIN populations AS p
-- Match on country code
ON c.code = p.country_code
-- Join to economies (as e)
INNER JOIN economies AS e
-- Match on country code
ON p.country_code = e.code;

-- Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
-- From countries (alias as c)
FROM countries AS c
-- Join to populations (as p)
INNER JOIN populations AS p
-- Match on country code
ON c.code = p.country_code
-- Join to economies (as e)
INNER JOIN economies AS e
-- Match on country code and year
ON c.code = e.code AND e.year = p.year;
  
--- Inner join with using

-- Select fields
SELECT c.name AS country,
  c.continent, 
  l.name AS language,
  l.official
-- From countries (alias as c)
FROM countries AS c
-- Join to languages (as l)
INNER JOIN languages AS l
-- Match using code
USING(code)

--- Self-join

-- Select fields with aliases
SELECT p1.country_code, 
p1.size AS size2010,
p2.size AS size2015
-- From populations (alias as p1)
FROM populations AS p1
-- Join to itself (alias as p2)
JOIN populations AS p2
-- Match on country code
ON p1.country_code = p2.country_code 

-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
-- From populations (alias as p1)
FROM populations as p1
-- Join to itself (alias as p2)
INNER JOIN populations as p2
-- Match on country code
ON p1.country_code = p2.country_code
-- and year (with calculation)
AND p1.year = p2.year - 5

-- Select fields with aliases
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- Calculate growth_perc
       ((p2.size - p1.size)/p1.size * 100.0) AS     growth_perc
-- From populations (alias as p1)
FROM populations AS p1
-- Join to itself (alias as p2)
INNER JOIN populations AS p2
-- Match on country code
ON p1.country_code = p2.country_code
-- and year (with calculation)
AND p1.year = p2.year - 5;

--- Case when and then

SELECT name, continent, code, surface_area,
    -- First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- Second case
        WHEN surface_area > 350000 THEN 'medium'
        -- Else clause + end
        ELSE 'small' END
        -- Alias name
        AS geosize_group
-- From table
FROM countries;

--- Inner challenge

SELECT country_code, size,
    -- First case
    CASE WHEN size > 50000000 THEN 'large'
        -- Second case
        WHEN size > 1000000 THEN 'medium'
        -- Else clause + end
        ELSE 'small' END
        -- Alias name (popsize_group)
        AS popsize_group
-- From table
FROM populations
-- Focus on 2015
WHERE year = 2015;

SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

-- Select fields
SELECT name, continent, geosize_group, popsize_group
-- From countries_plus (alias as c)
FROM countries_plus AS c
-- Join to pop_plus (alias as p)
INNER JOIN pop_plus AS p
  -- Match on country code
  ON c.code = p.country_code
-- Order the table    
ORDER BY 3 ASC;

--- OUTER JOINS AND CROSS JOINS

--- Left Join

-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
INNER JOIN countries AS c2
  -- Match on country code
  ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;

SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
-- Join right table (with alias)
LEFT JOIN countries AS c2
  -- Match on country code
  ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code DESC;

--- Left join (2)

/*
Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- From left table (alias as c)
FROM countries AS c
-- Join to right table (alias as l)
INNER JOIN languages AS l
  -- Match on fields
  ON c.code = l.code
-- Order by descending country
ORDER BY country DESC;

/*
Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- From left table (alias as c)
FROM countries AS c
-- Join to right table (alias as l)
LEFT JOIN languages AS l
  -- Match on fields
  ON c.code = l.code
-- Order by descending country
ORDER BY country DESC;

--- Left join (3)

-- Select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- From countries (alias as c)
FROM countries AS c
-- Left join with economies (alias as e)
LEFT JOIN economies AS e
  -- Match on code fields
  ON c.code = e.code
-- Focus on 2010
WHERE year = 2010;

-- Select fields
SELECT region, AVG(gdp) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region;

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
-- Left join with economies (alias as e)
LEFT JOIN economies AS e
  -- Match on code fields
  ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region;

-- Select fields
SELECT region, AVG(gdp_percapita) AS avg_gdp
-- From countries (alias as c)
FROM countries AS c
  -- Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- Match on code fields
    ON c.code = e.code
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY region
-- Order by descending avg_gdp
ORDER BY avg_gdp DESC;

--- Right join

