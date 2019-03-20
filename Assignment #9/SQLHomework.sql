Use sakila;
# 1a. Display the first and last names of all actors from the table `actor`.

Select first_name, last_name from actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

Select concat(first_name, " ", last_name) as 'Actor Name' from actor;-- 

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

Select actor_id, first_name, last_name from actor where first_name = "Joe"; 
-- * 2b. Find all actors whose last name contain the letters `GEN`:

Select first_name, last_name from actor where last_name like "%GEN%"

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

Select last_name, first_name from actor where last_name like "%LI%"; 

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China"); 

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
-- ALTER TABLE actor
ADD( description BLOB);

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
DROP COLUMN description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name,COUNT(*) as 'COUNT'
FROM actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name,COUNT(*) as 'COUNT'
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 2;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';


-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
UPDATE actor
SET
first_name = 'GROUCHO'
WHERE
first_name = 'HARPO';
select first_name, last_name from actor where first_name = "GROUCHO";


-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

--   * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

describe sakila.address;
-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select first_name, last_name, address from staff
join address on staff.address_id = address.address_id;

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT * from payment;
SELECT payment.staff_id, staff.first_name, staff.last_name, SUM(amount) as 'Total Payment'
FROM payment JOIN staff 
ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE '%2005-08%'
GROUP BY staff.staff_id;

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
Select * from film_actor;
Select film.title, Count(film_actor.actor_id) as 'Count of Actors'
from film INNER JOIN film_actor 
on film_actor.film_id = film.film_id
Group by film.film_id;

#### TO SEE NAMES OF COUNTS FOR FILM W MOST ACTORS 
select actor.first_name, actor.last_name from actor 
JOIN film_actor on film_actor.actor_id = actor.actor_id
JOIN film on film.film_id = film_actor.film_id 
Where film.title = "LAMBS CINCINATTI";

-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

#select * from inventory
SELECT film.title, COUNT(inventory.film_id)
FROM inventory
JOIN film ON film.film_id = inventory.film_id
WHERE film.title = "HUNCHBACK IMPOSSIBLE";

-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
select customer.last_name, sum(amount) 
from payment 
join customer on customer.customer_id = payment.customer_id
group by customer.last_name ASC;

-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
select * from language;
SELECT title, language.name from film 
JOIN language on language.language_id = film.language_id
where language.name = "English" and film.title like 'K%' or film.title like 'Q%'; 

-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
select actor.first_name, actor.last_name from actor 
JOIN film_actor on film_actor.actor_id = actor.actor_id
JOIN film on film.film_id = film_actor.film_id 
Where film.title = "ALONE TRIP";


-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select * from city; 
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
WHERE address_id IN
(
    SELECT address_id
   FROM address
   WHERE city_id IN
   (
        SELECT city_id
       FROM city
       WHERE country_id IN
       (
            SELECT country_id
           FROM country
           WHERE country = "Canada"
        )
    )
);


-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as _family_ films.

SELECT title, film_id
from film 
where film_id IN 
(
	select film_id 
    from film_category 
    where category_id in 
    (    
		select category_id 
		from category 
		where name = "Family"
	)
);


-- * 7e. Display the most frequently rented movies in descending order.

SELECT inventory.film_id, film_text.title, COUNT(rental.inventory_id)
FROM inventory 
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_text  ON inventory.film_id = film_text.film_id
GROUP BY rental.inventory_id
ORDER BY COUNT(rental.inventory_id) DESC;

-- * 7f. Write a query to display how much business, in dollars, each store brought in.
select store.store_id, sum(amount) 
from store 
inner join staff on staff.store_id = store.store_id
inner join payment on payment.staff_id = staff.staff_id
group by store.store_id
order by sum(amount);
	


-- * 7g. Write a query to display for each store its store ID, city, and country.

select store.store_id, city.city, country.country from store
inner join customer on store.store_id = customer.store_id
inner join staff on store.store_id = staff.store_id
inner join address on customer.address_id = address.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.city_id;

-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

select category.name, sum(payment.amount) from category 
inner join film_category on category.category_id = film_category.category_id 
inner join inventory on film_category.film_id = inventory.film_id 
inner join rental on inventory.inventory_id = rental.inventory_id 
inner join payment group by name limit 5;

-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

create view top5grossinggenres AS
select category.name, sum(payment.amount) from category 
inner join film_category on category.category_id = film_category.category_id 
inner join inventory on film_category.film_id = inventory.film_id 
inner join rental on inventory.inventory_id = rental.inventory_id 
inner join payment group by name limit 5;

-- * 8b. How would you display the view that you created in 8a?

select * from top5grossinggenres

-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

Drop view top5grossinggenres