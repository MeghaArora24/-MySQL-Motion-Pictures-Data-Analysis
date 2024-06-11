Use sakila;

/* Task 1: Display the first names, last names, actor IDs and the details of the last updated column of all the 
actors in the movie collection*/
Select first_name, last_name, actor_id, last_update from actor;
-- Interpretation: There are 200 actors in the movie collection. 

-- Task 2(a): Display the full Names of all the actors.
 Select concat(first_name, ' ', last_name) as full_name from actor;
 -- Interpretation: There are 200 actors in the movie collection. 

-- Task 2(b): Display the first names of actors along with the count of repeated first names. 
Select first_name, count(*) as count_of_name from actor group by first_name order by count_of_name desc;
-- Interpretation: There are 3 first names which have repeated 4 times. The names are Penelope, Julia and Kenneth. 

-- Task 2(c): Display the last names of actors along with the count of repeated last names.
Select last_name, count(*) as count_of_name from actor group by last_name order by count_of_name desc;
-- Interpretation: There is 1 last name which has repeated 5 times that is Kilmer. 

-- Task 3: Display the count of movies grouped by the ratings. 
Select rating, count(*) as count_of_movies from film group by rating order by count_of_movies desc;
-- Interpretation: PG-13 rating has highest count of movies. 

-- Task 4: Calculate and display the average rental rates based on the movie ratings. 
Select rating, avg(rental_rate) as average_rental_rates from film group by rating order by average_rental_rates desc;
-- Interpretation: PG  rating has highest average rental rate.

-- Task 5(a): Display the movie titles where the replacement cost is up to $9. 
Select title from film where replacement_cost <= 9;
-- Interpretation: There is no film where replacement cost is less than or equal to 9. 

-- Task 5(b): Display the movie titles where the replacement cost is between $ 15 and $ 20. 
Select title from film where replacement_cost between 15 and 20;
-- Interpretation: There are 214 films where replacement cost is between $ 15 and $20.

-- Task 5(c): Display the movie titles with the highest replacement cost and the lowest rental cost. 
Select title,replacement_cost from film where replacement_cost = 
(Select max(replacement_cost) from film);
-- Interpretation: There are 53 movies which have maximum replacement cost that is 29.99.

Select title, rental_rate from film where rental_rate = 
(Select min(rental_rate) from film);
-- Interpretation: There are 341 movies which have minimum rental rate that is 0.99. 

-- Task 6: Display the list of all the movies along with the number of actors listed for each movie. 
Select * from film;
Select * from film_actor;
Select film.title, count(film_actor.actor_id) as number_of_actors from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.film_id, film.title
order by film.title;
-- Interpretation: There are 997 movies. 

-- Task 7: Display the movie titles starting with the letters 'K' and 'Q'. 
Select title from film where title like'K%' or title like'Q%' order by title;
-- Interpretation: There are 15 movie titles starting with the letters 'K' and 'Q'. 

-- Task 8: Display the first names and last names of all the actors who are a part of movie ' Agent Truman'. 
Select * from actor;
Select * from film_actor;
Select * from film;
Select actor.first_name, actor.last_name from actor 
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
where film.title = 'Agent Truman';
-- Interpretation: There are 7 actors who are a part of movie ' Agent Truman'. 

-- Task 9: The management wants to promote movies that falls under the 'Children' category. Identify and display the names of movies in the family category.
Select * from category;
Select * from film;
Select * from film_category;
Select film.title, category.name from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.name = 'Family' or category.name = 'Children';
-- Interpretation: There are 129 movies under this category. 

-- Task 10: Display the names of most frequently rented movies in descending order. 
Select * from film;
Select * from rental;
Select * from inventory;
Select film.title, count(rental.rental_id) as count_of_rental from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id, film.title order by count_of_rental desc;
-- Interpretation: The most frequently rented movie is BUCKET BROTHERHOOD. 

/*Task 11: Calculate and display the number of movie categories where average difference between the movie replacement cost and the 
rental rate is greater than $15*/
Select * from category;
Select * from film_category;
Select * from film;
Select * from inventory;
Select count(*) as count_of_category from
(Select category.name from category 
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by category.category_id having avg(film.replacement_cost - film.rental_rate) > 15) as categories;
-- Interpretation: There are 16 movie categories. 

-- Task 12: Display the name of categories/genres and number of movies per category/genre, sorted by number of movies.  
Select * from category;
Select * from film_category;
Select category.name as category_name, count(film_category.film_id) AS number_of_movies from category
inner join film_category on category.category_id = film_category.category_id
group by category.category_id, category.name order by number_of_movies desc;
-- Interpretation: Sports genre has the highest number of movies. 