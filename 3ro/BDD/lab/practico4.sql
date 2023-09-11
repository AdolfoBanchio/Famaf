-- Parte I - Consultas

/*Listar el nombre de la ciudad y el nombre del país de todas las ciudades 
 * que pertenezcan a países con una población menor a 10000 habitantes.*/
select ci.name Ciudad, c.Name Pais from country c, city ci where ci.CountryCode = c.Code and 
(ci.CountryCode) IN (select c.Code  from country c where Population < 10000);

select ci.name Ciudad, (select name from country c where c.Code = ci.CountryCode) Pais from city ci where
(ci.CountryCode) IN (select c.Code  from country c where Population < 10000);

/*Listar todas aquellas ciudades cuya población sea mayor que 
 * la población promedio entre todas las ciudades.*/
select Name from city where Population > ALL (select avg(Population) from city); 

/*Listar todas aquellas ciudades no asiáticas cuya población 
 * sea igual o mayor a la población total de algún país de Asia.*/
select ci.name from city ci where ci.CountryCode not in (select c.code from country c where c.Continent='Asia') AND 
ci.Population >= (select min(c.Population) from country c where c.Continent = 'Asia');


/*Listar aquellos países junto a sus idiomas no oficiales, que superen en porcentaje 
 * de hablantes a cada uno de los idiomas oficiales del país.*/


/*Listar (sin duplicados) aquellas regiones que tengan países con una superficie menor a 1000 
 * km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes. 
 * (Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas respuestas).*/


/*Listar el nombre de cada país con la cantidad de habitantes de su 
 * ciudad más poblada. (Hint: Hay dos maneras de llegar al mismo resultado. 
 * Usando consultas escalares o usando agrupaciones, encontrar ambas).*/


/*Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea 
 * mayor al promedio de hablantes de los lenguajes oficiales.*/


/*Listar la cantidad de habitantes por continente ordenado en forma descendente.*/

/*Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una esperanza de vida entre 40 y 70 años.*/

/*Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.*/

-- Parte II - Preguntas

/*Si en la consulta 6 se quisiera devolver, además de las columnas ya solicitadas, el nombre de la ciudad más poblada. 
 * ¿Podría lograrse con agrupaciones? ¿y con una subquery escalar?*/


