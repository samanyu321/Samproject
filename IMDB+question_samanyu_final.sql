USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/

-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
SELECT COUNT(*) 
	FROM director_mapping;

SELECT COUNT(*) 
	FROM genre;

SELECT COUNT(*) 
	FROM movie;

SELECT COUNT(*) 
	FROM names;

SELECT COUNT(*) 
	FROM ratings;

SELECT COUNT(*) 
	FROM role_mapping;


-- Q2. Which columns in the movie table have null values?
-- Type your code below:
SELECT COUNT(*) 
	FROM movie
		WHERE title IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE year IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE date_published IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE duration IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE country IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE worlwide_gross_income IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE languages IS NULL;

SELECT COUNT(*) 
	FROM movie
		WHERE production_company IS NULL;


-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+

Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT year as Year,
		COUNT(id) as number_of_movies
			FROM movie
				GROUP BY year
					ORDER BY year;

SELECT MONTH(date_published) as month_num, 
		COUNT(id) as number_of_movies
			FROM movie
				GROUP BY MONTH(date_published)
					ORDER BY MONTH(date_published);
    


/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for
the last year.*/

  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT 
    COUNT(*) AS number_of_movies
FROM
    movie
WHERE year=2019 AND (LOWER(country) LIKE '%usa%' OR LOWER(country) LIKE '%india%');


/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
SELECT  DISTINCT genre
	FROM genre
		GROUP BY genre
			ORDER BY genre;


/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT genre, count(movie_id) as No_of_movies
	FROM genre as gnre
		GROUP BY genre 
			ORDER BY NO_of_movies DESC
				LIMIT 1;


/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH genre_cnt AS
(
SELECT movie_id,COUNT(genre)
	FROM genre
		GROUP BY movie_id
			HAVING COUNT(genre)=1
) 
SELECT COUNT(*) AS only_one_genre
	FROM genre_cnt; 


/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)

/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT gnre.genre, 
	AVG(mov.duration) as avg_duration
		FROM movie AS mov
			INNER JOIN genre AS gnre
				ON mov.id=gnre.movie_id
					GROUP BY gnre.genre
						ORDER BY avg_duration DESC;


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)

/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH gre_summary AS
(
SELECT gnre.genre, 
	COUNT(mov.id) AS movie_count,
		RANK() OVER(ORDER BY COUNT(mov.id) DESC) as genre_rank
			FROM movie as mov
				INNER JOIN genre as gnre
					ON mov.id=gnre.movie_id
						GROUP BY genre
)
SELECT *
	FROM gre_summary
		WHERE LOWER(genre)='Thriller';

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/

-- Segment 2:

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

SELECT 
	MIN(avg_rating) AS min_avg_rating, MAX(avg_rating) AS max_avg_rating,
		MIN(total_votes) AS min_total_votes, MAX(total_votes) AS max_total_votes,
			MIN(median_rating) AS min_median_rating, MAX(median_rating) AS max_median_rating
				FROM ratings;

 

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
SELECT 
	mov.title AS title, rte.avg_rating AS avg_rating,
	 RANK() OVER (ORDER BY rte.avg_rating DESC) AS movie_rank,
			DENSE_RANK() OVER(ORDER BY rte.avg_rating DESC) AS dense_movie_rank
				FROM movie AS mov
					INNER JOIN ratings AS rte
						ON rte.movie_id=mov.id
							GROUP BY mov.title
								LIMIT 10;


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating, COUNT(movie_id) AS movie_count
	FROM ratings
		GROUP BY median_rating
			ORDER BY COUNT(movie_id) DESC;

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

WITH top_prod AS
(
SELECT mov.production_company,
		COUNT(mov.id) AS movie_count,
        RANK() OVER (ORDER BY COUNT(mov.id) DESC) AS prod_company_rank
FROM
	movie AS mov
		LEFT JOIN
	ratings AS rte
		ON mov.id=rte.movie_id
WHERE avg_rating>8 AND mov.production_company IS NOT NULL
GROUP BY mov.production_company
)
SELECT *
	FROM top_prod
		WHERE prod_company_rank=1;

