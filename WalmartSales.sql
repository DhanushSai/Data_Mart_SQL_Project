select * from dbo.WalmartSalesData

--2. Add the time_of_day column

select time, 
	CASE WHEN CONVERT(nvarchar(8), Time, 108) between '00:00:00' and '12:00:00' THEN 'Morning'
		 WHEN CONVERT(nvarchar(8), Time, 108) between '12:01:00' and '16:00:00' THEN 'Afternoon'
	ELSE 'Evening'
	END as time_of_date
from dbo.WalmartSalesData

alter table dbo.WalmartSalesData
add time_of_date varchar(20)

update dbo.WalmartSalesData
set time_of_date = (
	CASE WHEN CONVERT(nvarchar(8), Time, 108) between '00:00:00' and '12:00:00' THEN 'Morning'
		 WHEN CONVERT(nvarchar(8), Time, 108) between '12:01:00' and '16:00:00' THEN 'Afternoon'
	ELSE 'Evening'
	END
)

--3. Add day_name column

	SELECT date, DATENAME(WEEKDAY, Date) as Week_day
	FROM dbo.WalmartSalesData;

	alter table dbo.WalmartSalesData
	add week_day varchar(20)

	update dbo.WalmartSalesData
	set week_day = DATENAME(WEEKDAY, Date)


--4. Add month_name column

	SELECT date, DATENAME(MONTH, Date) as Month_Name
	FROM dbo.WalmartSalesData;

	alter table dbo.WalmartSalesData
	add month_name varchar(20)

	update dbo.WalmartSalesData
	set month_name = DATENAME(MONTH, Date)


--5. How many unique cities does the data have?

select distinct city from dbo.WalmartSalesData

--6. In which city is each branch?

select distinct city, branch from dbo.WalmartSalesData

--7. How many unique product lines does the data have?

select distinct [Product line] from dbo.WalmartSalesData

--8. What is the most selling product line

select SUM(Quantity) AS Qty, [Product line] from dbo.WalmartSalesData
group by Quantity, [Product line]
order by Qty DESC

--9. What is the most common payment method

select Payment, count(*) as Common from dbo.WalmartSalesData
group by Payment
order by Common DESC

--10. What is the total revenue by month

select month_name, sum(total) as Total_Revenue
from dbo.WalmartSalesData
group by month_name
order by Total_Revenue DESC

-- 11. What month had the largest COGS?

select sum(cogs) as Max_Cogs, month_name from dbo.WalmartSalesData
group by month_name
order by Max_Cogs DESC

--12. What product line had the largest revenue?

select [Product line], sum(total) as Total_Revenue from dbo.WalmartSalesData
group by [Product line]
order by Total_Revenue DESC

--13. What is the city with the largest revenue?

select city, sum(total) as total_revenue 
from dbo.WalmartSalesData
group by City
order by total_revenue DESC

--14. What product line had the largest VAT?

select [Product line], AVG([Tax 5%]) as VAT from dbo.WalmartSalesData
GROUP BY [Product line]
order by VAT DESC

--15. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

select [Product line], AVG(Quantity) as Avg_Quantity from dbo.WalmartSalesData
GROUP BY [Product line]

SELECT [Product line],
	CASE
		WHEN AVG(quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark 
FROM dbo.WalmartSalesData
GROUP BY [Product line];

--16. Which branch sold more products than average product sold?

select branch, SUM(Quantity) AS QTY from dbo.WalmartSalesData
group by Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) from dbo.WalmartSalesData)

--17. -- What is the most common product line by gender

SELECT gender, [Product line], COUNT(gender) AS total_cnt
FROM dbo.WalmartSalesData
GROUP BY gender, [Product line]
ORDER BY total_cnt DESC;

--18. What is the average rating of each product line

select [Product line], ROUND(AVG(Rating),2) AS Average_Rating from dbo.WalmartSalesData
GROUP BY [Product line]
order by Average_Rating DESC

--19. Number of sales made in each time of the day per weekday

select * from dbo.WalmartSalesData

select time_of_date, week_day, count(total) as Total_Sales from dbo.WalmartSalesData
group by time_of_date, week_day
order by Total_Sales DESC

--20. Which of the customer types brings the most revenue?]

select [Customer type], SUM(Total) as Total_Sales from dbo.WalmartSalesData
group by [Customer type]
order by Total_Sales DESC

--21. Which city has the largest tax percent/ VAT

select city, ROUND(AVG([Tax 5%]), 2) as Largest_Tax from dbo.WalmartSalesData
group by city
order by Largest_Tax DESC


-- 22. How many unique customer types does the data have?

select distinct [Customer type] from DBO.WalmartSalesData

--23. How many unique payment methods does the data have?

select distinct [Payment] from DBO.WalmartSalesData

--24. What is the most common customer type?

select [Customer type], count(*) as Count from DBO.WalmartSalesData
group by [Customer type]

--25. Which customer type buys the most?

select [Customer type], count(*) as Count from DBO.WalmartSalesData
group by [Customer type]

--26. What is the gender of most of the customers?

select [Gender], count(*) as Count from DBO.WalmartSalesData
group by Gender

--27. What is the gender distribution per branch?

SELECT gender, COUNT(*) as gender_cnt
FROM dbo.WalmartSalesData
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

--28. Which time of the day do customers give most ratings?


SELECT week_day, ROUND(AVG(rating),2) AS avg_rating
FROM dbo.WalmartSalesData
GROUP BY week_day
ORDER BY avg_rating DESC;

