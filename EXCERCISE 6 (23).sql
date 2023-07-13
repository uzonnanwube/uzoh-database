-- Exercise 6.

/* Analyze the climate disaster.csv dataset using SQL and 
provide INSIGHTS and RECOMMENDATIONS based on your findings */.


CREATE TABLE climate_disaster (
  year INTEGER,
  disaster_group TEXT,
  disaster_type TEXT,
  disaster_subtype TEXT,
  iso TEXT,
  region TEXT,
  continent TEXT,
  origin TEXT,
  associated_disaster TEXT,
  ofda_response VARCHAR,
  disaster_magnitude_value VARCHAR,
  latitude VARCHAR,
  longitude VARCHAR,
  start_year VARCHAR,
  end_year VARCHAR,
  total_deaths INTEGER,
  no_injured INTEGER,
  no_affected INTEGER,
  no_homeless INTEGER,
  total_affected INTEGER,
  total_damages_1000_usd INTEGER,
  total_damages INTEGER,
  adjusted_1000_usd INTEGER,
  country TEXT,
  location TEXT
);




--Insight 1: 
/* Check the three most common disaster type in each country */

SELECT country, disaster_type, COUNT(*) AS count
FROM climate_disaster cd
GROUP BY country, disaster_type
HAVING COUNT(*) IN (
    SELECT COUNT(*)
    FROM climate_disaster
    WHERE country = cd.country
    GROUP BY disaster_type
    ORDER BY COUNT(*) DESC
    LIMIT 3
)
ORDER BY country, count DESC, disaster_type;

-- Recommendation: 
/*Prioritize investments in climate resilience and disaster preparedness measures,
such as early warning systems, infrastructure upgrades, and community outreach programs*/




--INSIGHT 2: 
/* WHICH OF THE DISASTER TYPES CAUSED MORE DEATHS ACCROSS ALL REGION? */

SELECT disaster_type, SUM(total_deaths) AS total_deaths
FROM climate_disaster
GROUP BY disaster_type
ORDER BY total_deaths DESC;

-- Recommendation: 
/*Focus on improving preparedness and response strategies for floods,
storms, droughts, and wildfires, such as investing in flood-resistant 
infrastructure and improving wildfire prevention and suppression techniques*/  



-- INSIGHT 3: 
/* Climate disasters disproportionately affect low-income regions, 
countries, which have fewer resources to respond and recover from them*/

SELECT region, country, SUM(total_deaths) AS total_deaths,
       SUM(no_injured) AS total_injured,
       SUM(no_affected) AS total_affected,
       SUM(no_homeless) AS total_homeless,
       CONCAT( '$', SUM (total_damages_000_USD)) AS total_damages_000_USD
FROM climate_disaster
GROUP BY region, country
ORDER BY total_deaths DESC;

-- Recommendation: 
/* Indonesia appears to be the most hit in terms of human casualties and impact. 
Countries in south eastern Asian appear to be more prone to diasaters Provide increased
support to low-income countries, such as investing in disaster risk reduction 
programs, increasing humanitarian aid, and improving access to climate finance*/



--- INSIGHT 4:
/* We can also breakdown the total human impacts into specific categories */

SELECT SUM(total_deaths) AS total_deaths,
       SUM(no_injured) AS total_injured,
       SUM(no_affected) AS total_affected,
       SUM(no_homeless) AS total_homeless,
       SUM(total_damages_000_usd) AS total_damages
FROM climate_disaster;

-- Recommendation: 
/*Increase investment in climate resilience and disaster preparedness measures in Asia, 
such as improving early warning systems, increasing community outreach programs, and 
investing in climate-resistant infrastructure*/   



-- INSIGHT 5: 
 /*The number of deaths and total damages caused by climate disasters 
are strongly correlated with the magnitude of the disaster*/

SELECT disaster_magnitude_value, 
SUM(total_deaths) AS total_deaths, 
SUM(total_damages) AS total_damages
FROM climate_disaster
WHERE disaster_magnitude_value IS NOT NULL
GROUP BY disaster_magnitude_value
ORDER BY disaster_magnitude_value;

-- RECOMMENDATION:
 /* Policies should be put in place to help check the impact of disasters
 to help prevent death */



-- INSIGHT 6:
/* Which disaster sub-types had the highest total damages?*/

SELECT disaster_subtype, SUM(total_damages) AS total_damages
FROM climate_disaster
WHERE total_damages IS NOT NULL
GROUP BY disaster_subtype
ORDER BY total_damages DESC

--RECOMMENDATION:
/* Early predictions should be made to help avoid the loses encountered
when such disasters occur with reference to Turkey */



-- INSIGHT 7:
/* What was the average number of people affected by each disaster type? */

