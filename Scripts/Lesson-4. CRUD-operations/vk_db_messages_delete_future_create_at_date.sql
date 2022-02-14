use vk;

-- Так как created_at был одинаоквый, рандомизирумем его в пределах года.
UPDATE messages set created_at = CURRENT_DATE - INTERVAL FLOOR(RAND() * 365) DAY;

-- Да на самом деле, это и исключает возможность сообщений из будущего. Но предназначение скрипта из ДЗ другое. Поэтому напишем его.

DELETE FROM messages where created_at > CURRENT_TIMESTAMP;
SELECT * FROM messages where created_at > CURRENT_TIMESTAMP; -- смотрим, что всё удалено, таких не осталось.

-- На самом деле, исключил даты из будущего я в таблице profiles (поле birtday). см. скрипт vk_db_profiles_update_age_inactive.