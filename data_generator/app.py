import decimal
import math
import os
import random
import sys
import uuid
from datetime import datetime, timedelta

import psycopg2
from faker import Faker

print("AAAAAAAAAAAAAa")

amount = int(os.getenv('FAKER_QTY'))
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

fake = Faker(locale='ru_RU')
Faker.seed(0)
max_decimal_value = decimal.Decimal('Infinity')
max_elements_selected = 1000


def get_random_listing_status():
    return random.choice(["SOLD", "AVAILABLE", "RESERVED"])


def get_random_listing_type():
    return random.choice(["DEFAULT_LISTING", "CAR", "PART", "SERVICE"])


ids = []

shops_ids = []
listing_ids = []
chat_ids = []

cursor = connection.cursor()


def get_random_id_from_ids():
    return random.choice(ids)

def get_random_shop_id_from_ids():
    return random.choice(shops_ids)
def get_random_listing_id_from_ids():
    return random.choice(listing_ids)

def get_random_chat_id():
    return random.choice(chat_ids)

def check_exists(table_name):
    return True
    #cursor.execute("select exists(select * from information_schema.tables where table_name=%s)", (table_name,))
    #return cursor.fetchone()[0]

def fake_author(pos):
    if not check_exists('author'):
        return
    cursor.execute(
        f"""INSERT INTO public.author (id, name, phone, tg_link, role) 
        VALUES (%s, %s, %s, %s, %s)
         ON CONFLICT DO NOTHING;""", (ids[pos], fake.first_name(), fake.phone_number(), fake.user_name(), "user"))


def fake_ad(pos):
    if not check_exists("advertisment"):
        return
    cursor.execute("""INSERT INTO public.advertisment (id, description, additional_info)
VALUES (%s, %s, %s) ON CONFLICT DO NOTHING;""", (ids[pos], fake.text(max_nb_chars=200), fake.text(max_nb_chars=200)))


def fake_brand(pos):
    if not check_exists("brand"):
        return
    cursor.execute("""INSERT INTO public.brand (id, name)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (ids[pos], fake.text(max_nb_chars=200)))


def fake_category(pos):
    if not check_exists("category"):
        return
    cursor.execute("""INSERT INTO public.category (id, name)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (ids[pos], fake.text(max_nb_chars=200)))


def fake_chat(pos):
    if not check_exists("chat"):
        return
    cursor.execute("""INSERT INTO public.chat (id, is_opened)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (ids[pos], fake.boolean()))


def fake_listing(pos):
    if not check_exists("listing"):
        return
    cursor.execute("""INSERT INTO public.listing 
    (id, product_name, listing_status, price,
     amount, description, wholesale_price, listing_type,
      location, author_id, advertisment_id, brand_id, 
      chat_id, tg_id)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) ON CONFLICT DO NOTHING;""", (
        ids[pos], fake.text(max_nb_chars=200), get_random_listing_status(), fake.random_int(),
        fake.random_int(), fake.text(max_nb_chars=200), fake.random_int(), get_random_listing_type(), fake.text(max_nb_chars=200),
        get_random_id_from_ids(), get_random_id_from_ids(), get_random_id_from_ids(),
        get_random_id_from_ids(), fake.random_int()))


def fake_photo(pos):
    if not check_exists("photo"):
        return
    cursor.execute("""INSERT INTO public.photo (id, listing_id, photo)
VALUES (%s, %s, %s)ON CONFLICT DO NOTHING;""", (ids[pos], get_random_listing_id_from_ids(), fake.binary(100)))


def fake_shop(pos):
    if not check_exists("shop"):
        return
    cursor.execute("""INSERT INTO public.shop (id, name, description, owner_id)
VALUES (%s, %s, %s, %s) ON CONFLICT DO NOTHING;""",
                   (ids[pos], fake.text(max_nb_chars=250), fake.text(max_nb_chars=200), get_random_id_from_ids()))


def fake_visitor():
    if not check_exists("visitor"):
        return
    cursor.execute("""INSERT INTO public.visitor (author_id, listing_id, date)
VALUES (%s, %s, %s) ON CONFLICT DO NOTHING;""", (get_random_id_from_ids(), get_random_listing_id_from_ids(), fake.date()))


def fake_listing_category():
    if not check_exists("listing_category"):
        return
    cursor.execute("""INSERT INTO public.listing_category (category_id, listing_id)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (get_random_id_from_ids(), get_random_listing_id_from_ids()))


def fake_favourite():
    if not check_exists("favourite"):
        return
    cursor.execute("""INSERT INTO public.favourite (author_id, listing_id)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (get_random_id_from_ids(), get_random_listing_id_from_ids()))


def fake_message():
    if not check_exists("chatmessage"):
        return
    cursor.execute("""INSERT INTO public.chatmessage (id, author_id, chat_id, text)
VALUES (%s, %s, %s, %s) ON CONFLICT DO NOTHING;""", (
        get_random_id_from_ids(), get_random_id_from_ids(), get_random_chat_id(), fake.text(max_nb_chars=200)))


def fake_author_shop(id):
    if not check_exists("author_shop"):
        return
    cursor.execute("""INSERT INTO public.author_shop (author_id, shop_id)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (ids[id], get_random_shop_id_from_ids()))


def fake_author_chat():
    if not check_exists("author_chat"):
        return
    cursor.execute("""INSERT INTO public.author_chat (author_id, chat_id)
VALUES (%s, %s) ON CONFLICT DO NOTHING;""", (get_random_id_from_ids(), get_random_id_from_ids()))

#
# for _ in range(amount):
#     ids.append(fake.uuid4())
cursor.execute("""SELECT id FROM public.author""")

ids = cursor.fetchall()

cursor.execute("""SELECT id FROM public.chat""")

chat_ids = cursor.fetchall()


# for i in range(amount):
#     fake_author(i)
#     fake_category(i)
#     fake_chat(i)
#     fake_ad(i)
#     fake_brand(i)
#     if i % 10000 == 0:
#         print(i)
#         connection.commit()
#
for i in range(amount):
    # fake_listing(i)
    #fake_shop(i)

    if i % 10000 == 0:
        print(f"2 - {i}")
        connection.commit()

for i in range(amount):
    # fake_photo(i)
    fake_message()
    # fake_favourite()
    # fake_visitor()
    # fake_listing_category()
    # fake_author_chat()
    #fake_author_shop(i)


    if i % 10000 == 0:
        print(f"3 - {i}")
        connection.commit()

connection.commit()