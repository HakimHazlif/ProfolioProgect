
SELECT *
  FROM [ProfolioProject].[dbo].[CovidDeath]
  order by 3,4

--SELECT *
--  FROM [ProfolioProject].[dbo].[CovidVaccinated]
--  order by 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
  FROM [ProfolioProject].[dbo].[CovidDeath]
  order by 1,2

  ALTER TABLE [ProfolioProject].dbo.CovidDeath
  ALTER COLUMN total_cases int


SELECT location, date, total_cases, total_deaths, (cast(total_deaths as decimal)/total_cases)*100 AS deathPercentage
  FROM [ProfolioProject].dbo.CovidDeath
  order by 1,2


SELECT location, date, total_cases, total_deaths, (cast(total_deaths as decimal)/total_cases)*100 AS deathPercentage
  FROM [ProfolioProject].dbo.CovidDeath
  where location = 'Morocco'
  order by 1,2


SELECT location, date, population, total_cases, (cast(total_cases as decimal)/population)*100 AS PercentPopulationInfect
  FROM [ProfolioProject].dbo.CovidDeath
  where location LIKE 'Chin%'
  order by 1,2


 SELECT location, population, MAX(total_cases) AS heightInfectionCount, Max(cast(total_cases as decimal)/population)*100 AS 
 PercentPopulationInfect
  FROM [ProfolioProject].dbo.CovidDeath
  group by location, population
  order by PercentPopulationInfect desc


 SELECT location, population, MAX(total_deaths) AS heightDeathsCount, Max(cast(total_deaths as decimal)/population)*100 AS 
 PercentPopulationDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  group by location, population
  order by PercentPopulationDeaths desc


 SELECT location, population, MAX(total_deaths) AS heightDeathsCount, Max(cast(total_deaths as decimal)/population)*100 AS 
 PercentPopulationDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  group by location, population
  order by PercentPopulationDeaths desc


 SELECT location, MAX(total_cases) AS heightInfectionCount, MAX(total_deaths) AS heightDeathsCount,
 (MAX(cast(total_deaths as decimal))/MAX(total_cases))*100 AS 
 PercentCasesDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  WHERE location IN ('Morocco', 'United States', 'Italy', 'France')
  group by location
  order by PercentCasesDeaths desc


 SELECT location, population, Max(total_cases) AS TotalCases, Max(total_deaths) AS TotalDeaths,
   Max(cast(total_cases as decimal)/population)*100 AS PercentPopulationInfect,
   Max(cast(total_deaths as decimal)/population)*100 AS PercentPopulationDeath,
  (MAX(cast(total_deaths as decimal))/MAX(total_cases))*100 AS PercentCasesDeaths
 FROM [ProfolioProject].dbo.CovidDeath
  group by location, population
  order by PercentPopulationInfect desc


  SELECT location, Max(total_deaths) AS TotalDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  where total_deaths is not null AND continent is not null
  group by location
  order by TotalDeaths desc


  SELECT continent, Max(total_deaths) AS TotalDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  where continent is Not null
  group by continent
  order by TotalDeaths desc


  SELECT location, Max(total_deaths) AS TotalDeaths
  FROM [ProfolioProject].dbo.CovidDeath
  where continent is null
  group by location
  order by TotalDeaths desc


  SELECT location, population, Max(total_deaths) AS TotalDeaths,
  Max(cast(total_deaths as decimal)/population)*100 AS PercentPopulationDeath
  FROM [ProfolioProject].dbo.CovidDeath
  where continent is null
  group by location, population
  order by PercentPopulationDeath desc
  

  Select date, Sum(new_cases)
  FROM [ProfolioProject].dbo.CovidDeath
  where continent is not null
  group by date
  order by 1,2
  -- Ì⁄ÿÌ‰« Â–« „Ã„Ê⁄ «·Õ«·«  «·ÃœÌœ… ›Ì «·⁄«·„ ﬂ· ÌÊ„° √Ì ÌÃ„⁄ «·Õ«·«  «·ÃœÌœ… „‰ ﬂ· »·œ ›Ì ÌÊ„ „⁄Ì‰

  
  Select date, Sum(new_cases), sum(new_deaths)
  FROM [ProfolioProject].dbo.CovidDeath
  where continent is not null
  group by date
  order by 1,2

  ALTER TABLE [ProfolioProject].dbo.CovidDeath
  ALTER COLUMN new_cases DECIMAL


  ALTER TABLE [ProfolioProject].dbo.CovidDeath
  ALTER COLUMN new_deaths DECIMAL


  Select date, Sum(new_cases), sum(new_deaths), SUM(new_deaths)/SUM(new_cases)*100 AS AAAA
  FROM [ProfolioProject].dbo.CovidDeath
  where new_cases > 0
  group by date
  order by 1,2

  Select Sum(new_cases) TotalCases, sum(new_deaths) AS NewDeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
  FROM [ProfolioProject].dbo.CovidDeath
  order by 1,2


 SELECT *
   FROM [ProfolioProject].[dbo].[CovidVaccinated]
   where location like ('Mor%')
   order by 3,4
  

   SELECT date, total_vaccinations
   FROM [ProfolioProject].[dbo].[CovidVaccinated]
   where location like ('Mor%')
   order by 1,2


