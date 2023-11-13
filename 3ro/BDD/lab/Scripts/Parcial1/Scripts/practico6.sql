use classicmodels;

/* 1. Devuelva la oficina con mayor número de empleados. */
SELECT o.officeCode, COUNT(e.employeeNumber) as employees FROM
(offices as o INNER JOIN employees as e ON o.officeCode = e.officeCode)
GROUP BY o.officeCode
ORDER BY employees DESC 
LIMIT 1;

SELECT
	officeCode,
	city,
	numberOfEmployees
FROM (
	SELECT
		o.*,
		COUNT(1) as numberOfEmployees
	FROM
		(offices o
	JOIN employees e
		ON
		o.officeCode = e.officeCode)
	GROUP BY
		o.officeCode
) as numberOfEmployeesPerOffice
ORDER BY
	numberOfEmployees DESC
LIMIT 1;

/* 2. ¿Cuál es el promedio de órdenes hechas por oficina?, 
¿Qué oficina vendió la mayor cantidad de productos? */
WITH ordersxoffice AS (
	SELECT off.officeCode AS office,
	count(1) AS amountOfOrders 
	FROM (((orders o inner join customers c on o.customerNumber = c.customerNumber)
	JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber) 
	JOIN offices off ON e.officeCode = off.officeCode)
	GROUP BY office
)
SELECT * from ordersxoffice;

/* 3. Devolver el valor promedio, máximo y mínimo de pagos que se hacen por mes. */

/* 4. Crear un procedimiento "Update Credit" en donde se modifique el límite de 
crédito de un cliente con un valor pasado por parámetro. */

/* 5. Cree una vista "Premium Customers" que devuelva el top 10 de clientes que más 
dinero han gastado en la plataforma. La vista deberá devolver el nombre del cliente,
la ciudad y el total gastado por ese cliente en la plataforma. */

/* 6. Cree una función "employee of the month" que tome un mes y un año y 
devuelve el empleado (nombre y apellido) cuyos clientes hayan efectuado la 
mayor cantidad de órdenes en ese mes. */

/* 7. Crear una nueva tabla "Product Refillment". Deberá tener una relación varios a uno 
con "products" y los campos: `refillmentID`, `productCode`, `orderDate`, `quantity`. */

/* 8. Definir un trigger "Restock Product" que esté pendiente de los cambios efectuados
 en `orderdetails` y cada vez que se agregue una nueva orden revise 
 la cantidad de productos pedidos (`quantityOrdered`) y compare con la cantidad en stock 
 (`quantityInStock`) y si es menor a 10 genere un pedido en la tabla "Product Refillment" por 10 nuevos productos.*/

/* 9. Crear un rol "Empleado" en la BD que establezca accesos de lectura a 
todas las tablas y accesos de creación de vistas */