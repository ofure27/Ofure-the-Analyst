
select *
from PortfolioProject..CovidDeaths
where continent is not null
ORDER BY 3,4


SELECT continent, location, date, population, total_cases, new_cases, total_deaths
from PortfolioProject..CovidDeaths
where continent is not null
ORDER BY 1,2

--CASE FATALITY RATE
--LOOKING AT TOTAL CASES VS TOTAL DEATHS 
SELECT
    Location,
    date,
    total_cases,
    total_deaths,
    CASE
        WHEN TRY_CAST(total_cases AS FLOAT) = 0 THEN NULL  -- Avoid division by zero
        ELSE TRY_CAST(total_deaths AS FLOAT) / TRY_CAST(total_cases AS FLOAT)*100
    END AS death_ratio
FROM
    PortfolioProject..CovidDeaths
WHERE
    location LIKE '%Nigeria%' -- OR location LIKE '%Ghana%'
ORDER BY
   death_ratio desc



--INCIDENCE RATE
--NEW CASES VS POPULATION
SELECT Location, 
	   population, 
	   date, 
	   new_cases, 
	   (new_cases/population)*100 as NewInfection
from PortfolioProject..CovidDeaths
WHERE
    location LIKE '%Nigeria%' --OR location LIKE '%Ghana%'
	ORDER BY NewInfection desc


 --LOOKING AT TOTAL CASES VS POPULATION
-- SHOWS WHAT PERCENTAGE OF POPLUATION GOT COVID
--SELECT
--    Location,
--    Date,
--    Population,
--    Total_Deaths,
--    Total_Cases,
--    (Total_Cases / Population) * 100 AS PopulationPercentage
--FROM
--    PortfolioProject..CovidDeaths
--WHERE
--    Location LIKE '%Nigeria%' -- OR location like '%Ghana%'
--ORDER BY
--    1, 2;
												-------(IGNORE BOTH BUT KEEP)

--SELECT
--    Location,
--    Date,
--    Population,
--    Total_Deaths,
--    Total_Cases,
--    (Total_Deaths / Population) * 100 AS DeathPercentage   
--FROM
--    PortfolioProject..CovidDeaths
--WHERE
--    Location LIKE '%Nigeria%'
--ORDER BY
--    1, 2;


	--LOOKING AT AFRICAN COUNTRIES WITH HIGHEST INFECTION RATE(CONFIRMED CASES) COMPARED TO POLULATION ***
--SELECT
--	continent,
--    Location,
--    Population,
--    MAX(Total_Cases) as HighestInfectionCount,
--    MAX((Total_Cases / Population))* 100 AS PopulationPercentage
--FROM
--    PortfolioProject..CovidDeaths
--WHERE
--	continent IS NOT NULL AND					---(SAME AS THE NEXT ONE)
--    continent LIKE '%Africa%' 
--GROUP BY continent, location, population
--ORDER BY
--    PopulationPercentage desc;


SELECT 
    Location, 
    Population, 
    MAX(CAST(ISNULL(NULLIF(Total_Cases, ''), '0') AS INT)) AS ConfirmedCases, 
    MAX((CAST(ISNULL(NULLIF(Total_Cases, ''), '0') AS FLOAT) * 100.0) / Population) AS PercentPopulationInfected
FROM 
    PortfolioProject..CovidDeaths          ----THIS IS ACCURATE (CONFIRMD CASES AS HIGH INFECTION RATE) 267,173
WHERE 
	--continent IS NOT NULL AND   
    Continent LIKE '%africa%'
    AND ISNUMERIC(Total_Cases) = 1
    AND ISNUMERIC(Population) = 1
GROUP BY 
    Location, 
    Population
ORDER BY 
    PercentPopulationInfected DESC


	--LOOKING COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION 

SELECT Location, MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is null
--where location like '%Nigeria%'
group by location
ORDER BY TotalDeathCount desc


SELECT location, population, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where continent is null  ----THIS IS ACURATE
where continent like '%Africa%'
group by location, population
ORDER BY TotalDeathCount desc


-- GLOBAL NUMBERS (AFRICA)

SELECT
    location,
	SUM(new_deaths) as new_deaths,
    SUM(new_cases) as total_cases,
    SUM(CAST(Total_deaths as INT)) as total_deaths,
    SUM(CAST(new_deaths as INT)) / SUM(new_cases) * 100 as DeathPercentage
FROM
    PortfolioProject..CovidDeaths
WHERE
    continent = 'Africa'
GROUP BY
    location
ORDER BY
    location, total_cases;


	-- LOOKING AT TOTAL POLULATION VS VACCINATIONS
select *
from PortfolioProject..CovidVaccinations vac
order by 3,4


select *
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
 on dea.location = vac.location
 and dea.date = vac.date
 order by 3,4


 select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'africa'
 --where dea.continent is not null
 order by 2, 3


 select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 , SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'africa'
 --where dea.continent is not null
 order by 2, 3


  select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 , SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as cumulative_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'africa'
 --where dea.continent is not null
 order by 2, 3


 --CTE

WITH PopVsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS bigint)) OVER (PARTITION BY dea.location order by dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
	JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location						--VACCINATION RATE(THIS IS ACCURATE)
    AND dea.date = vac.date
WHERE dea.continent is not null AND dea.location LIKE 'Nigeria'
	--ORDER BY 2,3
)

select *, (RollingPeopleVaccinated/population)*100 as PercentageRollingPeopleVaccinated
from PopVsVac



-- NUMBERS OF VACCINES RECEIVED IN EACH COUNTRY

SELECT 
    dea.continent, 
    dea.location, 
    dea.population, 
    SUM(CAST(vac.new_vaccinations AS INT)) AS SumNewVaccinations
FROM 
    PortfolioProject..CovidDeaths dea
JOIN 
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE 
    dea.continent LIKE '%africa%'
    AND dea.continent IS NOT NULL
GROUP BY 
    dea.continent, 
    dea.location, 
    dea.population
ORDER BY 
    SumNewVaccinations DESC;
