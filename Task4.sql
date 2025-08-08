-- Using Movies Dataset database
USE moviesdb;
-- Top 5 highest-rated movies
SELECT title, imdb_rating FROM movies ORDER BY imdb_rating DESC LIMIT 5;
-- Movies after 2015 with rating above 8
SELECT title, release_year, imdb_rating FROM movies WHERE release_year > 2015 AND imdb_rating > 8;
-- Top 5 highest-grossing movies 
SELECT m.title, f.revenue, f.unit, f.currency
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id
ORDER BY 
  CASE 
    WHEN f.unit = 'Billions' THEN f.revenue * 1000
    ELSE f.revenue
  END DESC
LIMIT 5;
-- Average revenue by industry
SELECT m.industry,
       AVG(CASE 
             WHEN f.unit = 'Billions' THEN f.revenue * 1000
             ELSE f.revenue
           END) AS avg_revenue_millions
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id
GROUP BY m.industry;
-- Number of movies per language
SELECT l.name AS language, COUNT(*) AS movie_count
FROM languages l
JOIN movies m ON l.language_id = m.language_id
GROUP BY l.name
ORDER BY movie_count DESC;
-- Create index on movie_id for performance
CREATE INDEX idx_movie_id ON financials(movie_id);
-- Number of actors per movie
SELECT m.title, COUNT(ma.actor_id) AS actor_count
FROM movies m
JOIN movie_actor ma ON m.movie_id = ma.movie_id
GROUP BY m.title
ORDER BY actor_count DESC;








