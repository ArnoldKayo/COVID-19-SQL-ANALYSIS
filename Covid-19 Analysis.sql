--Select the respective tables from the Project database
SELECT *
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT *
FROM Covid_Vaccination
WHERE continent IS NOT NULL
ORDER BY 3,4;

--Select data we are going to be using
SELECT Location, date, population, new_cases,total_deaths, total_cases
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

--Find relation between total total cases and total death
--** Must first convert data to integers to deal with null values
SELECT Location, date, total_cases, total_deaths, (NULLIF(CONVERT(float, total_deaths), 0) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

--Filter Covid cases in the states
SELECT Location, date, total_cases, total_deaths, (NULLIF(CONVERT(float, total_deaths),0) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
FROM Covid_Deaths
WHERE location like '%states%'
and continent IS NOT NULL
ORDER BY 1,2;

--Relation between total population and covid cases
--Shows what % population got Covid
SELECT Location, date, population,total_cases, (NULLIF(CONVERT(float, total_cases), 0) / NULLIF(CONVERT(float, population), 0))*100 as PercentageCases
FROM Covid_Deaths
WHERE location like '%states%'
and continent IS NOT NULL
ORDER BY 1,2;


--Show countries with the highest covid cases
SELECT Location, population, MAX(total_cases) AS HighestCases , MAX(NULLIF(CONVERT(float, total_cases),0) / NULLIF(CONVERT(float, population), 0))*100 as HighestPercentageCases
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location,Population
ORDER BY HighestPercentageCases DESC;

--Countries with highest death_count/population by location
--CAST helps in converting the Datatype to numerics--
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

--Highest death_count/population by continent
SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

--Global numbers
SELECT date, SUM(new_cases) AS NewCases, SUM(new_deaths) AS NewDeath, SUM(new_deaths)/NULLIF(SUM(new_cases),0) * 100 AS DeathPercentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

--JOIN THE TWO TABLES
SELECT *
FROM Covid_Deaths
JOIN Covid_Vaccination
  ON Covid_Deaths.location = Covid_Vaccination.location
  AND Covid_Deaths.date = Covid_Vaccination.date;

--FINDING VACCINATED POPULATION
SELECT Covid_Deaths.continent, Covid_Deaths.location,Covid_Deaths.date,Covid_Deaths.population,Covid_Vaccination.new_vaccinations
FROM Covid_Deaths
JOIN Covid_Vaccination
  ON Covid_Deaths.location = Covid_Vaccination.location
  AND Covid_Deaths.date = Covid_Vaccination.date
WHERE Covid_Deaths.continent IS NOT NULL
ORDER BY 1,2,3;