-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT gre.genre AS genre, 
	COUNT(gre.movie_id) AS movie_count
		FROM movie AS mov
			INNER JOIN genre AS gre 
				ON gre.movie_id=mov.id
					INNER JOIN ratings AS rte
						ON rte.movie_id=mov.id
							WHERE mov.year=2017 
							AND LOWER(mov.country) LIKE '%usa%' 
                            AND MONTH(mov.date_published)=3 
							AND rte.total_votes>1000
GROUP BY gre.genre
	ORDER BY movie_count DESC;

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT mov.title, 
		rte.avg_rating AS avg_rating,
        gre.genre AS genre
			FROM movie AS mov
				INNER JOIN ratings AS rte
					ON mov.id=rte.movie_id
						INNER JOIN genre AS gre
							ON mov.id=gre.movie_id
								WHERE title regexp '^The' 
									AND rte.avg_rating >8
										ORDER BY gre.genre,rte.avg_rating DESC;


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT COUNT(mov.id) AS movie_count
	FROM movie AS mov
		INNER JOIN ratings AS rte
			ON mov.id=rte.movie_id
				WHERE median_rating =8 
					AND mov.date_published BETWEEN '2018/04/01' AND '2019/04/01';
			
-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

WITH votes_summary AS
(
SELECT 
	COUNT(CASE WHEN LOWER(mov.languages) LIKE '%german%' THEN mov.id END) AS german_movie_count,
	COUNT(CASE WHEN LOWER(mov.languages) LIKE '%italian%' THEN mov.id END) AS italian_movie_count,
	SUM(CASE WHEN LOWER(mov.languages) LIKE '%german%' THEN rte.total_votes END) AS german_movie_votes,
	SUM(CASE WHEN LOWER(mov.languages) LIKE '%italian%' THEN rte.total_votes END) AS italian_movie_votes
FROM movie AS mov
	INNER JOIN  ratings AS rte
		ON mov.id = rte.movie_id
)
SELECT 
    ROUND(german_movie_votes / german_movie_count, 2) AS german_votes_per_movie,
    ROUND(italian_movie_votes / italian_movie_count, 2) AS italian_votes_per_movie
FROM
    votes_summary;

-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/


-- Segment 3:


-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT 
	COUNT(CASE WHEN name IS NULL THEN id END) AS name_nulls,
    COUNT(CASE WHEN height IS NULL THEN id END) AS height_nulls,
    COUNT(CASE WHEN date_of_birth IS NULL THEN id END) AS date_of_birth_nulls,
    COUNT(CASE WHEN known_for_movies IS NULL THEN id END) AS known_for_movies_nulls
FROM names;

/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_genre AS
(
SELECT gre.genre,
	COUNT(mov.id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(mov.id) DESC) AS genre_rank
FROM 
	genre AS gre
		LEFT JOIN
			movie AS mov
             ON gre.movie_id=mov.id
				INNER JOIN ratings AS rte
					ON rte.movie_id=mov.id
WHERE
	rte.avg_rating >8
		GROUP BY genre
)
SELECT nm.name AS director_name,
	COUNT(nm.id) AS movie_count
FROM names as nm
	INNER JOIN director_mapping AS dmap
		ON dmap.name_id=nm.id
			INNER JOIN movie AS mov
				ON mov.id=dmap.movie_id
					INNER JOIN ratings AS rte
						ON rte.movie_id=mov.id
							INNER JOIN genre AS gre
								ON gre.movie_id=mov.id
WHERE gre.genre IN (SELECT DISTINCT genre FROM top_genre WHERE genre_rank <=3) AND avg_rating >8
	GROUP BY name
		ORDER BY movie_count DESC
			LIMIT 3;
	

