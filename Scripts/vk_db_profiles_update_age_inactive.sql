use vk;

ALTER TABLE profiles ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT '1';

-- Даты рождения из сгенерированных данных были в т.ч. из будущего. Поменяем их возрастом от 14 до 80 лет. 
UPDATE profiles set birthday = CURRENT_DATE - INTERVAL FLOOR(5110 + RAND() * 24090) DAY;

-- Посмотрим таких ребят.
SELECT user_id, birthday from profiles p where birthday > '2004-01-17';
SELECT user_id, birthday, CURRENT_DATE, (YEAR(CURRENT_DATE)-YEAR(birthday)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)) AS age FROM profiles p WHERE ((YEAR(CURRENT_DATE)-YEAR(birthday)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)))<18;

-- А  теперь к самому заданию. Несовершеннолетних пользователей поменяем неактивными.
UPDATE profiles set is_active = '0' WHERE ((YEAR(CURRENT_DATE)-YEAR(birthday)) - (RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)))<18;