# Proyecto SQL - Análisis de Alquileres de Películas

## Descripción

Este proyecto tiene como objetivo analizar una base de datos relacionada con el sistema de alquiler de películas, proporcionando consultas SQL para obtener métricas clave sobre clientes, películas, actores, alquileres, y categorías. El análisis incluye el uso de **tablas temporales**, **funciones de agregación** y **joins** entre tablas para extraer información valiosa.

## Estructura de la Base de Datos

Las siguientes tablas son relevantes para este análisis:

- **customer**: Información de los clientes.
- **film**: Detalles sobre las películas.
- **rental**: Información sobre los alquileres realizados por los clientes.
- **actor**: Información sobre los actores que participan en las películas.
- **category**: Categorías de películas (por ejemplo, `Sci-Fi`, `Action`).
- **payment**: Detalles sobre los pagos realizados por los clientes.

## Consultas Realizadas

A continuación se muestran las principales consultas SQL realizadas en este proyecto:

### 1. **Clientes con más de 40 Alquileres**
   - Consulta que devuelve los actores que han participado en más de 40 películas.

   ```sql
   SELECT 
       a.actor_id, 
       CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo
   FROM actor a
   JOIN film_actor fa ON a.actor_id = fa.actor_id
   GROUP BY a.actor_id
   HAVING COUNT(fa.film_id) > 40;
.

