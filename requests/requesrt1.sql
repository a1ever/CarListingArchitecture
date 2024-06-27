--Вывести топ 5 магазинов по кол-ву продаж.

select author_shop.shop_id, SUM(author_sold) as shop_sold
from author_shop
join (
select author_id as listing_author, SUM(listing.amount) as author_sold
from listing
where listing_status = 'SOLD'
GROUP BY author_id
) lst on lst.listing_author = author_shop.author_id
group by author_shop.shop_id
order by shop_sold desc
limit 5;