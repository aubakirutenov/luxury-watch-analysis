# Luxury Watch Market Analysis ⌚️

## Project Overview
This project analyzes a dataset of luxury watches on the secondary market. The goal was to uncover market trends, brand dominance, and pricing anomalies using SQL and visualize the findings in a dynamic Tableau dashboard.

## Tools & Skills Demonstrated
*   **SQL (SQLite):** Advanced queries using Common Table Expressions (CTEs), multi-level aggregation, and data filtering (handling missing/dirty data).
*   **Tableau:** Created an interactive dashboard utilizing User Parameters to allow seamless switching between metrics (e.g., Total Listings vs. Average Price).

## Key Insights
*   **Market Dominance:** Rolex leads the secondary market by a massive margin, both in general listings and specifically in gold watches.
*   **Niche Segments:** Audemars Piguet dominates the "Royal Oak" specific market, while Cartier and Omega show a strong presence in the women's watch segment (>5,000 listings each).
*   **Material Preferences:** Stainless steel is the most common case material for automatic watches, followed by rose gold and titanium.
*   **Data Quality:** Identified and filtered out anomalies such as "Price on request" to ensure accurate statistical aggregation.

## Files
*   `watches_analysis.sql`: Contains all SQL queries and CTE chains used for the data extraction and analysis.
