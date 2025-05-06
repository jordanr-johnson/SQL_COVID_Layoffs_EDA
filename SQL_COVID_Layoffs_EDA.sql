select *
from globallayoffs.layoffs2;

select max(total_laid_off)
from globallayoffs.layoffs2;

alter table globallayoffs.layoffs2
modify column total_laid_off int;

select max(total_laid_off)
from globallayoffs.layoffs2;

select max(percentage_laid_off)
from globallayoffs.layoffs2;

select max(total_laid_off), max(percentage_laid_off)
from globallayoffs.layoffs2;

select *
from globallayoffs.layoffs2
where percentage_laid_off=1;

select *
from globallayoffs.layoffs2
where percentage_laid_off=1
order by total_laid_off desc; 

select *
from globallayoffs.layoffs2
where percentage_laid_off=1
order by funds_raised_millions desc; 

alter table globallayoffs.layoffs2
modify column funds_raised_millions int;

update globallayoffs.layoffs2
set funds_raised_millions = null
where funds_raised_millions like "NULL";

select *
from globallayoffs.layoffs2
where percentage_laid_off=1
order by funds_raised_millions desc;

alter table globallayoffs.layoffs2
modify column funds_raised_millions int;

select *
from globallayoffs.layoffs2
where percentage_laid_off=1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from globallayoffs.layoffs2
group by company;

select company, sum(total_laid_off)
from globallayoffs.layoffs2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from GlobalLayoffs.layoffs2;

select country, sum(total_laid_off)
from globallayoffs.layoffs2
group by country
order by 2 desc;

select *
from globallayoffs.layoffs2;

select country
from globallayoffs.layoffs2;

 select `date`, sum(total_laid_off)
from globallayoffs.layoffs2
group by `date`
order by 1 desc;

select year(`date`), sum(total_laid_off)
from globallayoffs.layoffs2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from globallayoffs.layoffs2
group by stage
order by 2 desc;

select company, sum(percentage_laid_off)
from globallayoffs.layoffs2
group by company
order by 2 desc;

select *
from globallayoffs.layoffs2;

select substring(`date`,1,7) as `Month`, sum(total_laid_off)
from globallayoffs.layoffs2
where substring(`date`,1,7) is not null
group by substring(`date`,1,7)
order by 1 asc;

with Rolling_Total as (
select substring(`date`,1,7) as `Month`, sum(total_laid_off) as Total_Off
from globallayoffs.layoffs2
where substring(`date`,1,7) is not null
group by substring(`date`,1,7)
order by 1 asc)
select `Month`, sum(total_off) over(order by `Month`) as Rolling_Total
from Rolling_Total;

with Rolling_Total as (
select substring(`date`,1,7) as `Month`, sum(total_laid_off) as Total_Off
from globallayoffs.layoffs2
where substring(`date`,1,7) is not null
group by substring(`date`,1,7)
order by 1 asc)
select `Month`, total_off,
sum(total_off) over(order by `Month`) as Rolling_Total
from Rolling_Total;

select company, sum(total_laid_off)
from globallayoffs.layoffs2
group by company
order by 2 desc;

select company, year(`date`), sum(total_laid_off)
from globallayoffs.layoffs2
group by company, year(`date`)
order by 3 desc;

with Company_Year (company, years, total_laid_off) as (
select company, year(`date`), sum(total_laid_off)
from globallayoffs.layoffs2
group by company, year(`date`))
Select *
from Company_Year;

with Company_Year (company, years, total_laid_off) as (
select company, year(`date`), sum(total_laid_off)
from globallayoffs.layoffs2
group by company, year(`date`)), Company_Year_Rank as 
(Select *, dense_rank() over(partition by years order by total_laid_off desc) as 'Rank'
from Company_Year
where years is not null)
select * 
from Company_Year_Rank
where `rank` <= 5;
