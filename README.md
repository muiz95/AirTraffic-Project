# AirTraffic-Project

## Project Overview

The "Air Traffic Project" aims to assist the BrainStation Mutual Fund managers in making informed investment decisions while demonstrating my proficiency in data handling and visualization tools.

### Part 1: Data Analysis in SQL

#### Data Description

The database used for this analysis contains two primary tables:
- **Flights Table**: Detailed flight data including dates, airline codes, departure and arrival times, delays, and related metrics.
- **Airports Table**: Information on all origin and destination airports, including names, locations, and geographical coordinates.

#### Key Analysis Questions

1. **Flight Statistics**:
   - Number of flights in 2018 and 2019.
   - Total flights cancelled or delayed.
   - Breakdown of flight cancellations by reason.
   - Monthly flight statistics for 2019, including cancellation percentages to analyze cyclic trends in airline revenue.

2. **Airline Performance**:
   - Created new tables for 2018 and 2019 showing total miles traveled and number of flights by airline.
   - Calculated year-over-year percentage changes in total flights and miles traveled.
   - Provided investment guidance based on these findings.

3. **Airport Utilization**:
   - Identified the 10 most popular destination airports.
   - Optimized query runtime by using subqueries and joins to aggregate flight data.

4. **Operating Costs Estimation**:
   - Estimated the number of unique aircraft operated by each airline based on unique tail numbers.
   - Calculated the average distance traveled per aircraft to infer fuel and equipment costs.
   - Compared airlines based on these cost approximations.

5. **On-time Performance**:
   - Analyzed average departure delays across different times of day.
   - Evaluated airport-specific and time-of-day-specific delays.
   - Identified top-10 airports with the highest average morning delays for airports with over 10,000 flights.

### Part 2: Visual Analytics in Tableau

In the second part of the project, I utilized Tableau to create interactive visualizations that allow users to derive business insights from the same dataset without writing code. These visualizations address specific business questions and are organized into a Tableau Story to present a consistent narrative.

#### Key Analysis Questions

1. **Carrier Comparisons**:
   - **Total Flights (2018-2019)**: Visualize the total number of flights for each carrier across the two years.
   - **Monthly Flight Variations**: Track the monthly number of flights for each carrier.
   - **Top 10 Origin Airports**: Display a stacked bar chart showing the distribution of flights from the top 10 origin airports for each carrier.

2. **On-time Performance**:
   - **On-time vs Delayed Flights**: Compare on-time versus delayed departures by month for 2019.
   - **Average Departure Delay by State**: Highlight table showing average departure delays broken down by state, year, and fiscal quarter.
   - **US Map of Departure Delays**: Map visualization of average departure delays by state.
   - **Flight Cancellations by Month**: Visualize monthly flight cancellations broken down by reason.

3. **Fleet and Distance Analysis**:
   - **Flight Times vs Distances**: Scatter plot of average flight time versus average distance at the airport level.
   - **Year-over-Year Growth**: Visualize the percent change in total distance flown and number of planes in service for each carrier.
   - **Average Distance Traveled per Plane**: Calculate and compare average distance traveled per plane for each carrier.

4. **Interactive Dashboard**:
   - **Departure Delays and Cancellations**: Interactive dashboard combining the map of departure delays, monthly cancellations, and an additional visualization to explore data further.

## Conclusion

This project not only showcases my technical skills but also my ability to derive meaningful business insights from data. By combining SQL for data analysis and Tableau for visualization, I provided a comprehensive overview of the airline industry, helping fund managers make data-driven investment decisions. 

Thank you for visiting my GitHub page! Feel free to explore the repository for detailed SQL scripts and Tableau visualizations. If you have any questions or would like to collaborate, please don't hesitate to reach out!

---

### Repository Structure

- `Part1_SQL_Analysis.sql`: SQL scripts used for data analysis in Part 1.
- `Part2_Tableau_Visualizations.twb`: Tableau workbook with visualizations created in Part 2.
- `README.md`: This document.
