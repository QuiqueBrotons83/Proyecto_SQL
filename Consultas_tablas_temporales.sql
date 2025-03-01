### **Sección 4: Consultas con Tablas Temporales**

1. **Alquileres totales:**
    - Calcula el número total de alquileres realizados por cada cliente.
    
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo, 
    COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN  rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, nombre_completo
ORDER BY  total_alquileres DESC;
  
       
2. **Duración total por categoría:**
    - Calcula la duración total de las películas en la categoría `Action`.

SELECT 
    c.name AS categoria, 
    SUM(f.length) AS duracion_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE c.name = 'Action'
GROUP BY c.name;

    
3. **Clientes destacados:**
    - Encuentra los clientes que alquilaron al menos 7 películas distintas.

SELECT 
    c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo, 
    COUNT(DISTINCT f.film_id) AS peliculas_distintas
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, nombre_completo
HAVING COUNT(DISTINCT f.film_id) >= 7;


4. **Categorías destacadas:**
    - Encuentra la cantidad total de películas alquiladas por categoría.
    
SELECT
	c.name AS categoria,
	COUNT(r.rental_id) as total_alquileres
FROM category c 
JOIN film_category fc on c.category_id = fc.category_id
JOIN inventory i on fc.film_id = i.film_id
JOIN rental r on i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_alquileres DESC;
     
    
5. **Nuevas columnas:**
    - Renombra las columnas `first_name` como `Nombre` y `last_name` como `Apellido`.
    
SELECT 
	first_name as Nombre,
	last_name as Apellido
FROM customer c ; 
       
    
6. **Tablas temporales:**
- Crea una tabla temporal llamada `cliente_rentas_temporal` para almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE clientes_rentas_temporal AS

SELECT 
	customer_id,
	COUNT(rental_id) AS total_alquileres
FROM rental r 
GROUP BY customer_id;   


- Crea otra tabla temporal llamada `peliculas_alquiladas` para almacenar películas alquiladas al menos 10 veces.

CREATE TEMP TABLE peliculas_alquiladas AS 

SELECT 
    f.film_id, 
    f.title AS titulo, 
    COUNT(r.rental_id) AS total_alquilada
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

7. **Clientes frecuentes:**
    - Encuentra los nombres de los clientes que más gastaron y sus películas asociadas.
    
SELECT 
    c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo, 
    SUM(p.amount) AS total_gastado, 
    GROUP_CONCAT(DISTINCT f.title) AS peliculas_alquiladas
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, nombre_completo
ORDER BY total_gastado DESC
LIMIT 10;

    
8. **Actores en Sci-Fi:**
    - Encuentra los actores que actuaron en películas de la categoría `Sci-Fi`.
    
SELECT 
    a.actor_id, 
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo, 
    c.name AS categoria
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi';



[**Tipo Entrega DataProject: Lógica de Consultas SQL**](https://www.notion.so/Tipo-Entrega-DataProject-L-gica-de-Consultas-SQL-185e9a2935bd81b19558c476b30fdea6?pvs=21)