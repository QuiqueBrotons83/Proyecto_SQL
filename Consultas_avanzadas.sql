-- 1. **ID extremos:**
- Encuentra el ID del actor más bajo y más alto.

select 
	min(actor_id) as "id bajo",
	max(actor_id) as "id alto"
from actor a;

-- 2. **Conteo total de actores:**
- Cuenta cuántos actores hay en la tabla `actor.

select 
	count(distinct(first_name)) as total_actores
from actor a;
-- 3. **Ordenación por apellido:**
- Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select * 
from actor a 
order by a.last_name asc;

-- 4. **Películas iniciales:**
- Selecciona las primeras 5 películas de la tabla `film`.

select *
from film f 
limit 5;
-- 5. **Agrupación por nombres:**
- Agrupa los actores por nombre y cuenta cuántos tienen el mismo nombre.

select 
	first_name as "Nombres_actor",
	count(first_name) as "Nombres_iguales"
from actor a 
group by first_name 
order by a.first_name  desc;

-- 6. **Alquileres y clientes:**
- Encuentra todos los alquileres y los nombres de los clientes que los realizaron.


select 
	concat(c.first_name, ' ', c.last_name) as "Cliente",
	f.title as "Alquileres"
from customer c 
	inner join rental r on c.customer_id = r.customer_id 
	inner join inventory i on r.inventory_id = i.inventory_id 
	inner join film f on i.film_id = f.film_id ;

-- 7. **Relación cliente-alquiler:**
- Muestra todos los clientes y sus alquileres, incluyendo los que no tienen.

select 
	concat(c.first_name, ' ', c.last_name) as "Cliente",
	f.title as "Alquileres"
from customer c 
	left join rental r on c.customer_id = r.rental_id
	left join inventory i on r.inventory_id = i.inventory_id 
	left join film f on i.film_id = f.film_id;

-- 8. **CROSS JOIN:**
-- Realiza un CROSS JOIN entre las tablas `film` y `category`. Analiza su valor.

	
	with cte_film_id_cat_id as (
	select *
	from film f 
		left join film_category fc on f.film_id = fc.film_id 
)
select * 
from cte_film_id_cat_id 
	cross join category;

-- 9. **Actores en categorías específicas:**
- Encuentra los actores que han participado en películas de la categoría ‘Action’.

select 
	concat(a.first_name, ' ', a.last_name) as "Actor",
	c."name" as "Categoria",
	f.title as "Pelicula"
from actor a 
	inner join film_actor fa on a.actor_id = fa.actor_id
	inner join film f on fa.film_id = f.film_id 
	inner join film_category fc on f.film_id = fc.film_id 
	inner join category c on fc.category_id = c.category_id 
where c."name" in ('Action');

-- 10. **Actores sin películas:**
- Encuentra todos los actores que no han participado en películas.

select *
from actor a 
	left join film_actor fa on a.actor_id = fa.actor_id
	left join film f on fa.film_id = f.film_id
where f.title = null;

-- Esta vacio significa que todos los actores han participado en alguna pelicula.


-- 11. **Crear vistas:**
- Crea una vista llamada `actor_num_peliculas` que muestre los nombres de los actores y el número de películas en las que han actuado.

create view "actor_num_peliculas" as 
select 
	concat(a.first_name, ' ', a.last_name) as "Actor",
	count(film_id) as "Total_peliculas"
from film_actor fa
	inner join actor a on fa.actor_id = a.actor_id
group by  concat(a.first_name, ' ', a.last_name) ;
-- Realizamos una comprobación que se ha creado correctamente la vista:

select * from actor_num_peliculas 
order by 2 desc;
