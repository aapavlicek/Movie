-- The question I want to answer is if someone wants to make a movie which direction should they take to maximize sales
-- Most of data cleaning done in Excel since it's a smaller dataset

-- Average sales by License
select AVG(`World Sales (in $)`) as `World Sales (in $)`, `License`
from test.movies
group by 2;
	-- A PG13 movie would be the best chance to get the most sales

-- In the previous code the license with the highest average sales was PG-13 so I will isolate that 
select * 
from test.movies
where License like "PG-13" -- Only want PG13 
order by `World Sales (in $)` desc; -- Order by highest world sales
	-- Looking at the Distibutor column the Walt Disney Motion Pictures has 7 of the top 13 grossing movies, 
    -- and Universal Pictures has the second most at 4 of the top 13.

-- I want to specifically get outliers out by specifying movies 60 minutes or greater
select * 
from test.movies
where License like "PG-13" and `Runtime(minutes)` >= 60 and Distributor = "Walt Disney Studios Motion Pictures" -- Only want PG13 & Walt Disney while also taking out short films
order by `World Sales (in $)` desc -- Order by highest world sales
;
	-- What was discovered is that the genre of these movies appears to be Action, Adventure, and Sci-fi. 
    -- Also Looking at the Release Date is seems the highest selling movies are released in April and December. 
    
-- Focusing on the specific genre Action, Adventure, and Sci-fi. 
select * 
from test.movies
where License like "PG-13" and `Runtime(minutes)` >= 60 and Distributor = "Walt Disney Studios Motion Pictures" and Genre = '[''Action'', ''Adventure'', ''Sci-Fi'']'  -- Only want PG13 & Walt Disney while also taking out short films
order by `World Sales (in $)` desc -- Order by highest world sales
;
-- In the end it seems that if someone wants to make a movie and wants the highest chance of high sales they should make a PG13 movie.
-- The movie should be distributed by Walt Disney Studio Motion Pictures as an action, adventure, and sci-fi movie.  
-- The movie should release in April or December and should Have a runtime between 2 hours and 2 and a half hours.

-- I'm trying the same process for the 2nd highest distributor Universal Pictures
select * 
from test.movies
where License like "PG-13" and `Runtime(minutes)` >= 60 and Distributor = "Universal Pictures" and Genre = '[''Action'', ''Adventure'', ''Sci-Fi'']'  -- Only want PG13 & Walt Disney while also taking out short films
order by `World Sales (in $)` desc -- Order by highest world sales
;
	-- It seems that Universal Pictures also has a 2 hour runtime, but the difference is the release date is around June and May. 


-- Focusing on Total Sales
select 
Title,
Distributor,
Genre,
License, -- Rating
`Release Date`, 
`Domestic Sales (in $)`,
`International Sales (in $)`,
`World Sales (in $)`,
 (`Domestic Sales (in $)` / `World Sales (in $)`) as `Percent Domestic`,
 (`International Sales (in $)` / `World Sales (in $)`) as `Percent International`,
  `World Sales (in $)`/ `Runtime(minutes)`  as `Sales By Minute`, -- Sales by Length of movie
 `Runtime(minutes)`
from test.movies
order by 8 desc; -- World Sales Highest to Lowest