/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT nm.name AS actor_name,
	COUNT(mov.id) AS movie_count
		FROM names AS nm
			INNER JOIN role_mapping AS rol_map
				ON nm.id=rol_map.name_id
					INNER JOIN movie AS mov
						ON mov.id=rol_map.movie_id
							INNER JOIN ratings AS rte
								ON rte.movie_id=mov.id
WHERE rte.median_rating >=8 AND rol_map.category='actor'
	GROUP BY actor_name
		ORDER BY movie_count DESC
			LIMIT 2;


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
WITH top_prod AS
(
SELECT 
    mov.production_company,
    SUM(rte.total_votes) AS vote_count,
    ROW_NUMBER() OVER (ORDER BY SUM(rte.total_votes) DESC) AS prod_company_rank
FROM
    movie AS mov
        LEFT JOIN
    ratings AS rte
		ON mov.id = rte.movie_id
WHERE mov.production_company IS NOT NULL
GROUP BY mov.production_company
)
SELECT *
	FROM top_prod
		WHERE prod_company_rank <= 3;



/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number 
-- of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actor_ratings AS
(
SELECT 
	nm.name AS actor_name, SUM(rte.total_votes) AS total_votes,
    COUNT(nm.id) AS movie_count,
    ROUND(SUM(rte.avg_rating*rte.total_votes)/SUM(rte.total_votes),2) AS actor_avg_rating
FROM names as nm
	INNER JOIN role_mapping as rol_map
		ON rol_map.name_id=nm.id
			INNER JOIN movie AS mov
		ON mov.id=rol_map.movie_id
			INNER JOIN ratings AS rte
		ON rte.movie_id= mov.id
WHERE category='actor' AND LOWER(country) like '%India%'
	GROUP BY actor_name
)
SELECT *,
	RANK() OVER (ORDER BY actor_avg_rating DESC, total_votes DESC) AS actor_rank
FROM
	actor_ratings
WHERE movie_count>=5;

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actress_ratings AS
(
SELECT 
	nm.name AS actress_name, SUM(rte.total_votes) AS total_votes,
    COUNT(nm.id) AS movie_count,
    ROUND(SUM(rte.avg_rating*rte.total_votes)/SUM(rte.total_votes),2) AS actress_avg_rating
FROM names as nm
	INNER JOIN role_mapping as rol_map
		ON rol_map.name_id=nm.id
			INNER JOIN movie AS mov
		ON mov.id=rol_map.movie_id
			INNER JOIN ratings AS rte
		ON rte.movie_id= mov.id
WHERE category='actress' AND LOWER(languages) like '%Hindi%'
	GROUP BY actress_name
)
SELECT *,
	RANK() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
WHERE movie_count>=3
LIMIT 5;

/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT mov.title AS movie_name,
	CASE
		WHEN avg_rating>8 THEN "Superhit movies"
        WHEN avg_rating BETWEEN 7 AND 8 THEN "Hit movies"
        WHEN avg_rating BETWEEN 5 AND 7 THEN "One-time-watch movies"
        ELSE "Flop movies"
	END AS movie_category
FROM 
	movie AS mov
		LEFT JOIN ratings AS rte ON mov.id=rte.movie_id
        LEFT JOIN genre AS gre ON mov.id=gre.movie_id
WHERE
	LOWER(gre.genre)='thriller';
			
/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

WITH genre_summary AS
(
SELECT genre,
	ROUND(AVG(duration),2) AS avg_duration
FROM genre AS gre
	LEFT JOIN movie AS mov
		ON mov.id=gre.movie_id
			GROUP BY gre.genre
)
SELECT *,
	SUM(avg_duration) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_total_duration,
	AVG(avg_duration) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS moving_avg_duration
