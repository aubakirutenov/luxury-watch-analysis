-- =========================================================================
-- LUXURY WATCH MARKET ANALYSIS 
-- Database: watches_db.sqlite | Table: Watches
-- =========================================================================

-- 1. Analyzing Chronograph Market Presence
WITH ChronoWatches AS (
    SELECT brand, name 
    FROM Watches
    WHERE name LIKE '%Chronograph%'
)
SELECT brand, COUNT(*) AS chrono_count
FROM ChronoWatches
GROUP BY brand
ORDER BY chrono_count DESC
LIMIT 5;

-- 2. Hunting for "Royal Oak" Models
WITH RoyalOaks AS (
    SELECT brand, name 
    FROM Watches
    WHERE name LIKE '%Royal Oak%'
)
SELECT brand, COUNT(*) AS oak_count
FROM RoyalOaks
GROUP BY brand
ORDER BY oak_count DESC
LIMIT 3;

-- 3. Identifying Niche Brands (100 to 500 listings)
WITH ListingsCount AS (
    SELECT brand, COUNT(*) AS total_count
    FROM Watches
    GROUP BY brand
)
SELECT brand, total_count
FROM ListingsCount
WHERE total_count BETWEEN 100 AND 500
ORDER BY total_count DESC;

-- 4. Analyzing Leaders with Transparent Pricing (Ignoring 'Price on request')
WITH ClearPrices AS (
    SELECT brand
    FROM Watches
    WHERE price != 'Price on request'
)
SELECT brand, COUNT(*) AS total_count
FROM ClearPrices
GROUP BY brand
ORDER BY total_count DESC
LIMIT 5;

-- 5. Most Popular Case Materials for Automatic Watches
WITH AutomaticWatches AS (
    SELECT casem
    FROM Watches
    WHERE mvmt = 'Automatic'
)
SELECT casem, COUNT(*) AS total_count
FROM AutomaticWatches
GROUP BY casem
ORDER BY total_count DESC
LIMIT 5;

-- 6. "Gold Rush": Brands Producing the Most Gold Watches
WITH GoldWatches AS (
    SELECT brand
    FROM Watches
    WHERE casem LIKE '%Gold%'
)
SELECT brand, COUNT(*) AS total_count
FROM GoldWatches
GROUP BY brand
ORDER BY total_count DESC
LIMIT 3;

-- 7. Multi-CTE Analysis: Top Brands for Women's Watches (>5000 listings)
WITH WomensWatches AS (
    SELECT brand
    FROM Watches
    WHERE sex LIKE '%Women%'
), 
BrandCounts AS (
    SELECT brand, COUNT(*) AS total
    FROM WomensWatches
    GROUP BY brand
)
SELECT *
FROM BrandCounts
WHERE total > 5000
ORDER BY total DESC;

-- 8. Calculate Year-over-Year (YoY) production dynamics for Rolex with year text cleaning
WITH CleanData AS (
    -- Step 1: Clean the year (extract first 4 characters) and filter out garbage data
    SELECT SUBSTR(yop, 1, 4) AS clean_year
    FROM Watches
    WHERE brand = 'Rolex' 
      AND yop IS NOT NULL 
      AND yop != 'Unknown'
),
YearlyCounts AS (
    -- Step 2: Aggregate totals using the cleaned years
    SELECT clean_year, COUNT(*) AS watches_produced
    FROM CleanData
    GROUP BY clean_year
)
-- Step 3: Apply LAG function based on strict chronological order
SELECT 
    clean_year, 
    watches_produced,
    LAG(watches_produced) OVER(ORDER BY clean_year) AS prev_year_produced,
    watches_produced - LAG(watches_produced) OVER(ORDER BY clean_year) AS yoy_diff
FROM YearlyCounts
ORDER BY clean_year DESC;

-- 9. Rank brands by total number of listings (RANK vs DENSE_RANK comparison)
WITH BrandTotals AS (
    SELECT brand, COUNT(*) AS total_listings
    FROM Watches
    GROUP BY brand
)
SELECT 
    brand, 
    total_listings,
    RANK() OVER(ORDER BY total_listings DESC) AS rank_normal,
    DENSE_RANK() OVER(ORDER BY total_listings DESC) AS rank_dense
FROM BrandTotals;
