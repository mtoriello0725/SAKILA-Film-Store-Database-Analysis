SET SQL_SAFE_UPDATES = 0;
USE sakila;

-- 1a
/*
SELECT first_name, last_name FROM actor;
*/
-- 1b
/*
ALTER TABLE actor
ADD Actor_Name VARCHAR(100);
UPDATE actor
SET Actor_Name = CONCAT(first_name, " ", last_name);
SELECT * FROM actor;
*/

---

-- 2a
/*
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "JOE";
*/

-- 2b
/*
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE "%GEN%";
*/

-- 2c
/*
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;
*/

-- 2d
/*
SELECT country_id, country FROM country
WHERE country.country IN ("Afghanistan", "Bangladesh", "China");
*/

---

-- 3a
/*
ALTER TABLE actor
ADD description BLOB(700);
SELECT * FROM actor;
*/

-- 3b
/*
ALTER TABLE actor
DROP description;
SELECT * FROM actor;
*/

---

-- 4a
/*
SELECT last_name, COUNT(*) AS number_of_actors FROM actor
GROUP BY last_name;
*/
-- 4b
/*
SELECT last_name, COUNT(*) AS number_of_actors FROM actor
GROUP BY last_name
HAVING number_of_actors > 1;
*/

-- 4c
/*
UPDATE actor
SET first_name = "Harpo"
WHERE first_name = "Groucho" AND last_name = "Williams";

SELECT * FROM actor
WHERE first_name = "Harpo";
*/

-- 4d
/*
UPDATE actor
SET first_name = "Groucho"
WHERE first_name = "Harpo";
*/

---

-- 5a

/*
SHOW CREATE TABLE address;
*/

---

-- 6a
/*
SELECT staff.first_name, staff.last_name, address.address FROM staff
INNER JOIN address ON staff.address_id = address.address_id;
*/

-- 6b
/*
SELECT payment.staff_id, staff.first_name, staff.last_name, SUM(payment.amount) AS Gross FROM payment
INNER JOIN staff ON (payment.staff_id = staff.staff_id)
WHERE MONTH(payment_date) = 8 AND YEAR(payment_date) = 2005
GROUP BY payment.staff_id;
*/

-- 6c
/*
SELECT film_actor.film_id, film.title, COUNT(*) AS number_of_actors FROM film_actor
INNER JOIN film ON (film_actor.film_id = film.film_id)
GROUP BY film_id;
*/

-- 6d
/*
SELECT inventory.film_id, film.title, COUNT(*) AS Number_of_Copies FROM inventory
INNER JOIN film ON (inventory.film_id = film.film_id)
WHERE film.title = "Hunchback Impossible";
*/

-- 6e
/*
SELECT payment.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS Total_Paid FROM payment
INNER JOIN customer ON (payment.customer_id = customer.customer_id)
GROUP BY customer_id
ORDER BY customer.last_name, customer.first_name;
*/

---

-- 7a
/*
SELECT * FROM film
WHERE (title LIKE "K%" OR title LIKE "Q%")
AND language_id = (
	SELECT language_id FROM language
    WHERE name = "English"
    );
*/

-- 7b
/*
SELECT first_name, last_name FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
	WHERE film_id = (
		SELECT film_id FROM film
		WHERE title = "Alone Trip"
        )
	);
*/

-- 7c
/*
SELECT first_name, last_name, email FROM customer
JOIN address ON (customer.address_id = address.address_id)
JOIN city ON (address.city_id = city.city_id)
JOIN country ON (city.country_id = country.country_id)
WHERE country = "Canada";
*/

-- 7d
/*
SELECT * FROM film
WHERE film_id IN (
	SELECT film_id FROM film_category
    WHERE category_id IN (
		SELECT category_id FROM category
        WHERE name = "Family"
        )
	);
*/

-- 7e
/*
SELECT film.title, COUNT(film.title) AS rental_count FROM rental
JOIN inventory ON (rental.inventory_id = inventory.inventory_id)
JOIN film ON (inventory.film_id = film.film_id)
GROUP BY film.title
ORDER BY rental_count DESC;
*/

-- 7f
/*
SELECT customer.store_id, SUM(amount) AS Total_spent FROM payment
JOIN customer ON (payment.customer_id = customer.customer_id)
GROUP BY customer.store_id;
*/

-- 7g
/*
SELECT store.store_id, city.city, country.country FROM store
JOIN address ON (store.address_id = address.address_id)
JOIN city ON (address.city_id = city.city_id)
JOIN country ON (city.country_id = country.country_id);
*/

-- 7h
-- payment -> rental -> inventory -> film_category -> category

/*
SELECT category.name, SUM(payment.amount) AS Total_Revenue FROM payment
JOIN rental ON (payment.rental_id = rental.rental_id)
JOIN inventory ON (rental.inventory_id = inventory.inventory_id)
JOIN film_category ON (inventory.film_id = film_category.film_id)
JOIN category ON (film_category.category_id = category.category_id)
GROUP BY category.name
ORDER BY Total_Revenue DESC
Limit 5;
*/

---

-- 8a
/*
CREATE VIEW Top_5_Categories AS
SELECT category.name, SUM(payment.amount) AS Total_Revenue FROM payment
JOIN rental ON (payment.rental_id = rental.rental_id)
JOIN inventory ON (rental.inventory_id = inventory.inventory_id)
JOIN film_category ON (inventory.film_id = film_category.film_id)
JOIN category ON (film_category.category_id = category.category_id)
GROUP BY category.name
ORDER BY Total_Revenue DESC
Limit 5;
*/

-- 8b
/*
SELECT * FROM Top_5_Categories;
*/

-- 8c
/*
DROP VIEW Top_5_Categories;
*/


