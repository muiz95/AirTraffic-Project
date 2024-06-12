USE AirTraffic;

-- Introduction: 
-- We used SQL to uncover key insights from flight and airport data for in our analysis for the BrainStation Mutual Fund. 
-- Our analysis focused on three major airlines—Delta Airlines, American Airlines, and Southwest Airlines.
-- We aim to provide adequate insights to give an informed investment decision by answering several business specific questions. 
-- Our insights will help the Mutual Fund identify the potential opportunities in investing in the airline stocks as well as the risks involved.

/* Question 1a) How many flights were there in 2018 and 2019 separately?
*/
SELECT COUNT(*) AS number_of_flights
FROM flights
WHERE YEAR(flightdate) = 2018;
-- Solution: In this query, we used COUNT(*) to count the number of flights in the entire data frame, while using WHERE to specify what year we want to output
-- The query outputs a column named number of flights with a value of 3218653 which is the total number of flights in 2018

SELECT COUNT(*) AS number_of_flights
FROM flights
WHERE YEAR(flightdate) = 2019;
-- Solution: The query outputs a column named number of flights with a value of 3302708 which is the total number of flights in 2019
-- Explanation: We can see a 2.6% increase in the number of flights from 2018 to 2019. 

/* Question 1b) In total, how many flights were cancelled or departed late over both years?
*/
SELECT COUNT(*) AS cancelled_or_delayed_flights
FROM flights
WHERE Cancelled > 0 OR ArrDelay >0;
-- Solution: In this query, we used the WHERE statement to check where values of columns Cancelled and ArrDElay are greater than 0. Cancelled could be either 0 or 1, while ArrDelay can be 0 and above.
-- The query outputs a column named cancelled_or_delayed_flights with a value of 2295010 which is the total number of flights that were either cancelled or delayed over the course of 2018 and 2019

/* Question 1c) Show the number of flights that were cancelled broken down by the reason for cancellation.
*/
SELECT DISTINCT CancellationReason, COUNT(*) AS number_of_cancelled_flights
FROM flights
WHERE cancelled = 1
GROUP BY CancellationReason
ORDER BY number_of_cancelled_flights DESC;
-- Solution: In this query, we use DISTINCT to make sure CancellationReasons are not repeated and WHERE cancelled=1 to only show flights that were cancelled
-- 	         We then GROUP the output by the cancellation reason using GROUP BY.
-- The query output a table that shows the Cancellation Reason in one column and the number of cancelled flights based on the cancellation reason in the second column

/* Question 1d) For each month in 2019, report both the total number of flights and percentage of flights cancelled. Based on your results, what might you say about the cyclic nature of airline revenue?
*/
SELECT month(FlightDate) AS month, COUNT(*) AS total_flights,(SUM(cancelled) * 100.0 / COUNT(*)) AS percentage_cancelled
FROM flights
WHERE YEAR(flightdate) = 2019
GROUP BY month(flightdate)
ORDER BY percentage_cancelled DESC;
-- Solution: In this query, we use SUM(cancelled) to count the number of cancelled flights for each month
--           We calculate the percentage of flights cancelled as (SUM(cancelled) * 100.0 / COUNT(*)), where COUNT(*) is the total number of flights for that month
--           We use month to extract the month as a number e.g January=1, February=2 etc and then we use ORDER to list the months in ascending order
-- The query outputs a column for month, a column for the total flights for each month and the percentage cancellation for each month
-- Explanation: Based on all the above findings, we can see that the main reason for cancelled flights is because of weather and that the airlines have seasonal variations in revenue.
--              There are more cancellations in the spring months(January, February, March, April, May).The percentage of cancellations gradually decrease in the summer and reach the lowest point in the fall.
--              Majority of these cancellations were most likely due to weather or the carrier. 
--              We suggest that investment should be done right after the fall season to see an increase in profits in the fall as revenue begins to increase.

/* Question 2a) Create two new tables, one for each year (2018 and 2019) showing the total miles traveled and number of flights broken down by airline
*/
CREATE TABLE FlightsSummary_2018 AS
SELECT
    AirlineName,
    COUNT(*) AS total_flights,
    SUM(Distance) AS total_miles
