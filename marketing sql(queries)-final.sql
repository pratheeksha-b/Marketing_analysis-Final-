create database marketng;
use marketng;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/marketing.csv'
INTO TABLE market
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
select * from market;
# find average ROI by company
select Company,round(avg(ROI),4) as avg_roi from market
group by Company
order by avg_roi desc;
#Find campaigns with Conversion_Rate greater than 0.10.
select * from market
where Conversion_Rate>0.1;
#Count campaigns by Campaign_Type.
select Campaign_Type, count(*) as total_count from market
group by Campaign_Type
order by total_count desc;
#Find total Clicks and Impressions by Channel_Used.
select Channel_Used,sum(Clicks) as total_clicks, sum(Impressions) as total_Impressions 
from market
group by Channel_Used;
#Find the maximum Acquisition_Cost for each Location
update market
set Acquisition_Cost=replace(Acquisition_Cost,'$','')
where Campaign_ID>0;
update market
set Acquisition_Cost=replace(Acquisition_Cost,',','');
describe market;
alter table market modify column Acquisition_Cost INT;

select Location,max(Acquisition_Cost) from market
group by Location;
#Retrieve campaigns with ROI above overall average.
select Campaign_Type, ROI from market
where ROI>(select avg(ROI) from market);
#Find top 3 companies with highest total ROI.
SELECT Company,
sum(Acquisition_Cost*(ROI+1)) as Total_ROI from market
group by Company
order by Total_ROI desc limit 3;
#Calculate average Engagement_Score by Gender.
select substring_index(Target_Audience,' ',1) as Gender,avg(Engagement_Score)
from market
group by Gender;
#Count campaigns by Age_group.
select substring_index(Target_Audience,' ',-1) as age_group,count(Campaign_Type) from market
group by age_group;
#Find campaigns with minimum Conversion_Rate.
select Campaign_Type,min(Conversion_Rate) from market
group by Campaign_Type;
#Find average ROI grouped by Customer_Segment.
select Customer_Segment,round(avg(ROI),4) as avg_roi from market
group by Customer_Segment
order by avg_roi;
#Find total Acquisition_Cost spent by each Company
select Company,sum(Acquisition_Cost) as total_sum from market
group by Company
order by total_sum desc;
#Find average Clicks per campaign type.
select Campaign_Type,avg(Clicks) as avg_clicks from market
group by Campaign_Type
order by avg_clicks;
#Find channels with average CTR above 5%.
with ctr as(select Channel_Used,(Clicks)/(Impressions)*100 as CTR from market)
select Channel_Used,avg(CTR) as avg_ctr from CTR
group by Channel_Used
having avg_ctr>5;
#Calculate total impressions by month.
alter table market modify column Date date;
select str_to_date(Date,'%m/%d/%Y') as date_new from market;

update market
set Date=str_to_date(Date,'%m/%d/%Y');
describe market;
alter table market modify column Date date;
select month(Date) as month,sum(Impressions) as total_impression from market
group by month
order by total_impression desc;
#Find campaign count for each Gender and Age_group combination.
select substring_index(Target_Audience,' ',1) as gender,substring_index(Target_Audience,' ',-1) as age_group,count(*)
from market
group by gender,age_group
order by gender;
#Rank campaigns by ROI within each Company.
select Company,Campaign_Type,round(avg(ROI),4) as total_roi, dense_rank() over (partition by Company order by round(avg(ROI),4) desc) as ranks 
from market
group by Company,Campaign_Type
order by Company asc,ranks asc;
#Find running total of Clicks over Date.
select Date,sum(Clicks) as total_clicks,sum(sum(Clicks)) over (order by Date)  as cum_sum from market
group by Date
order by Date;
#Find top-performing channel per Location.
with row_index as(select Location,Channel_Used,round(sum(Acquisition_Cost*(ROI+1)),4) as revenue,row_number() over (partition by Location order by 
round(sum(Acquisition_Cost*(ROI+1)),4) desc) as row_num from market
group by Location,Channel_Used
order by Location asc, revenue desc)
select * from row_index
where row_num in (1,2,3);
#Compare each campaign's monthly ROI with previous month.
select Campaign_Type,month(Date) as month,round(avg(ROI),4) as avg_roi, lag(round(avg(ROI),4),1) over (partition by Campaign_Type order by month(Date) asc) as lead_wind from market
group by Campaign_Type,month
order by Campaign_Type;
#Find nth highest ROI campaign.
#Calculate percentage contribution of each company’s ROI.
with percentage_contri as (select Company,sum(Acquisition_Cost*(1+ROI)) as revenue from market
group by Company)
select Company, (revenue/(select sum(revenue) from percentage_contri))*100 as percentage from percentage_contri;
#Find lag difference in Clicks.
with clicks as (select Date,sum(Clicks) as total_clicks,lag(sum(Clicks)) over (order by Date) as prev_clicks from market
group by date)
select Date,total_clicks-prev_clicks as diff,
case
when total_clicks-prev_clicks>0 then 'Increase'
when total_clicks-prev_clicks<0 then 'Decrease'
else 'No_change'
end as status 
from clicks;
#Identify campaigns above company median ROI.
select Company,Campaign_Type,ROI from market a
where ROI>(select avg(ROI) as mean_roi from market b
where a.Company=b.Company);
CREATE VIEW campaign_performance AS
SELECT
    Company,
    Campaign_Type,
    Channel_Used,
    ROI,
    Conversion_Rate,
    Acquisition_Cost,
    Clicks,
    Impressions,
    ROUND((Clicks * 100.0 / Impressions),2) AS CTR,
    Engagement_Score
