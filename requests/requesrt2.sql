--Вывести запчасти определенного бренда

select product_name from brand
join
(select brand_id, product_name from listing
where listing_type = 'PART') avaliable on brand_id = brand.id
--where brand.name = ''
order by brand_id