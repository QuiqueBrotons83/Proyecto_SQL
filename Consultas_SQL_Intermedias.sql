-- ### **Sección 2: Consultas Intermedias**

-- 1. **Selección única:**
- Selecciona todos los nombres únicos de películas.

select distinct f.title 
from film f;

-- 2. **Filtros combinados con duración:**
- Encuentra las películas que son comedias y tienen una duración mayor a 180 minutos.

select f.title, f.length  
from film f 
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id 
where c.name = 'Comedy' and f.length> 180;

-- 3. Promedio por categoría:
-Encuentra las categorías de películas con un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio.

select c.name, avg(f.length)
from film f
join category c on f.film_id = c.category_id
group by c.name
having avg(f.length) > 110;

-- 4. **Duración media de alquiler:**
- ¿Cuál es la media de duración del alquiler de las películas?

select avg(return_date - rental_date) as media_duracion
from rental;
5. -- **Concatenación de nombres:**
- Crea una columna con el nombre completo (nombre y apellidos) de los actores y actrices.

select actor_id, first_name || ' ' || last_name as nombre_completo
from actor;
-- 6. **Conteo de alquileres por día:**
- Muestra los números de alquileres por día, ordenados de forma descendente.

select 
	count(date(rental_date)) as numero_alquileres,
	date(rental_date) as dia_alquiler
from rental 
group by dia_alquiler 
order by numero_alquileres desc;
-- 7. **Películas sobre el promedio:**
- Encuentra las películas con una duración superior al promedio.

select title, length
from film
where length > (select avg(length) from film);
-- 8. **Conteo mensual:**
- Averigua el número de alquileres registrados por mes.

select 
    to_char(rental_date, 'Month') as mes, 
    count(*) as total_alquileres
from rental
group by mes;
-- 9. **Estadísticas de pagos:**
- Encuentra el promedio, la desviación estándar y la varianza del total pagado.

select 
	avg(amount) as promedio,
	stddev(amount) as desviacion_estandar,
	variance(amount) as varianza
from payment;
-- 10. **Películas caras:**
- ¿Qué películas se alquilan por encima del precio medio?

select f.title, f.film_id
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
where p.amount > (select avg(amount) from payment);

-- 11. **Actores en muchas películas:**
- Muestra el ID de los actores que hayan participado en más de 40 películas.

select 
	a.actor_id,
	count(f.film_id) as total_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id 
group by a.actor_id
having count(f.film_id) > 40;
-- 12. **Disponibilidad en inventario:**
- Obtén todas las películas y, si están disponibles en el inventario, muestra la cantidad disponible.

select
	f.title as titulo,
	count(i.inventory_id) as cantidad_disponible
from film f
join inventory i on f.film_id = i.film_id
group by f.title;
-- 13. **Número de películas por actor:**
- Obtén los actores y el número de películas en las que han actuado.

select 
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	count(fa.film_id) as numero_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id;

-- 14. **Relaciones actor-película:**
- Obtén todas las películas con sus actores asociados, incluso si algunas no tienen actores.

select 
	 f.title as titulo, 
	 concat(a.first_name,' ', a.last_name) as nombre_actor
from film f
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id;

-- 15. **Clientes destacados:**
- Encuentra los 5 clientes que más dinero han gastado.

select 
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	sum(p.amount) as dinero_gastado
from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by dinero_gastado  desc
limit 5;

