use vk;


-- 1. Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT from_user_id, to_user_id, count(*) FROM messages  GROUP BY from_user_id, to_user_id ORDER BY 3 DESC;
-- посмотреть, кто с кем больше всего общался

SET @user_to=96; -- задается пользователь

SELECT * FROM messages  WHERE to_user_id = @user_to; -- посмотреть все сообщения ему

-- Вариант с LIMIT 1
SELECT from_user_id, to_user_id, count(*) `MSG_QTY` FROM messages GROUP BY from_user_id, to_user_id ORDER BY 3 DESC LIMIT 1;
-- Но что, если несколько строк с максимальным кол-вом?
-- Определим само глобально максимальное количество сообщений в диалоге
SELECT MAX(MSG_QTY) FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats);

-- Определим само максимальное количество сообщений в диалоге к заданному пользователю 
SELECT MAX(MSG_QTY) FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages WHERE to_user_id=@user_to GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats);

-- Выведем все диалоги системы с глобально максимальным количеством
SELECT * FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats)
WHERE MSG_QTY=(SELECT MAX(MSG_QTY) FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats));

-- Выведем все диалоги системы с максимальным количеством сообщений к заданному(@user_to) пользователю
SELECT * FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages WHERE to_user_id=@user_to GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats)
WHERE MSG_QTY=(SELECT MAX(MSG_QTY) FROM ((SELECT from_user_id, to_user_id, count(*) MSG_QTY FROM messages WHERE to_user_id=@user_to GROUP BY from_user_id, to_user_id ORDER BY 3 DESC) as msg_stats));


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- Вообще, в базе нет пользователей младше 14. Поэтому сделаю <=14
SELECT user_id, TIMESTAMPDIFF(YEAR, birthday, NOW()) as AGE FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <=14 ORDER BY AGE DESC;

SELECT 
((SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <=14) as user_ids);
