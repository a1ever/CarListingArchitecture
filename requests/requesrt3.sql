--Вывести все чаты и их последнее сообщение

select latest.chat_id, text, author_id
from chatmessage
join (select chat_id, max(sent) as maxtime from chatmessage
group by chat_id) latest on latest.chat_id = chatmessage.chat_id and sent = latest.maxtime