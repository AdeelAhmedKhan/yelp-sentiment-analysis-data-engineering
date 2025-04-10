-- Analysis

-- 1- find number of business in each category

with cte as(
select business_id, trim(value) as category
from tbl_yelp_businesses
,lateral split_to_table(categories,',')
)

select category,count(*) as no_of_business
from cte
group by 1
order by 2 desc


-- 2- find the top 10 users who have reviewed the most business in the "Resturants" category

select * from tbl_yelp_reviews limit 10
select * from tbl_yelp_businesses limit 10

select r.user_id, count(distinct (r.business_id))
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
where b.categories ilike '%restaurant%'
group by 1
order by 2 desc
limit 10


-- 3- find the most popular categories of businesses (based on the number of reviews)


with cte as(
select business_id, trim(value) as category
from tbl_yelp_businesses
,lateral split_to_table(categories,',')
)
select category,count(*) as no_of_reviews
from cte
inner join tbl_yelp_reviews r on cte.business_id=r.business_id
group by category
order by 2 desc


-- 4- find the top 3 most recent reviews for each business
with cte as(
select r.*,b.name,
row_number() over(partition by r.business_id order by review_date desc) as rn
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
)
select * from cte
where rn<=3



-- 5- find the month with the highest number of reviews

select month(review_date) as review_month, count(*) as no_of_reviews
from tbl_yelp_reviews
group by 1
order by 2 desc

