--вывести тех кто посещал объявление (мб последний месяц)

select *
from visitor
where
    --date > now() - interval '30 day' and
    listing_id = (select listing_id
                  from (select listing_id, count(*) as cnt
                        from visitor
                        where date > now() - interval '30 day'
                        group by listing_id
                        order by cnt desc
                        limit 1))

-- объявление с максимальным количеством посещений за последние 30 дней