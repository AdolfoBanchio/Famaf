-- Parte I - Consultas

/*Listar el nombre de la ciudad y el nombre del país de todas las ciudades 
 * que pertenezcan a países con una población menor a 10000 habitantes.*/
select
	ci.name Ciudad,
	c.Name Pais
from
	(city ci
inner join country c on
	ci.CountryCode = c.Code)
where
	(ci.CountryCode) IN (
	select
		c.Code
	from
		country c
	where
		Population < 10000);

SELECT city.Name Ciudad, 
       (SELECT country.Name FROM country WHERE country.Code = city.CountryCode) AS Pais
FROM city
WHERE city.CountryCode IN (SELECT Code FROM country WHERE Population < 10000);

/*Listar todas aquellas ciudades cuya población sea mayor que 
 * la población promedio entre todas las ciudades.*/
select Name from city where Population > ALL (select avg(Population) from city); 

/*Listar todas aquellas ciudades no asiáticas cuya población 
 * sea igual o mayor a la población total de algún país de Asia.*/

select ci.name from city ci 
where ci.CountryCode not in (select c.code from country c where c.Continent='Asia') 
AND ci.Population >= (select min(c.Population) 
					  from country c 
					  where c.Continent = 'Asia');


/*Listar aquellos países junto a sus idiomas no oficiales, que superen en porcentaje 
 * de hablantes a cada uno de los idiomas oficiales del país.*/
with 
	unoficial_lenguages AS (
		select c.Name Pais,c.Code , l.`Language` ,l.Percentage 
		from (country c inner join
			 countrylanguage l on
			 c.Code=l.CountryCode AND
			 l.IsOfficial='F')
	)
select ul.Pais , ul.Language 
from unoficial_lenguages ul
where ul.Percentage > ALL (select l.Percentage from countrylanguage l where l.IsOfficial='T' and ul.Code = l.CountryCode);
/*Listar (sin duplicados) aquellas regiones que tengan países con una superficie menor a 1000 
 * km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes. 
 * (Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas respuestas).*/

SELECT DISTINCT c.Region 
FROM (country c
	  INNER JOIN city ci 
	  ON c.Code = ci.CountryCode )
WHERE c.SurfaceArea < 1000
AND ci.Population > 100000;
		
SELECT DISTINCT c.Region 
FROM country c 
WHERE c.SurfaceArea < 1000
AND EXISTS (SELECT ci.Name 
			FROM (city ci INNER JOIN country ON c.Code = ci.CountryCode)
			WHERE ci.Population>100000);

/*Listar el nombre de cada país con la cantidad de habitantes de su 
 * ciudad más poblada. (Hint: Hay dos maneras de llegar al mismo resultado. 
 * Usando consultas escalares o usando agrupaciones, encontrar ambas).*/
SELECT  c.name Pais , 
		(SELECT max(ci.Population) FROM city ci WHERE ci.CountryCode = c.Code) maxPop
FROM country c ORDER BY maxPop DESC; 

/*Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea 
 * mayor al promedio de hablantes de los lenguajes oficiales.*/
with 
	unoficial_lenguages AS (
		select c.Name Pais,c.Code , l.`Language` ,l.Percentage 
		from (country c inner join
			 countrylanguage l on
			 c.Code=l.CountryCode AND
			 l.IsOfficial='F')
	)
select ul.Pais , ul.Language 
from unoficial_lenguages ul
where ul.Percentage > ALL (select avg(l.Percentage) from countrylanguage l where l.IsOfficial='T' and ul.Code = l.CountryCode);

/*Listar la cantidad de habitantes por continente ordenado en forma descendente.*/
select cont.Name Continente , sum(c.Population) Poblacion
from (continent cont inner join
	  country c on 
	  cont.Name=c.Continent)
GROUP BY Continente
order by Poblacion DESC ;
		
/*Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una esperanza de vida entre 40 y 70 años.*/
select cont.Name Continente , avg(c.LifeExpectancy) EsperanzaDeVida
from (continent cont inner join
	  country c on 
	  cont.Name=c.Continent)
WHERE c.LifeExpectancy BETWEEN 40 AND 70
GROUP BY Continente
order by  EsperanzaDeVida DESC ; -- Esperanza de vida promedio entre los paises con esperanza de vida de 40 a 70

select cont.Name Continente , avg(c.LifeExpectancy) EsperanzaDeVida
from (continent cont inner join
	  country c on 
	  cont.Name=c.Continent)
GROUP BY Continente
HAVING EsperanzaDeVida BETWEEN 40 AND 70
ORDER BY EsperanzaDeVida DESC ;
/*Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.*/
select
	cont.Name Continente ,
	MIN(c.Population) Pop_min,
	MAX(c.Population) Pop_max,
	AVG(c.Population) Pop_avg,
	SUM(c.Population) Pop_sum
from
	(continent cont
inner join
	  country c on 
	  cont.Name = c.Continent)
GROUP BY
	Continente;		
-- Parte II - Preguntas

/*Si en la consulta 6 se quisiera devolver, además de las columnas ya solicitadas, el nombre de la ciudad más poblada. 
 * ¿Podría lograrse con agrupaciones? ¿y con una subquery escalar?*/