FROM flights
WHERE YEAR(flightdate) = 2018
GROUP BY AirlineName;
-- Solution: In this query, we use CREATE TABLE to create a new table in our schema, COUNT(*) to show the total number of lights and SUM to get the total distance travelled by each flight uisng the column AirlineName to group the table baseed on each airline
--           The query outputs a table with columns AirlineName, total_flights and total_miles showing all three airlines with their total amount of flights and total distance travelled by the flights in the year 2018.

CREATE TABLE FlightsSummary_2019 AS
SELECT
    AirlineName,
    COUNT(*) AS total_flights,
    SUM(Distance) AS total_miles
FROM flights
WHERE YEAR(flightdate) = 2019
GROUP BY AirlineName;
-- Solution :The query outputs a table with columns AirlineName, total_flights and total_miles showing all three airlines with their total amount of flights and total distance travelled by the flights in the year 2019

/* Question 2b) Using your new tables, find the year-over-year percent change in total flights and miles traveled for each airline
*/
SELECT 
	F18.AirlineName,
    (F19.total_flights - F18.total_flights) AS flight_difference,
    (F19.total_miles - F18.total_miles) AS miles_difference,
    (F19.total_flights - F18.total_flights) * 100.0 / F18.total_flights AS percent_change_flights,
    (F19.total_miles - F18.total_miles) * 100.0 / F18.total_miles AS percent_change_miles
FROM FlightsSummary_2018 F18
JOIN FlightsSummary_2019 F19
ON F18.AirlineName = F19.AirlineName;
-- Solution: In this query, calculate the change in the total number of flights and total miles traveled for each airline from 2018 to 2019
--           We calculate the year-over-year percent change for both flights and miles traveled by dividing the change by the 2018 value and multiplying by 100
--           We use JOIN to combine columns from both tables(FlightsSummary_2018 and FlightsSummary_2019)
--           The query outputs columns AirlineName, flight_difference, miles_difference, percentage_change_flights, percentage_change_miles
-- Explanation: Based on the result we see that Delta airlines had a 5.56% increase in miles traveled and 4.5% increase in total number of flights.
--              Southwest Airlines had a 0.8% increase in total flights but 0.12 percent decrease in total miles travelled
--              We advise investing in Delta Airlines since there is a significant increase in flights and miles travelled. This would also suggest a significant increase in revenue compared to the other two airlines 


/* Question 3a) What are the names of the 10 most popular destination airports overall? For this question, generate a SQL query that first joins flights and airports then does the necessary aggregation.
*/
SELECT
    airports.AirportName AS Destination_Airport,
    COUNT(*) AS FlightCount
FROM flights
JOIN airports ON flights.DestAirportID = airports.AirportID
GROUP BY airports.AirportName
ORDER BY FlightCount DESC
LIMIT 10;
-- Solution: In this query, We join the "flights" table with the "airports" table using the "DestinationAirportID" and "AirportID" columns to match flights to their destination airports
--           We use GROUP BY clause to group the results by "AirportName," which represents the destination airports.
--           We count the number of flights to each destination airport using COUNT(*).
--           We using ORDER BY to output the results in descending order based on the number of flights 
--           We LIMIT to limit the results to the top 10 destination airports by flight count
--           The query outputs columns Destination_Airport and FlightCount
--           Runtime for the query is 17.967 seconds

/* Question 3b) Answer the same question but using a subquery to aggregate & limit the flight data before your join with the airport information, hence optimizing your query runtime.
*/
SELECT
    airports.AirportName AS Destination_Airport,
    flt.FlightCount
FROM (
    SELECT
        DestAirportID,
        COUNT(*) AS FlightCount
    FROM flights
    GROUP BY DestAirportID
    ORDER BY FlightCount DESC
    LIMIT 10
)AS flt
JOIN airports ON flt.DestAirportID = airports.AirportID
ORDER BY FlightCount DESC;
-- Solution: The subquery aggregates and limits the flight data before performing the JOIN. It counts the number of flights, groups the flights by DestAirportID, orders the count in descending order and then limits the result to the the top 10 destinations with the most flights
--           The main query selects the AirportName and Flightcount gotten fromsubquery. It then joins the results gotten from the subquery with the airports table using the DestAirportID and AirportID and orders the FlightCount in descending order
--           The query outputs a column for Destinatio_Airport and second column for FlightCount
--           The airport with the highiest flight count overall is Hartsfield-Jackson Atlanta International and the lowest is Chicago Midway International
--           Runtime is 2.738 seconds
-- Explanation: The first query without a subquery was slow because it processed all the data in the flights table before reducing it to the top 10 destination airports
--              The second query with a subquery was faster because the subquery first aggregates and limits the data from the flights table to the top airports with the most flights. The join with the airports table is therefore done on a smaller already filtered dataset that contains only the necessary data. 
--              The second query that contains a subquery reduces the amount of data involved in the join process therefore making the query more efficient and faster.