FROM market;
select * from campaign_performance;
DELIMITER //

CREATE PROCEDURE roi_analysis()
BEGIN
SELECT
Channel_Used,
ROUND(AVG(ROI),2) AS avg_roi,
MAX(ROI) AS max_roi,
MIN(ROI) AS min_roi
FROM market
GROUP BY Channel_Used;
END //
DELIMITER ;
CALL roi_analysis();

# Which combination of Channel_Used and Customer_Segment gives highest ROI?
select Channel_Used,Customer_Segment,round(sum(Acquisition_Cost*(ROI+1)),4) as total_roi from market
group by Channel_Used,Customer_Segment
order by total_roi desc limit 3;
#Find the most cost-efficient campaign.
select Campaign_Type,avg(round((Acquisition_Cost*(ROI+1)),2)) as total_roi,avg(Acquisition_Cost) as total_cost from market 
group by Campaign_Type
order by total_roi desc,total_cost asc;
#Detect underperforming campaigns despite high impressions.
select Campaign_Type,(Acquisition_Cost*(ROI+1)) as roi,Impressions from market
where Impressions>=(select avg(Impressions) from market) 
and (Acquisition_Cost*(ROI+1))<=(select avg(Acquisition_Cost*(ROI+1)) from market)
order by roi asc,Impressions desc;
#Which language performs best for each age group?
with lang as (select substring_index(Target_Audience,' ',-1) as age_group,Language,avg(Engagement_Score) as avg_engagement,
dense_rank() over (partition by substring_index(Target_Audience,' ',-1) order by avg(Engagement_Score) desc) as top from market 
group by age_group,Language
order by age_group asc,avg_engagement desc)
select * from lang
where top=1;
#Find customer segments with highest engagement but low conversion.
select Customer_Segment,avg(Engagement_Score) as avg_engagement,round(avg(Conversion_Rate),4) as avg_conversion from market
group by Customer_Segment
order by avg_engagement desc,avg_conversion asc;
#Identify companies relying heavily on one channel.
with cte AS(
select Company,Channel_Used,COUNT(*) cnt,row_number() over(partition by Company order by count(*) desc) rn from market
group by Company,Channel_Used)
select * from cte
where rn=1;
#Find campaigns with increasing ROI trend over time.
with trend as(select Campaign_Type,month(Date) as months,round(sum(Acquisition_Cost*(1+ROI)),4) as ROI,
lag(round(sum(Acquisition_Cost*(1+ROI)),4)) over (partition by Campaign_Type order by month(Date)) as prev_roi
from market 
group by Campaign_Type,months
order by Campaign_Type)
select Campaign_Type,months,round(((ROI-prev_roi)/prev_roi)*100,4) as increase_decrease,
case 
when round(((ROI-prev_roi)/prev_roi)*100,4)>0 then 'Increse'
when round(((ROI-prev_roi)/prev_roi)*100,4)<0 then 'Decrease'
else 'No_Change'
end as Status
from trend;
#Segment companies into High, Medium, Low ROI tiers.
select Company,round(Acquisition_Cost*(1+ROI)) as revenue,
case 
when round(Acquisition_Cost*(1+ROI))<=(select (max(round(Acquisition_Cost*(1+ROI))))*0.25 from market) then 'Low'
when round(Acquisition_Cost*(1+ROI))<=(select (max(round(Acquisition_Cost*(1+ROI))))*0.75 from market) then 'Medium'
else 'High'
end as Status
from market
order by revenue asc;
SELECT Company,revenue,
CASE
WHEN revenue <= max_rev * 0.25 THEN 'Low'
WHEN revenue <= max_rev * 0.75 THEN 'Medium'
ELSE 'High'
END AS Status
FROM (SELECT Company,ROUND(Acquisition_Cost * (1 + ROI)) AS revenue,
(SELECT MAX(ROUND(Acquisition_Cost * (1 + ROI))) FROM market) AS max_rev
FROM market) t;
#Generate monthly growth percentage in ROI.
select months,total_roi,prev_month,round(((total_roi-prev_month)*100/prev_month),4) as percentage from(
select month(Date) as months,round(sum(Acquisition_Cost*(1+ROI))) as total_roi,lag(round(sum(Acquisition_Cost*(1+ROI)))) over
(order by month(Date)) as prev_month from market
group by months
order by months asc) a;
#Find campaigns active for more than average duration.
select Campaign_Type,substring_index(Duration,' ',1) as duration from market
where substring_index(Duration,' ',1)>(select round(avg(substring_index(Duration,' ',1)),4) from market);
# OR
SELECT Campaign_Type,Duration FROM market 
WHERE CAST(SUBSTRING_INDEX(Duration,' ',1) AS UNSIGNED) >(
SELECT AVG(CAST(SUBSTRING_INDEX(Duration,' ',1) AS UNSIGNED)) FROM market);
#Create a view containing:Company,Campaign_Type,Channel_Used,ROI,Conversion_Rate,CTR (Clicks / Impressions × 100)
create view tables as 
select Company,Campaign_Type,Channel_Used,ROI,Conversion_Rate,Clicks/Impressions*100 as CTR 
from market;
select * from tables;
#Create a view showing campaigns with ROI greater than the overall average ROI.
create view above_avg as
select Campaign_Type,ROI from market
where ROI>(select avg(ROI) from market);
select * from above_avg;
#Create a view displaying:Company,Total Campaigns,Average ROI,Average Conversion Rate,Total Acquisition Cost
create view pivot as 
select Company,count(Campaign_Type) as Total_Campaigns,round(avg(ROI),4) as Average_ROI,round(avg(Conversion_Rate),4) as 
Average_Conversion_Rate,round(sum(Acquisition_Cost*(1+ROI))) as total_cost from market
group by Company;
select * from pivot; 
#Monthly Marketing View:Create a view containing-Month,Total Clicks,Total Impressions,Average ROI
create view monthly_marketing as 
select month(Date) as months,sum(Clicks) as total_clicks,sum(Impressions) as total_Impressions,round(avg(ROI),4) as avg_roi
from market
group by months;
select * from monthly_marketing;
#Engagement Analytics View:Create a view containing-Engagement_Score,Average ROI,Average Conversion Rate
create view Engagement_Analytics as 
select Engagement_Score,round(avg(ROI),4) as avg_roi,round(avg(Conversion_Rate),4) as avg_Conversion_Rate
from market
group by Engagement_Score
order by Engagement_Score;
select * from Engagement_Analytics;
#ROI Analysis Procedure
Delimiter //
create procedure roi()
begin
	select Company,round(avg(ROI),4) as avg_roi,max(ROI) as max_roi,min(ROI) as min_roi 
	from market
	group by Company;
