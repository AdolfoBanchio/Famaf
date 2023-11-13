-- Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo.

select
	c.Name ,
	c2.name ,
	c2.region,
	c2.GovernmentForm
from
	city c ,
	country c2
where
	c.CountryCode = c2.code
order by
	c.Population DESC
limit 10;
-- Listar los 10 países con menor población del mundo, junto a sus ciudades capitales (Hint: puede que uno de estos países no tenga ciudad capital asignada, en este caso deberá mostrar "NULL").
select
	c.name Country,
	c2.name Capital
from
	(country c
left join city c2 on
	c.Capital = c2.ID)
order by
	c.Population ASC
limit 10;
-- Listar el nombre, continente y todos los lenguajes oficiales de cada país. (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).

select
	co.name Country,
	co.continent ,
	l.Language
from
	(country co
inner join countrylanguage l 
	on
	co.code = l.CountryCode)
where
	l.IsOfficial = 'T';

/*Listar el nombre del país y nombre de capital, 
de los 20 países con mayor superficie del mundo.*/
select
	c.name Country,
	ci.name
from
	(country c
inner join city ci on
	c.Capital = ci.ID)
order by
	c.SurfaceArea DESC
limit 20;

/*Listar las ciudades junto a sus idiomas oficiales (ordenado por la 
 * población de la ciudad) y el porcentaje de hablantes del idioma.*/
select
	ci.name Ciudad,
	l.`Language` Idioma ,
	l.Percentage Porcentaje,
	ci.Population
from
	(city ci inner join countrylanguage l 
	on ci.CountryCode = l.CountryCode)
WHERE
	l.IsOfficial = 'T'
order by
	ci.Population DESC ;

/*Listar los 10 países con mayor población y los 10 países con menor 
 * población (que tengan al menos 100 habitantes) en la misma consulta.*/

(
select
	name,
	Population
from
	country
order by
	Population DESC
limit 10)
UNION
(
select
name,
Population
from
country
where
Population >= 100
order by
Population ASC
limit 10);

/*Listar aquellos países cuyos lenguajes oficiales son el Inglés y 
 * el Francés (hint: no debería haber filas duplicadas).*/
(
select
	name
from
	country c,
	countrylanguage c2
where
	c.Code = c2.CountryCode
	and c2.Language = 'English'
	and c2.IsOfficial = 'T')
INTERSECT 
(
select
name
from
country c,
countrylanguage c2
where
c.Code = c2.CountryCode
and c2.Language = 'French'
and c2.IsOfficial = 'T');

/*Listar aquellos países que tengan hablantes del Inglés 
 * pero no del Español en su población.*/
(SELECT 	c.name , c2.CountryCode
FROM (country c INNER JOIN countrylanguage c2
ON c.Code = c2.CountryCode
AND c2.`Language` = 'English'))
EXCEPT 
(SELECT c.name, c2.CountryCode
FROM (country c INNER JOIN countrylanguage c2
ON c.Code = c2.CountryCode
AND c2.`Language` = 'Spanish'
AND c2.Percentage != 0));


