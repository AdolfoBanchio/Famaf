/*Crear tabla continente llenarla y agregar clave foranea a country*/
Create table continent( 
		Name varchar(255) primary key,
		Area int,
		LanPercentage numeric(4,2),
		MostPopulatedCity int UNIQUE,
		FOREIGN KEY (MostPopulatedCity) REFERENCES city(id)
		);
	
Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('Africa',30370000,20.4,608);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('Antartica',14000000,9.2,71);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('Asia',44579000,29.5,1024);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('Europa',10180000,6.8,3357);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('North America',24709000,16.5,2515);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('Oceania',8600000,5.9,130);

Insert into continent (Name, Area,LanPercentage,MostPopulatedCity)
values ('South America',17840000,12.0,206);







/*Devuelva una lista de los nombres y las 
regiones a las que pertenece cada país ordenada alfabéticamente.*/
select name, region from country order by name ASC ;

/*Liste el nombre y la población de las 10
 ciudades más pobladas del mundo.*/
select name, Population  from country order by Population DESC limit 10;

--Liste el nombre, región, superficie y forma de gobierno de los 10 países con menor superficie.
select name, region, SurfaceArea, GovernmentForm  from country order by SurfaceArea ASC limit 10;

--Liste todos los países que no tienen independencia (hint: ver que define la independencia de un país en la BD).
select name from country where IndepYear is null;


--Liste el nombre y el porcentaje de hablantes que tienen todos los idiomas declarados oficiales.
select `Language` , Percentage from countrylanguage c where IsOfficial <>'T';


--Actualizar el valor de porcentaje del idioma inglés en el país con código 'AIA' a 100.0
UPDATE  countrylanguage set Percentage = 100 where CountryCode ='AIA';


--Listar las ciudades que pertenecen a Córdoba (District) dentro de Argentina.
select * from city c where District ='Cordoba';

--Eliminar todas las ciudades que pertenezcan a Córdoba fuera de Argentina.
delete from city where District ='Cordoba' and CountryCode !='ARG';

--Listar los países cuyo Jefe de Estado se llame John.
select * from country c where HeadOfState LIKE 'John%';

--Listar los países cuya población esté entre 35 M y 45 M ordenados por población de forma descendente.
select * from country c where Population BETWEEN 35000000 and 45000000 order by Population DESC ;
