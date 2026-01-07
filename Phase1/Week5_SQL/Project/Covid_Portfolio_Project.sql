--/* 1. CLEANING DATES */
---- Convert text dates (24-02-2020) into SQL Date format
--UPDATE CovidDeaths SET date = TRY_CONVERT(DATE, date, 105);
--ALTER TABLE CovidDeaths ALTER COLUMN date DATE;

--UPDATE CovidVaccinations SET date = TRY_CONVERT(DATE, date, 105);
--ALTER TABLE CovidVaccinations ALTER COLUMN date DATE;


--/* 2. FIXING NUMBERS (Making math faster) */
---- Deaths Table
--ALTER TABLE CovidDeaths ALTER COLUMN population BIGINT;
--ALTER TABLE CovidDeaths ALTER COLUMN total_cases FLOAT;
--ALTER TABLE CovidDeaths ALTER COLUMN new_cases FLOAT;
--ALTER TABLE CovidDeaths ALTER COLUMN total_deaths FLOAT;

---- Vaccinations Table
--ALTER TABLE CovidVaccinations ALTER COLUMN total_tests FLOAT;
--ALTER TABLE CovidVaccinations ALTER COLUMN total_vaccinations FLOAT;
--ALTER TABLE CovidVaccinations ALTER COLUMN people_vaccinated FLOAT;


---- Refresh the 'Brain' of the database
--UPDATE STATISTICS CovidDeaths;
--UPDATE STATISTICS CovidVaccinations;

-- Run this once. It gives SQL a pre-sorted version of exactly what your CTE needs.
CREATE NONCLUSTERED INDEX idx_speed_boost 
ON CovidDeaths (location, date) 
INCLUDE (continent, population);

CREATE NONCLUSTERED INDEX idx_speed_boost_vac 
ON CovidVaccinations (location, date) 
INCLUDE (new_vaccinations);


--Select data which we are going to use

Select *
FROM PortfolioProject..CovidDeaths


SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths


--Looking at the Total Cases vs Total Death
--Shows the likelihood of dying if you got infected with COVID in India in 2021
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE Location LIKE '%India'


--Shows what percentage of population got infected by 2021 per country
SELECT Location, date, population, total_cases, (total_cases/population)*100 AS InfectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL


--Shows which country has the highest infection rate
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY PercentagePopulationInfected DESC


--Showing countries with the highest death count per population
SELECT Location, population, MAX(total_deaths) AS HighestDeathCount, MAX((total_deaths/population))*100 AS PercentagePopulationDied
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, population
ORDER BY PercentagePopulationDied DESC


--Let's break things down by continent
-- Showing the continent with the highest death count
SELECT continent, MAX(total_deaths) as HighestDeathCountCont
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY HighestDeathCountCont DESC



-- GLOBAL NUMBERS

SELECT  SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, SUM(new_deaths) / SUM(new_cases) * 100 AS GlobalPercentage
FROM PortfolioProject..CovidDeaths
--WHERE Location LIKE '%India'
WHERE continent IS NOT NULL
ORDER BY GlobalPercentage 



--Looking at Total Population and Vaccinations

--USE CTE

WITH PopvsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
AS (
SELECT da.continent, da.location, da.date, da.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY da.location ORDER BY da.location,
	da.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths da
JOIN PortfolioProject..CovidVaccinations vac
	ON da.location = vac.location
	AND da.date = vac.date
WHERE da.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated * 1.0/Population)*100
FROM PopvsVac


-- TEMP TABLE

DROP TABLE IF EXISTS #PercentagePopulationVaccinated
CREATE TABLE #PercentagePopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)



INSERT INTO #PercentagePopulationVaccinated
SELECT da.continent, da.location, da.date, da.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY da.location ORDER BY da.location,
	da.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths da
JOIN PortfolioProject..CovidVaccinations vac
	ON da.location = vac.location
	AND da.date = vac.date
WHERE da.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated * 1.0/Population)*100
FROM #PercentagePopulationVaccinated




-- CREATING VIEW TO STORE DATA FOR VISUALIZATIONS--


--1 PERCENTAGE POPULATION VACCINATED

CREATE VIEW PercentagePopulationVaccinated AS
SELECT da.continent, da.location, da.date, da.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY da.location ORDER BY da.location,
	da.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths da
JOIN PortfolioProject..CovidVaccinations vac
	ON da.location = vac.location
	AND da.date = vac.date
WHERE da.continent IS NOT NULL

--2 PERCENTAGE POPULATION INFECTED

CREATE VIEW PercentagePopulationInfected AS
SELECT Location, date, population, total_cases, (total_cases/population)*100 AS InfectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL


--3 COUNTRIES WITH HIGHEST INFECTION RATES

CREATE VIEW CountriesWithHighestInfectionRates AS
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, population
--ORDER BY PercentagePopulationInfected DESC



--4 HIGHEST DEATH COUNT BY POPULATION

CREATE VIEW HighestDeathCountPerPop AS
SELECT Location, population, MAX(total_deaths) AS HighestDeathCount, MAX((total_deaths/population))*100 AS PercentagePopulationDied
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, population
--ORDER BY PercentagePopulationDied DESC


--5 CONTINENT WISE DEATH COUNT

CREATE VIEW ContinentWiseDeathCount AS
SELECT continent, MAX(total_deaths) as HighestDeathCountCont
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent


--6 GLOBAL PERCENTAGE

CREATE VIEW GlobalPercentage AS
SELECT  SUM(new_cases) AS TotalCases, SUM(new_deaths) AS TotalDeaths, SUM(new_deaths) / SUM(new_cases) * 100 AS GlobalPercentage
FROM PortfolioProject..CovidDeaths
--WHERE Location LIKE '%India'
WHERE continent IS NOT NULL
--ORDER BY GlobalPercentage


