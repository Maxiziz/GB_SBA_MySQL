USE vk;

DROP TABLE IF EXISTS community_media;
CREATE TABLE community_media(
	media_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (media_id,community_id),
	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (community_id) REFERENCES communities(id)
) COMMENT 'Медиа сообществ';
-- Как лучшая альтернатива, можно добавить поле community_id в таблицу media и допустить нулевое значение, в т.ч. по дефолту
/*
ALTER TABLE media
ADD community_id BIGINT UNSIGNED DEFAULT NULL,
FOREIGN KEY (community_id) REFERENCES communities(id);
*/
-- Ещё бы Таблицу photos переименовать в media_album, т.к. она создана, чтобы устанавливать связь между медиа и албомом(ами), а в альбомы могут размещаться media разных types, например, видеозаписи.

DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
	id SERIAL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
    created_at DATETIME DEFAULT NOW(),
	
    FOREIGN KEY (to_user_id) REFERENCES users(id)
    -- По индексу пока не понятно, body не рекомендуется, а по чему ещё могут искать, по юзеру.. лучше мере выявления потребностей
); 

-- Как альтернатива - использовать таблицу messages со спец отправителем, например id(1), но лучше выводить уведомления в отдельный модуль, чтобы они не путались с диалогами.

/*DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
-- Не, это равносильно likes. Третьего не придумал)
*/