FROM genre_summary;
	

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH top_genres AS
(
SELECT
	genre,COUNT(mov.id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(mov.id) DESC) AS genre_rank
FROM
	genre AS gre
		LEFT JOIN movie AS mov
			ON gre.movie_id=mov.id
GROUP BY genre
)
,
top_grossing AS
(
SELECT gre.genre AS genre, mov.year AS year, mov.title AS movie_name,worlwide_gross_income,
	RANK() OVER (PARTITION BY gre.genre,mov.year 
		ORDER BY CONVERT(REPLACE(TRIM(worlwide_gross_income),"$ ",""),UNSIGNED INT) DESC) AS movie_rank
FROM movie AS mov
INNER JOIN genre AS gre
ON mov.id=gre.movie_id
WHERE gre.genre IN (SELECT DISTINCT genre FROM top_genres WHERE genre_rank<=3)
)
SELECT *
	FROM top_grossing
		WHERE movie_rank<=5;

-- Top 3 Genres based on most number of movies

-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits 
-- among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) 
-- among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

WITH top_prod AS
(
SELECT 
    mov.production_company,
    COUNT(mov.id) AS movie_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(mov.id) DESC) AS prod_company_rank
FROM
    movie AS mov
        LEFT JOIN
    ratings AS rte
		ON mov.id = rte.movie_id
WHERE median_rating>=8 AND mov.production_company IS NOT NULL AND POSITION(',' IN languages)>0
GROUP BY mov.production_company
)
SELECT 
    *
FROM
    top_prod
WHERE
    prod_company_rank <= 2;


-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actress_ratings AS
(
SELECT 
	nm.name as actress_name,
    SUM(rte.total_votes) AS total_votes,
    COUNT(mov.id) as movie_count,
	ROUND(SUM(rte.avg_rating*rte.total_votes)/SUM(rte.total_votes),2) AS actress_avg_rating
FROM
	names AS nm
		INNER JOIN role_mapping AS rmap
			ON nm.id=rmap.name_id
				INNER JOIN movie AS mov
					ON rmap.movie_id = mov.id
						INNER JOIN ratings AS rte
							ON mov.id=rte.movie_id
								INNER JOIN genre AS gre
									ON mov.id=gre.movie_id
WHERE category = 'actress' AND lower(gre.genre) ='drama'
GROUP BY actress_name
)
SELECT *,
	ROW_NUMBER() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
LIMIT 3;

/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

WITH top_directors AS
(
SELECT nm.id as director_id,
    nm.name as director_name,
	COUNT(mov.id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(mov.id) DESC) as director_rank
FROM names AS nm
	INNER JOIN director_mapping AS dmap
		ON nm.id=dmap.name_id
			INNER JOIN movie AS mov
				ON dmap.movie_id = mov.id
					GROUP BY nm.id
),
movie_summary AS
(
SELECT
	nm.id as director_id,
    nm.name as director_name,
    mov.id AS movie_id,
    mov.date_published,
	rte.avg_rating,
    rte.total_votes,
    mov.duration,
    LEAD(date_published) OVER (PARTITION BY nm.id ORDER BY mov.date_published) AS next_date_published,
    DATEDIFF(LEAD(date_published) OVER (PARTITION BY nm.id ORDER BY mov.date_published),date_published) AS inter_movie_days
FROM names AS nm
	INNER JOIN director_mapping AS dmap
		ON nm.id=dmap.name_id
			INNER JOIN movie AS mov
				ON dmap.movie_id = mov.id
					INNER JOIN ratings AS rte
						ON mov.id=rte.movie_id
WHERE nm.id IN (SELECT director_id FROM top_directors WHERE director_rank<=9)
)
SELECT 
	director_id,
	director_name,
	COUNT(DISTINCT movie_id) as number_of_movies,
	ROUND(AVG(inter_movie_days),0) AS avg_inter_movie_days,
	ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS avg_rating,
    SUM(total_votes) AS total_votes,
    MIN(avg_rating) AS min_rating,
    MAX(avg_rating) AS max_rating,
    SUM(duration) AS total_duration
FROM 
movie_summary
GROUP BY director_id
ORDER BY number_of_movies DESC, avg_rating DESC;