/* Question 4a) A flight's tail number is the actual number affixed to the fuselage of an aircraft, much like a car license plate. As such, each plane has a unique tail number and the number of unique tail numbers for each airline should approximate how many planes the airline operates in total. Using this information, determine the number of unique aircrafts each airline operated in total over 2018-2019.
*/
SELECT
    AirlineName,
    COUNT(DISTINCT Tail_Number) AS unique_plane_count
FROM flights
WHERE YEAR(FlightDate) BETWEEN 2018 AND 2019
GROUP BY AirlineName
ORDER BY unique_plane_count DESC;
-- Solution:In this query, we use COUNT(DISTINCT tail_number) to count the number of unique tailnumbers for each airline
--          We filter the data for years 2018 and 2019 using WHERE and group the result using the AirlineName column
--          The query outputs columns AirlineName and unique_plane_count
--          The airline with the most unique plane count is American Airlines

/* Question 4b) Similarly, the total miles traveled by each airline gives an idea of total fuel costs and the distance traveled per plane gives an approximation of total equipment costs. What is the average distance traveled per aircraft for each of the three airlines?
*/
SELECT
    AirlineName,
    SUM(Distance) AS total_miles,
    SUM(Distance) / COUNT(DISTINCT Tail_Number) AS average_distance_per_plane
FROM flights
GROUP BY AirlineName
ORDER BY total_miles DESC;
-- Solution: In this query, we sum the total miles traveled for each airline and calculate the average distance traveled per aircraft by dividing the total miles traveled by the number of unique aircraft for each airline.
--           The query outputs column AirlineName, total_miles, average_distance_per_plane
--           The airline with the most total miles and average distance per plane is Southwest Airlines
-- Explanation: Based on the results, we can see conclude that Southwest Airlines have the highiest fuel costs and total equipment costs out of the three airlines. This would also have a negative impact on the revenue and would not be the best ideal airline to invest in.
--              Delta airlines on the other hand has the lowest total miles and average distance per plane suggesting lower costs

/* Question 5a) Find the average departure delay for each time-of-day across the whole data set. Can you explain the pattern you see?
*/
SELECT
    CASE
        WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
        WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
        WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
        ELSE "4-night"
    END AS time_of_day,
    AVG(
        CASE
            WHEN DepDelay >= 0 THEN DepDelay
            ELSE 0
        END
    ) AS avg_departure_delay
FROM flights
GROUP BY time_of_day
ORDER BY time_of_day;
-- Solution: In this query,we categorize the departure times into four categories ("1-morning," "2-afternoon," "3-evening," and "4-night") based on the hour of the "CRSDepTime" (scheduled departure time)
--           We calculate the average departure delay for each time-of-day category, setting early departures and arrivals with negative values as on-time (0 delay).
--           We use GROUP to group the result by the time of day and order the result from morning to evening
--           The query outputs columns time_of_day and avg_departure_delay
-- Explanation: The time of day with the most average departure delay is evening followed by the afternoon. 

