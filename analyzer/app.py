import decimal
import math
import os
import random
import re
import sys
import uuid
from datetime import datetime, timedelta

import psycopg2

print("AAAAAAAAAAAAAa")

amount = int(os.getenv('ANALYZE_QTY'))
time_to_connect = 30

time = datetime.now()
success = False
while not success:
    try:
        connection = psycopg2.connect(
            host=os.getenv('DB_HOST'),
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USERNAME"),
            password=os.getenv("DB_PASSWORD"),
            port=os.getenv("DB_PORT"),
        )
        success = True

        print("successfully")
    except:
        print("exc")
        success = False
    if datetime.now() - time > timedelta(seconds=time_to_connect):
        print("long time")
        sys.exit(-1)

print("Connected successfully")

cursor = connection.cursor()


class Costs:
    def __init__(self, name, query):
        self.costs = []
        self.name = name
        self.query = query

    def get_costs(self):
        return f"Request:{self.name}\nMinimal cost:{min(self.costs)}\nAverage cost:{sum(self.costs) / amount}\nMaximal cost:{max(self.costs)}\n"

    def analyse(self):
        for _ in range(amount):
            cursor.execute(f"EXPLAIN ANALYZE {self.query}")
            result = cursor.fetchall()
            self.costs.append(float(re.search(r'cost=([0-9]+\.[0-9]+)\.\.([0-9]+\.[0-9]+)', result[0][0]).group(2)))


request1 = Costs("Вывести топ 5 магазинов по кол-ву продаж.",
                """select author_shop.shop_id, SUM(author_sold) as shop_sold
from author_shop
join (
select author_id as listing_author, SUM(listing.amount) as author_sold
from listing
where listing_status = 'SOLD'
GROUP BY author_id
) lst on lst.listing_author = author_shop.author_id
group by author_shop.shop_id
order by shop_sold desc
limit 5;""")

request2 = Costs("Вывести запчасти определенного бренда","""select product_name from brand
join
(select brand_id, product_name from listing
where listing_type = 'PART') avaliable on brand_id = brand.id
order by brand_id""")

request3 = Costs("Вывести все чаты и их последнее сообщение",
                 """
                 select latest.chat_id, text, author_id
from chatmessage
join (select chat_id, max(sent) as maxtime from chatmessage
group by chat_id) latest on latest.chat_id = chatmessage.chat_id and sent = latest.maxtime""")

request1.analyse()
request2.analyse()
request3.analyse()

filepath = f"/src/ANALYZER_{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.txt"
with open(filepath, 'w') as file:
    file.write(request1.get_costs())
    file.write(request2.get_costs())
    file.write(request3.get_costs())

print("Done")
