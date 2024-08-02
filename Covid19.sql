
Select *
From PortfoliopProject..CovidDeaths
where continent is not null
order by 3,4


-- Select the Data that we are going to be using:
Select location, date, total_cases, new_cases ,total_deaths, population
From PortfoliopProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at total Cases Vs Total Deaths:
-- Show likelihood of dying in Israel

DELETE FROM PortfoliopProject..CovidDeaths
WHERE total_cases = 0;

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DaethPercentage
From PortfoliopProject..CovidDeaths
where continent is not null
and location like '%israel%'
order by 1,2


-- Looking at Total Cases vs Population 
-- Show Israel's infection rate in relation to the world's population:

DELETE FROM PortfoliopProject..CovidDeaths
WHERE total_cases = 0;

Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From PortfoliopProject..CovidDeaths
where location like '%israel%' 
and continent is not null
order by 1,2

-- Highest infection rate compared to population in each country:
Select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfoliopProject..CovidDeaths
where continent is not null
Group by location, population
order by 4 desc

Select location, population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfoliopProject..CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc

--what is the maximum number of dead in each country?
Select location, population, Max(total_deaths) as HighestDeathsCount
From PortfoliopProject..CovidDeaths
where continent is not null
Group by location, population
order by 3 desc

--what is the Country with the highest death toll in the world?
Select TOP 1 location, population, Max(total_deaths) as HighestDeathsCount
From PortfoliopProject..CovidDeaths
where continent is not null
Group by location, population


-- What is the percentage of deaths out of the population for each country?
Select location, population, Max(total_deaths) as HighestDeathsCount, Max((total_deaths/population))*100 as PercentPopulationDeath
From PortfoliopProject..CovidDeaths
where continent is not null
Group by location, population
order by 4 desc


-- What is the Percentage of deaths out of the population for Israel?
Select location, population, Max(total_deaths) as HighestDeathsCount, Max((total_deaths/population))*100 as PercentPopulationDeath
From PortfoliopProject..CovidDeaths
where location like '%israel%'
and continent is not null 
Group by location, population
order by 4 desc


-- What is the highest death toll on each continent?
Select continent, Max(total_deaths) as HighestDeathsCount
From PortfoliopProject..CovidDeaths
where continent is not null
Group by continent
order by 1 desc

-- What is the number of deaths per continent?
Select location, SUM(new_deaths) as TotalDeathCount
From PortfoliopProject..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union (27)', 'International', 'High-income countries','Lower-middle-income countries', 'Upper-middle-income countries', 'Low-income countries')
Group by location
order by TotalDeathCount desc


-- GLOBAL NUMBERS

-- The number of new cases received each day
Select date, SUM(new_cases) as GlobalNewCases
From PortfoliopProject..CovidDeaths
where continent is not null
Group by date	
order by 1,2


-- The Death Percentage for each day
Select date, SUM(new_cases) as GlobalNewCases, SUM(new_deaths) as GlobalNewCases, (SUM(new_deaths) / SUM(new_cases))*100 as DeathPercentage 
From PortfoliopProject..CovidDeaths
where continent is not null and new_cases != 0
Group by date	
order by 1,2

-- The total number of cases that happened
Select SUM(new_cases) as GlobalNewCases, SUM(new_deaths) as GlobalNewCases, (SUM(new_deaths) / SUM(new_cases))*100 as DeathPercentage 
From PortfoliopProject..CovidDeaths
where continent is not null and new_cases != 0
-- Group by date	
order by 1,2



