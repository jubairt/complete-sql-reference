use moviesdb;

-- Usage of where
SELECT count(*) FROM movies where industry = 'bollywood';
select distinct industry from movies;
select * from movies where title like "%thor%";
select * from movies where studio = "";
select * from movies where imdb_rating >= 6 and imdb_rating <= 8;
select * from movies where imdb_rating between 6 and 8;
select * from movies where release_year = 2022 or release_year = 2019;
select * from movies where release_year in (2022,2019);

-- Usage of Null
select * from movies where imdb_rating is not Null;

-- Orderby
select * from movies where industry = "bollywood" order by imdb_rating desc limit 5 offset 1;

-- Arithematic calculations
select 
min(imdb_rating) as min_rating,
max(imdb_rating) as max_rating,
round(avg(imdb_rating),2) as avg_rating
 from movies where studio = "Marvel Studios";

 -- Different count at the same time
 select industry, count(*) from movies group by industry;
 select studio, count(*) as cnt from movies group by studio order by cnt desc;
 select industry, round(avg(imdb_rating),2) as avg_rating from movies group by industry;
 
 select 
 studio, round(avg(imdb_rating),2) as avg_rating 
 from movies
 group by studio 
 order by avg_rating desc;
 
 -- Executing order of query : from --> where --> group by --> having --> order by
 -- Having is mainly used in case of group by operations but it can be used without group by too
 -- if we are using the having with a column, that column must be selected in the query
 select release_year, count(*) as count_of_movies 
 from movies
 group by release_year
 having count_of_movies > 2;
 
 -- Calculating the age
 select *,year(curdate()) - birth_year as age from actors;
 
 -- Operations in financials table
 select * from financials;
 select *, (revenue - budget) as profit from financials;
 -- assuming that usd to inr conversion is usd * 77
 select *, 
 if(currency = "USD", revenue * 77, revenue)
 as revenue_inr from financials;
 
 select distinct unit from financials;
 
 -- USING CASE STATEMENTS
 -- converting into millions
 -- if billions --> rev * 100
 -- if thousands --> rev/1000
 -- if millions --> rev
 select *,
	case
		when unit = "thousands" then revenue/1000
        when unit = "billions" then revenue * 1000
        when unit = "millions" then revenue
	end
		as revenue_mln
from financials;