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

-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages 
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;

--- Full Join

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
-- Join to currencies
FULL JOIN currencies
  -- Match on code
  USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
-- Join to currencies
LEFT JOIN currencies
  -- Match on code
  USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

SELECT name AS country, code, region, basic_unit
-- From countries
FROM countries
-- Join to currencies
INNER JOIN currencies
  -- Match on code
  USING (code)
-- Where region is North America or null
WHERE region = 'North America' OR region IS NULL
-- Order by region
ORDER BY region;

--- Full Join(2)

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
-- Join to countries
FULL JOIN countries
  -- Match on code
  USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
-- Join to countries
LEFT JOIN countries
  -- Match on code
  USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name;

SELECT countries.name, code, languages.name AS language
-- From languages
FROM languages
-- Join to countries
INNER JOIN countries
  -- Match using code
  USING (code)
-- Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
-- Order by ascending countries.name
ORDER BY countries.name; 

--- Full Join(3)

-- Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
      c2.basic_unit, c2.frac_unit
-- From countries (alias as c1)
FROM countries AS c1
-- Join with languages (alias as l)
FULL JOIN languages AS l
  -- Match on code
  USING (code)
-- Join with currencies (alias as c2)
FULL JOIN currencies AS c2
  -- Match on code
  USING (code)
-- Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';

--- A Table of Two Cities

-- Select fields
SELECT c.name AS city, l.name AS language
-- From cities (alias as c)
FROM cities AS c      
-- Join to languages (alias as l)
INNER JOIN languages AS l
  -- Match on country code
  ON c.country_code = l.code
-- Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';

--- Outer Challenge

-- Select fields
SELECT c.name AS country, c.region, p.life_expectancy AS life_exp
-- From countries (alias as c)
FROM countries AS c
  -- Join to populations (alias as p)
  LEFT JOIN populations AS p
    -- Match on country code
    ON c.code = p.country_code
-- Focus on 2010
WHERE year = 2010
-- Order by life_exp
ORDER BY life_exp
-- Limit to 5 records
LIMIT 5;

--- SET THEORY CLAUSES

--- Union

-- Select fields from 2010 table
SELECT *
-- From 2010 table
FROM economies2010
-- Set theory clause
UNION
-- Select fields from 2015 table
SELECT *
-- From 2015 table
FROM economies2015
-- Order by code and year
ORDER BY  code, year;


--- Union (2)

-- Select field
SELECT country_code
-- From cities
FROM cities 
-- Set theory clause
UNION
-- Select field
SELECT code
-- From currencies
FROM currencies
-- Order by country_code
ORDER BY country_code;

--- Union all

-- Select fields
SELECT code, year
-- From economies
FROM economies
-- Set theory clause
UNION ALL
-- Select fields
SELECT country_code, year
 -- From populations
 FROM populations
-- Order by code, year
ORDER BY code, year;

--- Intersect

-- Select fields
SELECT code, year
-- From economies
FROM economies
-- Set theory clause
INTERSECT
-- Select fields
SELECT country_code, year
 -- From populations
 FROM populations
-- Order by code and year
ORDER BY code, year;

--- Intersect (2)

-- Select fields
SELECT name
-- From countries
FROM countries
-- Set theory clause
INTERSECT
-- Select fields
SELECT name
-- From cities
FROM cities;
  
 --- Except

-- Select field
SELECT cities.name
-- From cities
FROM cities
-- Set theory clause
EXCEPT
-- Select field
SELECT countries.capital
-- From countries
FROM countries
-- Order by result
ORDER BY name;

--- Except (2)

-- Select field
SELECT countries.capital
-- From countries
FROM countries
-- Set theory clause
EXCEPT
-- Select field
SELECT cities.name
-- From cities
FROM cities
-- Order by ascending capital
ORDER BY capital;

--- Semi-join

-- Select code
SELECT code
-- From countries
FROM countries
-- Where region is Middle East
WHERE region = 'Middle East';

--- Diagnosing problems using anti-join

-- Select statement
SELECT COUNT(DISTINCT name)
-- From countries
FROM countries
-- Where continent is Oceania
WHERE continent = 'Oceania';

-- Select fields (with aliases)
SELECT c1.code, c1.name, c2.basic_unit AS currency 
-- From countries (alias as c1)
FROM countries AS c1
-- Join with currencies (alias as c2)
INNER JOIN currencies AS c2
-- Match on code
ON c1.code = c2.code
-- Where continent is Oceania
WHERE continent = 'Oceania';
