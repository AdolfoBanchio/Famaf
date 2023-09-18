/*Cree una tabla de `directors` con las columnas: Nombre, Apellido, Número de Películas.*/
CREATE table directors (
	Nombre Varchar(255) not null,
	Apellido Varchar(255) not null,
	Num_peliculas int
);

SELECT * FROM directors ;
drop table directors ;
/* El top 5 de actrices y actores de la tabla `actors` que tienen la mayor experiencia 
 * (i.e. el mayor número de películas filmadas) son también directores de las películas en las que participaron. 
 * Basados en esta información, inserten, utilizando una subquery los valores correspondientes en la tabla `directors`.*/
with 
	mas_exp_actors AS
		(SELECT
			fa.actor_id AS Actor,
			COUNT(fa.film_id) AS Cantidad
		FROM
			film_actor AS fa
		GROUP BY
			fa.actor_id
		ORDER BY
			Cantidad DESC
		LIMIT 5
		)
		
INSERT INTO directors (Nombre,Apellido,Num_peliculas)
SELECT a.first_name , a.last_name , ma.Cantidad
FROM ((SELECT
			fa.actor_id AS Actor,
			COUNT(fa.film_id) AS Cantidad
		FROM
			film_actor AS fa
		GROUP BY
			fa.actor_id
		ORDER BY
			Cantidad DESC
		LIMIT 5
		)AS ma 
	  INNER JOIN actor AS a
	  ON ma.Actor=a.actor_id);
SELECT * from directors d ;

/*Agregue una columna `premium_customer` que tendrá un valor 'T' o 'F' de 
 * acuerdo a si el cliente es "premium" o no. Por defecto ningún cliente será premium.*/
ALTER TABLE customer
ADD premium_customer enum('T','F') NOT NULL DEFAULT 'F';

SELECT * FROM customer c ;
/*Modifique la tabla customer. Marque con 'T' en la columna `premium_customer` 
 * de los 10 clientes con mayor dinero gastado en la plataforma.*/
CREATE VIEW best_client AS 
	(SELECT c.customer_id AS Cliente , sum(p.amount) AS Gastado
	FROM (customer AS c INNER JOIN payment AS p
		  ON c.customer_id=p.customer_id)
	GROUP BY Cliente
	ORDER BY Gastado DESC
	LIMIT 10);
SELECT * from best_client bc;

UPDATE customer SET premium_customer = 'T'
WHERE customer.customer_id IN (SELECT Cliente FROM best_client);	

/*Listar, ordenados por cantidad de películas (de mayor a menor), los distintos ratings de las películas existentes 
 * (Hint: rating se refiere en este caso a la clasificación según edad: G, PG, R, etc).*/
SELECT rating, count(film_id) AS Cant
FROM film
GROUP BY rating
ORDER BY cant DESC; 


/*¿Cuáles fueron la primera y última fecha donde hubo pagos?*/
SELECT min(payment_date) AS primera_fecha , max(payment_date) AS ultima_fecha
FROM payment;

/*Calcule, por cada mes, el promedio de pagos (Hint: vea la manera de extraer el nombre del mes de una fecha).*/
SELECT month(payment_date) AS mes ,COUNT(payment_id) AS Cantidad_pagos
FROM payment
GROUP BY mes;

/*Listar los 10 distritos que tuvieron mayor cantidad de alquileres (con la cantidad total de alquileres).*/

/*Modifique la table `inventory_id` agregando una columna `stock` que sea un número entero y representa la cantidad de copias de una misma 
 * película que tiene determinada tienda. El número por defecto debería ser 5 copias.*/
ALTER TABLE inventory 
ADD stock int NOT NULL DEFAULT 5;
SELECT * from inventory i ;

select count(film_id) AS cantidad, store_id AS store, i.film_id 
from inventory i 
group by i.film_id,i.store_id  ;

INSERT INTO inventory (stock)
SELECT cantidad from (select count(film_id) AS cantidad, store_id AS store, i.film_id as Film
						from inventory i 
						group by i.film_id,i.store_id) AS aux
WHERE inventory.film_id =	aux.film and store=store_id ;
/*Cree un trigger `update_stock` que, cada vez que se agregue un nuevo registro a la tabla rental, haga un update en la tabla `inventory` restando una copia al stock de la película rentada (Hint: revisar que el rental no tiene información directa sobre la tienda, sino sobre el cliente, que está asociado a una tienda en particular).*/
/*Cree una tabla `fines` que tenga dos campos: `rental_id` y `amount`. El primero es una clave foránea a la tabla rental y el segundo es un valor numérico con dos decimales.*/
/*Cree un procedimiento `check_date_and_fine` que revise la tabla `rental` y cree un registro en la tabla `fines` por cada `rental` cuya devolución (return_date) haya tardado más de 3 días (comparación con rental_date). El valor de la multa será el número de días de retraso multiplicado por 1.5.*/
/*Crear un rol `employee` que tenga acceso de inserción, eliminación y actualización a la tabla `rental`.*/
/*Revocar el acceso de eliminación a `employee` y crear un rol `administrator` que tenga todos los privilegios sobre la BD `sakila`.*/
/*Crear dos roles de empleado. A uno asignarle los permisos de `employee` y al otro de `administrator`.*/