/* Question 5b) Now, find the average departure delay for each airport and time-of-day combination.
*/
SELECT
    airports.AirportName AS Airport,
    CASE
        WHEN HOUR(flights.CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
        WHEN HOUR(flights.CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
        WHEN HOUR(flights.CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
        ELSE "4-night"
    END AS time_of_day,
    AVG(
        CASE
            WHEN flights.DepDelay >= 0 THEN flights.DepDelay
            ELSE 0
        END
    ) AS avg_departure_delay
FROM flights 
JOIN airports ON flights.OriginAirportID = airports.AirportID
GROUP BY airports.AirportName, time_of_day
ORDER BY Airport, time_of_day;
-- Solution: In this query, we join the "flights" table with the "airports" table using the "OriginAirportID" and "AirportID" columns to match flights to their origin airports
--           We GROUP the results by AirportName and time_of_day
--           The query outputs a table showing all the airports with the corresponding average departure delays for each time of the day.
-- Explanation: Just taking a quick glance at the results, we can see that majority of the airports have the most average departure delays in the afternoon and evening.

/* Question 5c) Next, limit your average departure delay analysis to morning delays and airports with at least 10,000 flights
*/
CREATE VIEW AirportFlights AS
    SELECT
        flights.OriginAirportID,
        airports.AirportName AS Airport,
        airports.City AS City,
        COUNT(*) AS flight_count
    FROM flights 
    JOIN airports  ON flights.OriginAirportID = airports.AirportID
    GROUP BY flights.OriginAirportID, airports.AirportName,airports.City
    HAVING COUNT(*) >= 10000;
-- In this query, we create a view table to calculate the number of flights for each airport and filter for airports with at least 10,000 flights

SELECT
    AirportFlights.Airport,
    CASE
        WHEN HOUR(flights.CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    END AS time_of_day,
    AVG(
        CASE
            WHEN flights.DepDelay >= 0 THEN flights.DepDelay
            ELSE 0
        END
    ) AS avg_departure_delay
FROM flights 
JOIN AirportFlights ON flights.OriginAirportID = AirportFlights.OriginAirportID
WHERE HOUR(flights.CRSDepTime) BETWEEN 7 AND 11
GROUP BY AirportFlights.Airport, time_of_day
ORDER BY AirportFlights.Airport ASC;
-- Using the view table, we join the flights table to get the airports that have atleast 10,000 flights
-- We then filter the result to only show the morning time category for each airport and calculate the avergae delay for these selected airports
-- We order the airport in ascending order by name
-- Solution: The query gives the airports, time of day and average departure delay for the filtered airports

/* Question 5d) By extending the query from the previous question, name the top-10 airports (with >10000 flights) with the highest average morning delay. In what cities are these airports located?
*/
SELECT
    AirportFlights.Airport,
    AirportFlights.City,
    CASE
        WHEN HOUR(flights.CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    END AS time_of_day,
    AVG(
        CASE
            WHEN flights.DepDelay >= 0 THEN flights.DepDelay
            ELSE 0
        END
    ) AS avg_morning_departure_delay
FROM flights
JOIN AirportFlights ON flights.OriginAirportID = AirportFlights.OriginAirportID
WHERE HOUR(flights.CRSDepTime) BETWEEN 7 AND 11
GROUP BY AirportFlights.Airport,AirportFlights.City,time_of_day
ORDER BY avg_morning_departure_delay ASC
LIMIT 10;
-- We again use the view table we created before(AirportFlights). We include city column in the view table and inclue it in our query. 
-- We then use the same query as before but instead limit the count to 10 and order the result by average departure delay in descending. 
-- The query gives us a list of the top-10 airports (with >10000 flights) with the highest average morning delay
-- The top 10 airports are located in San Francisco,Houston,Chicago,Dallas,Los Angeles, Seattle, Tulsa, Boston and Raleigh.
-- 

-- CONCLUSION:
-- Based on our analysis,we can see an increase in the amount of flights from 2018 to 2019 which correlates to a positive increase in revenue in the aviation industry. we can conclude that the best airline to invest in is Delta Airlines.
-- About 2,295,010 flights have been either been cancelled or delayed over the course of these two years. Out of these flights, 50225 were cancelled due to weather and 34141 were due to the carrier airline.
-- Most of these cancellations happened in the spring months, gradually decreased over the summer and reached a low in the fall.
-- We therefore suggest that the investment in the airline stocks should be done right after spring season and invtesments can be taken out in the fall season when revenue for the airlines begin to increase.
-- Delta airlines had the highiest increase in miles traveled total number of flights out of the three airlines. Followed by American Airlines with Southwest Airline coming last.
-- The airport with the most flightcount is Hartsfield-jackson Atlanta International airport which is the primary hub and primary maintenance base fro Delta Airlines.Followed by Dallas/ForthWorth International which is the hub base for American Airlines.
-- Although American Airlines has the highiest unique tail counts of all the airlines, Delta Airlines has the lowest total miles and average distance per plane. Southwest Airlines on the other hand has the lowest which could imply that Southwest Airlines has the highiest fuel cost and material costs.
-- Having these high costs would correlate to lower revenue. Delta Airlines has the least fuel and material costs.
-- Based on all the analysis above, we can conclude that investing in Delta Airlines would be best for optimal return on investment.
