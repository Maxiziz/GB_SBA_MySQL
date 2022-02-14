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

-- Список пользователей младше 14
SELECT user_id, TIMESTAMPDIFF(YEAR, birthday, NOW()) as AGE FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <=14 ORDER BY AGE DESC;

SELECT count(*) as TOTAL_LIKES_QTY from likes where media_id IN 
(SELECT id FROM media WHERE user_id IN
(SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <=14));


-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

-- ОПРЕДЕЛИМ, КТО СКОЛЬКО ПОСТАВИЛ ЛАЙКОВ
-- Вариант 1, который от меня ждут, через UNION
SELECT 'MALE' as GENDER, COUNT(*) LIKES_QTY FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='m')
UNION 
SELECT 'FEMALE' as GENDER, COUNT(*) LIKES_QTY FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='f')
;

-- Вариант 2, через JOIN
SELECT 
CASE (p.gender)
	WHEN 'm' THEN 'MALE'
	WHEN 'f' THEN 'FEMALE'
	END AS GENDER,
COUNT(*)
from likes l
LEFT JOIN profiles p ON l.user_id=p.user_id
GROUP BY gender;

-- ТЕПЕРЬ ВЫВЕДЕМ ПРОСТО ОТВЕТ
-- Варинант 1-1. Через IF
SELECT IF(
(SELECT COUNT(*) FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='m')
)
>
(SELECT COUNT(*) FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='f')
),'Мужчины','Женщины');

-- Вариант 1-2. Через MAX после UNION
SELECT ANY_VALUE(GENDER) GENDER, MAX(LIKES_QTY) from 
(SELECT 'MALE' as GENDER, COUNT(*) LIKES_QTY FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='m')
UNION 
SELECT 'FEMALE' as GENDER, COUNT(*) LIKES_QTY FROM likes WHERE user_id IN
(SELECT user_id from profiles where gender='f')) as A1;

-- Вариант 2. Через MAX после JOIN
SELECT GENDER FROM
(SELECT 
CASE (p.gender)
	WHEN 'm' THEN 'MALE'
	WHEN 'f' THEN 'FEMALE'
	END AS GENDER,
COUNT(*) LIKES_QTY
from likes l
LEFT JOIN profiles p ON l.user_id=p.user_id
GROUP BY gender) AS T2 
WHERE LIKES_QTY =
(SELECT MAX(LIKES_QTY) FROM
(SELECT 
CASE (p.gender)
	WHEN 'm' THEN 'MALE'
	WHEN 'f' THEN 'FEMALE'
	END AS GENDER,
COUNT(*) LIKES_QTY
from likes l
LEFT JOIN profiles p ON l.user_id=p.user_id
GROUP BY gender) AS T2);