SELECT *
  FROM [ProfolioProject].[dbo].[CovidDeath]
  order by 3,4

SELECT *
   FROM [ProfolioProject].[dbo].[CovidVaccinated]
   order by 3,4

 SELECT *
   FROM [ProfolioProject].[dbo].[CovidVaccinated]
   where location like ('Mor%')
   order by 3,4
  

   SELECT date, total_vaccinations
   FROM [ProfolioProject].[dbo].[CovidVaccinated]
   where location like ('Mor%')
   order by 1,2


   Select *
   from [ProfolioProject].[dbo].[CovidDeath]
   join [ProfolioProject].[dbo].[CovidVaccinated]
     on [CovidDeath].location = [CovidVaccinated].location
	 and [CovidDeath].date = [CovidVaccinated].date
	 order by 1,2

	 ALTER TABLE [ProfolioProject].dbo.CovidVaccinated
     ALTER COLUMN new_vaccinations decimal


 Select [CovidVaccinated].location, population, Max(people_vaccinated) AS TotalVaccinated, 
   (Max(people_vaccinated)/population)*100 As vaccinationsPercentage
   from [ProfolioProject].[dbo].[CovidDeath]
   join [ProfolioProject].[dbo].[CovidVaccinated]
     on [CovidDeath].location = [CovidVaccinated].location
	 and [CovidDeath].date = [CovidVaccinated].date
	 where [CovidVaccinated].location in ('Morocco', 'United States', 'Italy', 'France', 'Russia')
	 group by [CovidVaccinated].location, population
	 order by vaccinationsPercentage desc


Select [CovidVaccinated].location, [CovidVaccinated].date, population, new_vaccinations, 
   SUM(new_vaccinations) over (Partition by [CovidVaccinated].location Order by [CovidVaccinated].date) as totalVaccinated
   -- «· ﬁ”Ì„ Â‰« √ Ï »‰«¡ ⁄·Ï «·»·œ » — Ì» “„‰Ì Õ Ï Ì „ﬂ‰ „‰ ≈⁄«œ… Õ”«» «··ﬁ«Õ«  «·ÃœÌœ… „‰ «·»œ«Ì… Õ”» ﬂ· »·œ 
   from [ProfolioProject].[dbo].[CovidDeath]
   join [ProfolioProject].[dbo].[CovidVaccinated]
     on [CovidDeath].location = [CovidVaccinated].location
	 and [CovidDeath].date = [CovidVaccinated].date
	where [CovidVaccinated].location in ('Morocco', 'United States', 'Italy', 'France', 'Russia')
	 order by [CovidVaccinated].location

with PopvsVac (location, date, population, new_vaccinations, totalVaccinated)
as 
(
Select [CovidVaccinated].location, [CovidVaccinated].date, population, new_vaccinations, 
   SUM(new_vaccinations) over (Partition by [CovidVaccinated].location Order by [CovidVaccinated].date) as totalVaccinated
   from [ProfolioProject].[dbo].[CovidDeath]
   join [ProfolioProject].[dbo].[CovidVaccinated]
     on [CovidDeath].location = [CovidVaccinated].location
	 and [CovidDeath].date = [CovidVaccinated].date
	where [CovidVaccinated].location in ('Morocco', 'United States', 'Italy', 'France', 'Russia')
	-- order by [CovidVaccinated].location
	 )
select *, (totalVaccinated/population)*100 AS VaccinatedPercontage
  from PopvsVac


  DROP TABLE IF EXISTS #PopvsVac
  create table #PopvsVac
  (location nvarchar(255),
  date datetime,
  population numeric,
  new_vaccinations numeric,
  totalVaccinated numeric)

  insert into #PopvsVac
  Select [CovidVaccinated].location, [CovidVaccinated].date, population, new_vaccinations, 
   SUM(new_vaccinations) over (Partition by [CovidVaccinated].location Order by [CovidVaccinated].date) as totalVaccinated
   from [ProfolioProject].[dbo].[CovidDeath]
   join [ProfolioProject].[dbo].[CovidVaccinated]
     on [CovidDeath].location = [CovidVaccinated].location
	 and [CovidDeath].date = [CovidVaccinated].date
	where [CovidVaccinated].location in ('Morocco', 'United States', 'Italy', 'France', 'Russia')
	-- order by [CovidVaccinated].location

select *, (totalVaccinated/population)*100 AS VaccinatedPercontage
  from #PopvsVac


   