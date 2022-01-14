--Note that this project refers to a Yelp database (ER diagram: https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/hOlYbrgyEeeTsRKxhJ5OZg_517578844a2fd129650492eda3186cd1_YelpERDiagram.png?expiry=1642204800000&hmac=E0wGo4wEu7UQ87URIU36kFOqS7he0r8eKMviUMfzh1Q)


--Profile the data by finding the total number of records for each of the tables below:
SELECT
    COUNT(*)
FROM
    table_name;

    --the following counts records in the Attribute table
SELECT 
    COUNT(*)
FROM
    attribute;


--Find the total distinct records by either the foreign key or primary key for each table. 
--If two foreign keys are listed in the table, please specify which foreign key.
SELECT
    COUNT(DISTINCT(primary_key))
FROM
    table_name;

    --the following counts distinct records in the Business table, using primary key 'id'
SELECT 
    COUNT(DISTINCT(id))
FROM
    business;


--Are there any columns with null values in the Users table? (yes/no)
SELECT
    COUNT(id) as total_rows
    ,COUNT(id) - COUNT(name) as null_name
    ,COUNT(id) - COUNT(review_count) as null_reviewct
    ,COUNT(id) - COUNT(yelping_since) as null_since
    ,COUNT(id) - COUNT(useful) as null_useful
    ,COUNT(id) - COUNT(funny) as null_funny
    ,COUNT(id) - COUNT(cool) as null_cool
    ,COUNT(id) - COUNT(fans) as null_fans
    ,COUNT(id) - COUNT(average_stars) as null_avgstars
    ,COUNT(id) - COUNT(compliment_hot) as null_hot
    ,COUNT(id) - COUNT(compliment_more) as null_more
    ,COUNT(id) - COUNT(compliment_profile) as null_profile
    ,COUNT(id) - COUNT(compliment_cute) as null_cute
    ,COUNT(id) - COUNT(compliment_list) as null_list
    ,COUNT(id) - COUNT(compliment_note) as null_note
    ,COUNT(id) - COUNT(compliment_plain) as null_plain
    ,COUNT(id) - COUNT(compliment_cool) as null_cool
    ,COUNT(id) - COUNT(compliment_funny) as null_funny
    ,COUNT(id) - COUNT(compliment_writer) as null_writer
    ,COUNT(id) - COUNT(compliment_photos) as null_photos
FROM
    user;


--For the Review table, display the minimum, maximum and average value for the Stars column
SELECT
    MIN(stars)
    ,MAX(stars)
    ,AVG(stars)
FROM   
    review;


--List the cities with the most reviews in descending order.
SELECT
    city
    ,SUM(review_count) as total_reviews
FROM
    business
GROUP BY city
ORDER BY total_reviews desc;


--Find the distribution of star ratings to the business in the city Avon:
SELECT
    stars
    ,COUNT(*) as count
FROM
    business
WHERE
    city = 'Avon'
GROUP BY stars;

--Find the top 3 users based on their total number of reviews:
SELECT
    id
    ,name
    ,review_count
FROM user
ORDER BY review_count desc
LIMIT 3;


--Does posting more reviews correlate with more fans?
--(Qualitative)
SELECT
    CASE
        WHEN review_count > 1000 THEN 'high'
        WHEN review_count > 500 THEN 'med'
        WHEN review_count > 0 THEN 'low'
        ELSE NULL
        END cat_reviews
    ,AVG(fans)
    ,MAX(fans)
    ,MIN(fans)
FROM 
    user
GROUP BY cat_reviews;


--Are there more reviews with the word "love" or with the word "hate" in them?
SELECT
    'love' as word
    ,COUNT(*) as n_reviews
FROM 
    review
WHERE 
    text LIKE '%love%' OR text LIKE '%Love%' OR text LIKE '%LOVE%'

UNION

SELECT
    'hate' as word
    ,COUNT(*) as n_reviews
FROM 
    review
WHERE 
    text LIKE '%hate%' OR text LIKE '%Hate%' OR text LIKE '%HATE%'


--Find the top 10 users with the most fans:
SELECT
    id
    ,name
    ,fans
FROM user
ORDER BY fans desc
LIMIT 10;