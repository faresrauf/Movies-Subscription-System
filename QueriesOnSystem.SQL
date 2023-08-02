--TASK 1:
	-- CREATE A LIST OF DIRECTORS WITH ALL OF THEIR MOVIES, 
	-- INCLUDING THE REVIEWS AND THE USER INFORMATION FOR EVERY REVIEW 
	-- AND THE ENTIRE HISTORY OF THE USER (FOR ALL MOVIES)

SELECT m.Title, m.Director, r.ReviewComment, u.Name, u.Email, m2.Title
FROM Movie AS m
JOIN MovieReviews AS r ON m.MovieID = r.MovieID
JOIN UserAccount AS u ON r.UserID = u.UserID
JOIN ViewHistory AS v ON u.UserID = v.UserID
JOIN Movie AS m2 ON v.MovieID = m2.MovieID;


--TASK 2:
    --RETURN THE MOST WATCHED MOVIE PER GENRE ALONG WITH THE NUMBER OF VIEWS.
WITH MovieViewsPerGenre AS (
		SELECT
			mg.Genre,
			m.Title,
			COUNT(v.ViewID) 
		AS TotalNumberOfViews
		FROM Movie AS m
		JOIN ViewHistory AS v 
		ON m.MovieID = v.MovieID
		JOIN Movies_Genre AS mg
		ON mg.MovieID = m.MovieID
		GROUP BY (mg.Genre, m.Title)
) 

SELECT 
	DISTINCT ON (m1.Genre) 
	m1.Genre,
	m2.Title, 
	m1.TotalNumberOfViews
FROM
(SELECT 
	 MovieViewsPerGenre.Genre, 
	 MAX(MovieViewsPerGenre.TotalNumberOfViews) AS TotalNumberOfViews
 FROM MovieViewsPerGenre
 GROUP BY  MovieViewsPerGenre.Genre) AS m1
 JOIN MovieViewsPerGenre AS m2
 ON m1.Genre = m2.Genre AND m1.TotalNumberOfViews = m2.TotalNumberOfViews;
 
 
--TASK 3
    -- RETURN A LIST WITH ALL CAST MEMBERS NOMINATED TO OSCAR PRICE:
    -- IN OTHER WORDS, THAT HAVE PARTICIPATED 
    -- AT 3 MOVIES WITH AVG RATING >= 4.5 AT LEAST.
SELECT 
	mc.MemberName, 
	COUNT(DISTINCT m.Title) AS ParticipationsOnOscarMovies
FROM Movies_CastMembers AS mc
JOIN Movie AS m
ON mc.MovieID = m.MovieID
JOIN (
	SELECT Title, AvgRating
	FROM Movie
	WHERE AvgRating >= 4.5
) AS MoviesWithOscarRating
ON m.Title = MoviesWithOscarRating.Title
GROUP BY mc.MemberName
HAVING COUNT(DISTINCT m.Title) >= 3
ORDER BY ParticipationsOnOscarMovies DESC;


