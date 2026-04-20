-- link to results: https://docs.google.com/document/d/150h-UbO8rWAhBbSyH7VGeCBq_xHypbYNCAjVX0rvg4c/edit?usp=sharing
-- query for overview of movie data
SELECT movie_id, movie_name, release_date, income, production_cost
FROM movie;

-- query for genre of each movie
SELECT m.movie_name, g.genre_name
FROM movie m
JOIN belongs_to bt ON m.movie_ID = bt.movie_id
JOIN genre g ON bt.genre_id = g.genre_id;

-- show the stars(actors) and the movies they were in
SELECT s.star_name, m.movie_name
FROM stars s
JOIN acts_in a ON s.star_id = a.star_id
JOIN movie m ON a.movie_id = m.movie_ID;

-- show all movies and the language it was released in
SELECT m.movie_name, ml.languages
FROM movie m
JOIN movie_languages ml ON m.movie_ID = ml.movie_ID
ORDER BY m.movie_name;

-- movie and its production company
SELECT m.movie_name, pc.production_companies
FROM movie m
JOIN production_companies pc ON m.movie_ID = pc.movie_ID;

-- three table join showing movie, star and the production company
SELECT m.movie_name, s.star_name, pc.production_companies
FROM movie m
JOIN acts_in a ON m.movie_ID = a.movie_id
JOIN stars s ON a.star_id = s.star_id
JOIN production_companies pc ON m.movie_ID = pc.movie_ID;

-- list all names from both stars and industry persons combined (UNION)
SELECT star_name AS name FROM stars
UNION
SELECT names AS name FROM industry_person;

-- each movie and its average review score
SELECT m.movie_name, AVG(r.review_score) AS avg_score
FROM movie m
JOIN reviews r ON m.movie_ID = r.movie_ID
GROUP BY m.movie_name
ORDER BY avg_score DESC;

-- show people who are both directors and writers
SELECT ip.names FROM industry_person ip
WHERE ip.industry_person_id IN (SELECT industry_person_id FROM director)
INTERSECT
SELECT ip.names FROM industry_person ip
WHERE ip.industry_person_id IN (SELECT industry_person_id FROM writer);

-- count how many movies each person is credited on
SELECT ip.names, COUNT(hc.movie_id) AS total_credits
FROM industry_person ip
JOIN has_credit hc ON ip.industry_person_id = hc.industry_person_id
GROUP BY ip.names
ORDER BY total_credits DESC;