end // 
Delimiter ;
call roi();
#CTR Analysis Procedure:Input- Channel,Return:Average CTR,Highest CTR,Lowest CTR
DELIMITER //
create procedure CTR(Channel_Used varchar(50))
BEGIN
select Channel_Used,round(avg((Clicks/Impressions)*100),4) as avg_ctr,round(max((Clicks/Impressions)*100)) as max_ctr,
round(min((Clicks/Impressions)*100)) as min_ctr from market
group by Channel_Used
order by Channel_Used asc;
END//
DELIMITER ;
call CTR('Email');
#Campaign Duration Analysis Procedure-Input: Duration,Return campaigns longer than specified duration.
DELIMITER //
CREATE PROCEDURE Campaign_Duration(time INT)
BEGIN
select cast(substring_index(Duration,' ',1) as unsigned) as Duration from market
where cast(substring_index(Duration,' ',1) as unsigned)>time;
END//
DELIMITER ;
call Campaign_Duration(45);
#Campaign Type Report Procedure-Input: Campaign Type,Return:Average ROI,Average CTR,Average Conversion Rate
DELIMITER //
CREATE PROCEDURE Campaign_Types(in p_campaign varchar(50))
BEGIN
select Campaign_Type,round(avg(Acquisition_Cost*(ROI+1))) as avg_roi,round(avg(Clicks*100/Impressions),4) as avg_ctr,round(avg(Conversion_Rate),4) as con_rate
from market
where Campaign_Type=p_campaign
group by Campaign_Type;
END//
DELIMITER ;
CALL Campaign_Types('Display');
DELIMITER //
CREATE PROCEDURE Campaign_Type(Campaign_Type varchar(50))
BEGIN
select Campaign_Type,round(avg(Acquisition_Cost*(ROI+1))) as avg_roi,round(avg(Clicks*100/Impressions),4) as avg_ctr,round(avg(Conversion_Rate),4) as con_rate
from market
group by Campaign_Type;
END//
DELIMITER ;
call Campaign_Type('Display');
#Top N Campaigns Procedure-Input: N,Return top N campaigns by ROI.
DELIMITER //
CREATE PROCEDURE Top_N(N INT)
BEGIN
select Campaign_Type,round(avg(Acquisition_Cost*(ROI+1))) as avg_roi from market
group by Campaign_Type
order by avg_roi desc limit N;
END //
DELIMITER ;
CALL Top_N(3);
#Low-Performing Campaign Finder-Input: ROI Threshold,Return campaigns below threshold.
DELIMITER //
CREATE PROCEDURE low_performing(threshold DOUBLE)
BEGIN
select Campaign_Type,ROI from market
where ROI<threshold;
END //
DELIMITER ;
CALL low_performing(4.8);

























