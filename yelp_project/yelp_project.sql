--Note that this project refers to a Yelp database (ER diagram: https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/hOlYbrgyEeeTsRKxhJ5OZg_517578844a2fd129650492eda3186cd1_YelpERDiagram.png?expiry=1642204800000&hmac=E0wGo4wEu7UQ87URIU36kFOqS7he0r8eKMviUMfzh1Q)

--Pick one city and category of your choice and group the businesses in that city/category by their overall star rating
--Compare the businesses with 2-3 stars to those with 4-5 stars 
--(City: Toronto, Category: Restaurants)

--Do the two groups you chose to analyze have a different distribution of hours?
SELECT
    b.id
    ,b.city
    ,c.category
    ,b.stars
    ,CASE
        WHEN b.stars < 2.0 THEN 'low'
        WHEN b.stars >= 2.0 AND b.stars < 4.0 THEN 'moderate'
        WHEN b.stars >= 4.0 THEN 'high'
        END as stars_grouping
    ,h.hours
    ,b.review_count
FROM 
    business b
LEFT JOIN category c ON (b.id = c.business_id)
LEFT JOIN hours h ON (b.id = h.business_id)
WHERE b.city = 'Toronto' AND c.category = 'Restaurants' AND stars_grouping IN ('moderate', 'high') AND hours LIKE '%Friday%'
ORDER BY stars_grouping desc;

--Do the two groups you chose to analyze have a different number of reviews?
SELECT
    CASE
        WHEN b.stars < 2.0 THEN 'low'
        WHEN b.stars >= 2.0 AND b.stars < 4.0 THEN 'moderate'
        WHEN b.stars >= 4.0 THEN 'high'
        END as stars_grouping
    ,SUM(b.review_count) as total_reviews
FROM 
    business b
LEFT JOIN category c ON (b.id = c.business_id)
WHERE b.city = 'Toronto' AND c.category = 'Restaurants' AND stars_grouping IN ('moderate', 'high')
GROUP BY stars_grouping
ORDER BY stars_grouping desc;

--Are you able to infer anything from the location data provided between these two groups?
SELECT
    CASE
        WHEN b.stars < 2.0 THEN 'low'
        WHEN b.stars >= 2.0 AND b.stars < 4.0 THEN 'moderate'
        WHEN b.stars >= 4.0 THEN 'high'
        END as stars_grouping
    ,b.neighborhood
    ,b.postal_code
FROM 
    business b
LEFT JOIN category c ON (b.id = c.business_id)
WHERE b.city = 'Toronto' AND c.category = 'Restaurants' AND stars_grouping IN ('moderate', 'high')
ORDER BY stars_grouping desc;



--Group businesses based on the ones that are open and the ones that are closed
--What differences can you find between the ones that are still open and the ones that are closed?
--List at least two differences.

--The following computes the average rating usefulness and stars for businesses
--that are still open vs. closed
SELECT
    b.is_open
    ,AVG(r.useful) as avg_rating_usefulness
    ,AVG(b.stars) as avg_business_stars
FROM 
    business b
LEFT JOIN review r ON (b.id = r.business_id)
GROUP BY b.is_open;


--For the last part, I prepare the data for an analysis focused on
--predicting the number of fans a user has
--so the code below essentially combines all attributes of each yelp user in a single table
SELECT
    u.id
    ,u.review_count
    ,SUBSTR(u.yelping_since, 1, 4) as yelping_since
    ,e.year as elite_year
    ,u.useful
    ,u.funny
    ,u.cool
    ,u.fans
    ,u.average_stars
    ,u.compliment_hot
    ,u.compliment_more
    ,u.compliment_profile
    ,u.compliment_cute
    ,u.compliment_list
    ,u.compliment_note
    ,u.compliment_plain
    ,u.compliment_cool
    ,u.compliment_funny
    ,u.compliment_writer
    ,u.compliment_photos
FROM 
    user u
LEFT JOIN elite_years e ON (u.id = e.user_id);