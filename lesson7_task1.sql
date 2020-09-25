CREATE DATABASE selers;
use selers;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name CHAR (120),
	buy_total INT UNSIGNED,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `goods`;
CREATE TABLE goods (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_good CHAR (255),
	price INT UNSIGNED,
	quantity INT UNSIGNED,
	id_catalog INT UNSIGNED,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
	);

DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- номер оперции
	id_users INT UNSIGNED, -- кто купил
	id_goods INT UNSIGNED, -- что купил
	volume INT UNSIGNED, -- сколько купил
	paid INT UNSIGNED, -- -- сколько заплачено
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


INSERT INTO users (name, buy_total) VALUES
( 'Petr', 0),
( 'Oskar', 0),
( 'Mariya', 0);

INSERT INTO users (name, buy_total) VALUES
( 'Natalya', 0);

SELECT * FROM users;



TRUNCATE goods; 
INSERT INTO goods
	(name_good, price, quantity, id_catalog)
	VALUES
	('stul', 25, 100, 1),
 	('stol', 54, 20, 1),
 	('Lampa', 10, 200, 1),
	('Kreslo', 76, 59, 1),
	('bumaga500', 3, 480, 2),
	('karandash', 1, 260, 2);

CREATE TABLE catalogs(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- номер оперции
	name_catalog char(255),
-- 	id_users INT UNSIGNED, -- кто купил
-- 	id_goods INT UNSIGNED, -- что купил
-- 	volume INT UNSIGNED, -- сколько купил
-- 	paid INT UNSIGNED, -- -- сколько заплачено
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO catalogs
	(name_catalog)
	VALUES
	('mebel'),
	('kanctovary');

INSERT INTO 
	orders (id_users, id_goods, volume)
	VALUES
	(1, 2, 2),
	(1, 3, 2),
	(3, 2, 1),
	(1, 1, 10),
	(2, 5, 3),
	(2, 6, 10),
	(3, 4, 2);

-- 1. Составьте список пользователей users, которые осуществили хотя бы один
-- заказ orders в интернет магазине.
SELECT 
	(SELECT name 
		FROM users 
			WHERE orders.id_users = users.id) AS 'name',
-- 	id_goods,
	(SELECT name_good
 		FROM goods
 			WHERE orders.id_goods = goods.id) AS 'goods',
	(SELECT price
 		FROM goods
 			WHERE orders.id_goods = goods.id) AS 'price'
	FROM orders;

SELECT DISTINCT
	u.id,
	u.name
	FROM users AS u
	JOIN orders AS o
	ON u.id = o.id_users ;

 SELECT id, name_good
		FROM goods;
-- 			WHERE orders.id_goods = goods.id AS 'goods';

-- 2. Выведите список товаров products и разделов catalogs, который соответствует
-- товару.

SELECT 
	g.name_good,
	g.price,
	g.quantity,
	c.name_catalog AS catalogs
-- 	(SELECT name_catalog 
-- 		FROM catalogs
-- 			WHERE goods.id_catalog = catalogs.id) as 'Razdel cataloga'
-- 	FROM goods;
	FROM goods AS g
    LEFT JOIN catalogs AS c
      ON g.id_catalog = c.id;

