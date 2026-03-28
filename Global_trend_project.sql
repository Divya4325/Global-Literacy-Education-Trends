#Literacy_rates Sql Queries
#1)Get top 5 countries with highest adult literacy in 2020
SELECT country,Total_literacy_population FROM literacy_rates
WHERE year =2020
ORDER BY Total_literacy_population DESC
LIMIT 5;
#2)Find countries where female youth literacy < 80%
SELECT country, max(female_literacy) AS female_literacy
FROM literacy_rates
WHERE female_literacy <80
GROUP BY country;
#3)Average adult literacy per continent (owid region)
SELECT continent,AVG((male_literacy+female_literacy)/2) AS avg_adult_literacy
FROM literacy_rates
GROUP BY continent;
#Illiteracy_rates Sql Queries
#1)Countries with illiteracy % > 20% in 2000
SELECT country, illiteracy_percent FROM illiteracy_rates
WHERE illiteracy_percent >20
AND year=2020;
#2)Trend of illiteracy % for India (2000–2020)
SELECT year,illiteracy_percent FROM illiteracy_rates
WHERE country= 'india'
AND year BETWEEN 2000 AND 2020
ORDER BY year ASC;
#3)Top 10 countries with largest illiterate population in the last year
SELECT country,illiteracy_rate FROM illiteracy_rates
WHERE year=(SELECT MAX(year) AS latest_year FROM illiteracy_rates)
ORDER BY illiteracy_percent DESC
LIMIT 10;
# gdp_per_schooling_rates in Sql Queries
#1)Find countries with avg_years_schooling > 7 and gdp_per_capita < 5000
SELECT DISTINCT country,avg_years_schooling,gdp_per_capita FROM gdp_per_schooling_rates
WHERE avg_years_schooling >7 AND gdp_per_capita <5000
ORDER BY avg_years_schooling DESC;
#2) Rank countries by GDP per schooling for the year 2020
SELECT country, (gdp_per_capita/avg_years_schooling) AS gdp_per_schooling
FROM gdp_per_schooling_rates
WHERE year=2020
ORDER BY gdp_per_schooling DESC;
#3) Find global average schooling years per year
SELECT year,AVG(avg_years_schooling) AS global_avg_schooling
FROM gdp_per_schooling_rates
GROUP BY year
ORDER BY year ASC;
#Join Queries
#1) List top 10 countries in 2020 with highest GDP per capita but lowest average years of schooling(less than 6)
	SELECT country,gdp_per_capita,avg_years_schooling FROM gdp_per_schooling_rates
	WHERE year =2020 AND avg_years_schooling <6
	ORDER BY gdp_per_capita DESC
	LIMIT 10;
#2)Show countries where the illiterate population is high despite having more than 10 average years of schooling
SELECT g.country,g.avg_years_schooling,i.illiteracy_percent FROM gdp_per_schooling_rates g
JOIN illiteracy_rates i
ON g.country= i.country AND g.year=i.year
WHERE g.avg_years_schooling >10 AND i.illiteracy_percent >10
ORDER BY i.illiteracy_percent DESC;
#3) Compare literacy rates and GDP per capita growth for a selected country over the last 20 years (Let's Take India)
SELECT g.year,i.literacy_rate,g.gdp_per_capita FROM gdp_per_schooling_rates g
JOIN illiteracy_rates i
ON g.country= i.country AND g.year=i.year
WHERE g.country ='india'
AND g.year BETWEEN 2003 AND 2023
ORDER BY g.year DESC;
#4)Show the difference between youth literacy male and female rates for countries with GDP per capita above $30,000 in 2020
SELECT g.country,i.literacy_gender_gap FROM gdp_per_schooling_rates g
JOIN literacy_rates i
ON g.country= i.country AND g.year=i.year
WHERE g.gdp_per_capita >30000
AND g.year=2020
ORDER BY i.literacy_gender_gap DESC;