SELECT disaster_type, CAST(AVG(total_affected) AS DECIMAL(10,0)) AS avg_total_affected 
FROM climate_disaster
WHERE total_affected IS NOT NULL
GROUP BY disaster_type 
ORDER BY avg_total_affected DESC;

-- RECOMMENDATION
/* Measures should be put in place to eliminate the number affected by 
each type of disaster*/



--INSIGHT 8: 
/* Observe the disaster response provided by the Office 
of Foreign Disaster Assistance (OFDA) in the dataset*/

SELECT OFDA_RESPONSE, COUNT(*) AS COUNT
FROM climate_disaster
WHERE ofda_response IS NOT NULL
GROUP BY OFDA_RESPONSE
ORDER BY COUNT DESC
;

--Recommendation
/*Disaster management organizations should prioritize measures 
to ensure that these response measures are properly funded and implemented*/



-- INSIGHT 9:
/* Which disaster sub-type caused the highest number of homeless people?*/

SELECT disaster_subtype, SUM(no_homeless) AS total_homeless
FROM climate_disaster
GROUP BY disaster_subtype
ORDER BY total_homeless DESC;

--RECOMMENDATION
/*Encourage Disaster Risk Reduction: Based on the analysis, it is evident that certain
disaster subtypes, such as earthquake, floods, drought and wildfare have caused the
highest casualties, injuries, and homelessness. Encouraging disaster risk reduction
measures for these specific disaster subtypes can help mitigate their impact*/



-- INSIGHT 10:
/* What is the total number of affected people in different location by year?*/

SELECT year, location, SUM(total_affected) AS total_affected
FROM climate_disaster
WHERE total_affected IS NOT NULL
GROUP BY year, location
ORDER BY total_affected ASC

--Recommendation
/* Address Climate Change: The analysis revealed that climate-related disasters 
such as floods and droughts are some of the most common types of disasters. 
It is important to address climate change to reduce the frequency and severity 
of these disasters. Countries must educates its citizens on impact of climate change
in our our environment*/



-- INSIGHT 11:
/* What continent is mostly affected by disaster over time and in what year? */

SELECT year, continent, COUNT(*) AS num_disasters
FROM climate_disaster
GROUP BY year, continent
ORDER BY num_disasters DESC
LIMIT 5;

--RECOMMENDATION
/* Improve Data Collection and Reporting: The quality and completeness of the data
available on disasters can vary widely. Improving data collection and reporting 
mechanisms can help in better understanding the impact of disasters and in developing
more effective disaster risk reduction strategies */



--INSIGHT 12: 
/* What is the overall human impact of the disaster over the years across all region? */

SELECT year,SUM(total_deaths + no_injured + no_affected + no_homeless) 
AS total_human_impact 
FROM climate_disaster 
GROUP BY year
HAVING SUM(total_deaths + no_injured + no_affected + no_homeless) IS NOT NULL
ORDER BY total_human_impact DESC;

-- RECOMMENDATION
/* Early warning signs should be given and authorities involved in disaster 
evacuation be well equipped to swing into action whenever the need arises*/



--INSIGHT 13: 
/* The total damages in monetary value by disaster type. 
this can provide insight into which types of disasters have the highest economic impact in usd. */ 

SELECT disaster_type, CONCAT('$', SUM(total_damages_000_usd)) AS Value_of_damages_in_usd
FROM climate_disaster
GROUP BY disaster_type
ORDER BY SUM(total_damages_000_usd) DESC;

-- RECOMMENDATION: 
/*Invest in early warning systems and disaster preparedness measures to 
mitigate the impact of large-scale climate disasters, such as hurricanes and 
typhoons, which can cause significant loss of life and economic damage */  



-- INSIGHT 14:
/* Consider the climate disasters increasing over time, 
with a notable spike in what year exactly? */

SELECT year, COUNT(*) AS num_disasters
FROM climate_disaster
GROUP BY year
ORDER BY num_disasters DESC
LIMIT 1;

--RECOMMENDATIO:  
/* Investigate the causes and factors contributing to the notable spike in climate 
disasters in that particular year.
Assess the impact of the spike on affected regions and populations.
Consider implementing or strengthening climate resilience and disaster preparedness 
measures to mitigate the effects of future spikes.
Analyze long-term climate data and trends to anticipate and plan for potential future 
spikes in climate disasters.
Collaborate with relevant stakeholders, such as environmental agencies and disaster 
management organizations, to develop strategies for mitigating and adapting to 
climate-related risks.*/


-- Insight 15: 
/* Observe the frequency of the disaster type in each country?*/

SELECT country, disaster_type, COUNT(*) AS count
FROM climate_disaster cd
GROUP BY country, disaster_type
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM climate_disaster
    WHERE country = cd. country
    GROUP BY disaster_type
)
ORDER BY country;

--RECOMMENDATION: Measures should be put in place to reduce the impact of these disasters
























