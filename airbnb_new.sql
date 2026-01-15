CREATE DATABASE airbnb;
use airbnb;
select * from listings limit 10;
select count(*) from listings; 

/*  Which cities have more supply

Which cities are premium/expensive

Which property types dominate */
# Total listings by city
SELECT city, COUNT(*) AS total_listings
FROM listings
GROUP BY city
ORDER BY total_listings DESC;

# Average price by city
SELECT city, ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY city
ORDER BY avg_price DESC;

# Property type distribution
SELECT property_type, COUNT(*) AS total
FROM listings
GROUP BY property_type
ORDER BY total DESC;

-- Pricing strategy insights
-- Price vs room type
SELECT room_type, ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY room_type
ORDER BY avg_price DESC;

-- Price vs number of bedrooms
SELECT bedrooms, ROUND(AVG(price),2) AS avg_price
FROM listings
WHERE bedrooms IS NOT NULL
GROUP BY bedrooms
ORDER BY bedrooms;

-- High-revenue potential properties
-- Assume revenue proxy = price × minimum_nights
SELECT listing_id, name, city, price, minimum_nights,
(price * minimum_nights) AS revenue_potential
FROM listings
ORDER BY revenue_potential DESC
LIMIT 20;

/* What type of listings can be priced higher

What bedroom count earns more

Which properties look high-revenue */

-- Review & rating insights
-- Average rating by city
SELECT city, ROUND(AVG(review_scores_rating),2) AS avg_rating
FROM listings
WHERE review_scores_rating IS NOT NULL
GROUP BY city
ORDER BY avg_rating DESC;

-- Price vs rating relationship
SELECT 
  CASE 
    WHEN review_scores_rating >= 90 THEN 'Excellent (90–100)'
    WHEN review_scores_rating >= 80 THEN 'Good (80–89)'
    WHEN review_scores_rating >= 70 THEN 'Average (70–79)'
    ELSE 'Low (<70)'
  END AS rating_category,
  ROUND(AVG(price),2) AS avg_price,
  COUNT(*) AS listings
FROM listings
WHERE review_scores_rating IS NOT NULL
GROUP BY rating_category
ORDER BY avg_price DESC;

/* Do higher-rated listings charge more?

Which cities maintain quality?

How ratings affect demand proxy */

-- Demand proxy (accommodates / reviews)
-- Popular capacity listings
SELECT accommodates, COUNT(*) AS listing_count,
ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY accommodates
ORDER BY accommodates;

-- Listings with high review count (demand proxy)
SELECT l.city, l.listing_id, l.name,
COUNT(r.review_id) AS total_reviews
FROM listings l
JOIN reviews r 
ON l.listing_id = r.listing_id
GROUP BY l.listing_id, l.city, l.name
ORDER BY total_reviews DESC
LIMIT 20;

/* Which property sizes are most demanded

Which listings receive most bookings historically */

-- Location premium pricing
-- Which neighborhoods are premium investment zones
-- Where hosts can charge more
SELECT city, neighbourhood,
ROUND(AVG(price),2) AS avg_price,
COUNT(*) AS listings
FROM listings
GROUP BY city, neighbourhood
HAVING COUNT(*) > 50
ORDER BY avg_price DESC;

-- Host strategy insights
-- Superhost vs normal host pricing
SELECT host_is_superhost,
ROUND(AVG(price),2) AS avg_price,
ROUND(AVG(review_scores_rating),2) AS avg_rating
FROM listings
GROUP BY host_is_superhost;

/* Does superhost status increase price? */
select * from listings limit 10;











