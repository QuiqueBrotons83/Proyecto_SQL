
-- Ejercicio 1 
Peliculas con clasificación por edades 'R'

select title 
from film 
where rating = 'R';

-- Ejercicio 2
Actores con “actor_id” entre 30 y 40:

select first_name , last_name
from actor
where actor_id between 30 and 40;

-- Ejercicio 3 
Películas cuyo idioma coincide con el original:
SELECT title 
FROM film 
WHERE language_id = original_language_id;

-- Ejercicio 4 
Ordenar películas por duración ascendente:
select title,length
from film 
order by length asc;

-- Ejercicio 5
Actores cuyo apellido contiene ‘Allen’:

SELECT first_name, last_name 
FROM actor a  
WHERE last_name LIKE '%Allen%';


-- Ejercicio 6
Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

select 
rating, count(*) as cantidad 
from film f group by rating;

-- Ejercicio 7
Encuentra el título de todas las películas que son ‘PG13’ o tienen una duración mayor a 3 horas.

select title
from film
where rating = 'PG-13' or length > 180;

-- Ejercicio 8
Encuentra la variabilidad de lo que costaría reemplazar las películas.

select stddev(replacement_cost) as desviacion, 
variance(replacement_cost) as varianza 
from film;

-- 10. **Duraciones extremas:**
    - Encuentra la mayor y menor duración de una película en la base de datos.
select 
max(length) as duracion_maxima, 
min(length) as durascion_minima 
from film;

-- 11 **Costo del alquiler:**
    - Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select 
amount 
from
payment 
order by payment_date desc limit 1
offset 2;

-- 12  Exclusión de clasificaciones:

Encuentra el título de las películas que no sean ni ‘NC-17’ ni ‘G’ en cuanto a clasificación.

select f.title  
from film f 
where rating not in ('NC-17', 'G');

-- Promedio de duración por clasificación.
Encuentra el promedio de duración de las películas para cada clasificación y muestra la clasificación junto con el promedio.

select rating, 
avg(length) as duracion_promedio 
from film 
group by rating;


-- Películas con duración mayor a 180 minutos:
Encuentra el título de todas las películas con una duración mayor a 180 minutos.
select title, length
from film 
	where length > 180;

--15. **Ingresos totales:**
- ¿Cuánto dinero ha generado en total la empresa?
select sum(amount) as total_ingresos 
from payment;

-- 16. **Clientes con ID alto:**
- Muestra los 10 clientes con mayor valor de ID.
select
customer_id, first_name, last_name
from customer
order by customer_id desc limit 10;

-- 17. **Película específica:**
- Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select 
a.last_name , first_name,f.title
from actor a
 	join film_actor fa on fa.actor_id = a.actor_id 
 	join film f on f.film_id = fa.film_id 
where f."title" = 'EGG IGBY';




