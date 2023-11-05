/*1. Crear un campo nuevo `total_medals` en la tabla `person` que almacena la
cantidad de medallas ganadas por cada persona. Por defecto, con valor 0.*/
ALTER TABLE olympics.person ADD total_medals INT DEFAULT 0 NOT NULL;

/*2. Actualizar la columna `total_medals` de cada persona con el recuento real de
medallas que ganó. Por ejemplo, para Michael Fred Phelps II, luego de la
actualización debería tener como valor de `total_medals` igual a 28.*/
WITH mxp AS(
SELECT person_id, count(1) amount_medals
FROM games_competitor AS gc
JOIN competitor_event AS ce ON
	gc.id = ce.competitor_id
WHERE medal_id != (SELECT id
FROM medal
WHERE medal_name = 'NA')
GROUP BY
	person_id
ORDER BY
	amount_medals DESC
)
UPDATE person AS p
INNER JOIN mxp ON
	p.id = mxp.person_id
SET
	total_medals = mxp.amount_medals
WHERE p.id = mxp.person_id;

SELECT * FROM  person p WHERE p.id = 94406;

/*3. Devolver todos los medallistas olímpicos de Argentina, es decir, los que hayan
logrado alguna medalla de oro, plata, o bronce, enumerando la cantidad por tipo de
medalla. Por ejemplo, la query debería retornar casos como el siguiente:
(Juan Martín del Potro, Bronze, 1), (Juan Martín del Potro, Silver,1)*/
CREATE VIEW argCompetitors AS (
SELECT gc.id AS gcid , p.full_name AS nombre
FROM((games_competitor AS gc
INNER JOIN person AS p ON
    gc.person_id = p.id)
INNER JOIN person_region AS pr ON
    p.id = pr.person_id)
WHERE pr.region_id = (SELECT id
FROM noc_region
WHERE noc = 'ARG')
);

SELECT  argC.nombre AS deportista, 
        m.medal_name AS medalla, 
        count(ge.medal_id) AS cantidad
FROM((argCompetitors AS argC
INNER JOIN competitor_event AS ge 
	ON
	argC.gcid = ge.competitor_id)
INNER JOIN medal AS m
	ON
	m.id = ge.medal_id)
WHERE ge.medal_id != (
	SELECT id
from medal
where medal_name = 'NA')
GROUP BY
	deportista, medalla;

/*4. Listar el total de medallas ganadas por los deportistas argentinos en cada deporte.
 * Utilizo la view creada en el ejercicio 3*/

SELECT s.sport_name AS Deporte, COUNT(1) AS 'Cantidad de medallas'
FROM(((argCompetitors AS argC
INNER JOIN competitor_event AS ce 
ON
	argC.gcid = ce.competitor_id)
INNER JOIN event AS e
ON
	ce.event_id = e.id)
INNER JOIN sport AS s
ON
	e.sport_id = s.id)
WHERE medal_id != (
	SELECT id
FROM medal
WHERE medal_name = 'NA')
GROUP BY
	Deporte;

/*5. Listar el número total de medallas de oro, plata y bronce ganadas por cada país
(país representado en la tabla `noc_region`), agruparlas los resultados por pais.*/
CREATE VIEW medallasxpais AS (
SELECT nr.region_name AS pais, ce.medal_id AS medalla
FROM(((noc_region AS nr
INNER JOIN person_region AS pr
ON
	nr.id = pr.region_id)
INNER JOIN games_competitor AS gc
ON
	pr.person_id = gc.person_id)
INNER JOIN competitor_event AS ce
ON
	gc.id = ce.competitor_id)
WHERE ce.medal_id != (SELECT id
FROM medal
WHERE medal_name = 'NA')
);

SELECT
	pais,
	count(IF(medalla =(SELECT id FROM medal WHERE medal_name = 'Gold'), 1, NULL)) AS 'Oro',
	count(IF(medalla =(SELECT id FROM medal WHERE medal_name = 'Silver'), 1, NULL)) AS 'Plata',
	count(IF(medalla =(SELECT id FROM medal WHERE medal_name = 'Bronze'), 1, NULL)) AS 'Bronce'
FROM
	medallasxpais
GROUP BY
	pais;

/*6. Listar el país con más y menos medallas ganadas en la historia de las olimpiadas.*/
(
SELECT pais, sum(medalla) AS TotalMedallas
FROM medallasxpais
GROUP BY
	pais
ORDER BY 
	TotalMedallas DESC
LIMIT 1)
UNION
(SELECT pais, sum(medalla) AS TotalMedallas
FROM medallasxpais
GROUP BY
	pais
ORDER BY 
	TotalMedallas ASC
LIMIT 1
);

/*7. Crear dos triggers:
a. Un trigger llamado `increase_number_of_medals` que incrementará en 1 el
valor del campo `total_medals` de la tabla `person`.
b. Un trigger llamado `decrease_number_of_medals` que decrementará en 1
el valor del campo `totals_medals` de la tabla `person`.
El primer trigger se ejecutará luego de un `INSERT` en la tabla `competitor_event` y
deberá actualizar el valor en la tabla `person` de acuerdo al valor introducido (i.e.
sólo aumentará en 1 el valor de `total_medals` para la persona que ganó una
medalla). Análogamente, el segundo trigger se ejecutará luego de un `DELETE` en la
tabla `competitor_event` y sólo actualizará el valor en la persona correspondiente.*/
CREATE TRIGGER increase_number_of_medals AFTER
INSERT ON
competitor_event FOR EACH ROW 
	UPDATE person
    SET 
       person.total_medals = IF(
                    NEW.medal_id != (
                                SELECT id FROM medal WHERE medal_name = 'NA'), 
                                person.total_medals + 1, 
                                person.total_medals)
    WHERE person.id = (SELECT gc.person_id
                       FROM games_competitor AS gc
                       WHERE gc.id = NEW.competitor_id
		              );

CREATE TRIGGER decrease_number_of_medals AFTER
DELETE ON
	competitor_event FOR EACH ROW 
	UPDATE person
    SET
	   person.total_medals = person.total_medals -1
    WHERE person.id = ( SELECT gc.person_id
                        FROM games_competitor AS gc
                        WHERE gc.id = OLD.competitor_id
		              );

/*8. Crear un procedimiento `add_new_medalists` que tomará un `event_id`, y tres ids
de atletas `g_id`, `s_id`, y `b_id` donde se deberá insertar tres registros en la tabla
`competitor_event` asignando a `g_id` la medalla de oro, a `s_id` la medalla de
plata, y a `b_id` la medalla de bronce.*/
CREATE PROCEDURE add_new_medalists(IN p_event_id INT, IN p_g_id INT, p_s_id INT, IN p_b_id INT)
BEGIN
DECLARE gold_id INT;
DECLARE silver_id INT;
DECLARE bronze_id INT;

SELECT id
INTO gold_id
FROM medal AS m
WHERE m.medal_name = 'Gold';

SELECT id
INTO silver_id
FROM medal AS m
WHERE m.medal_name = 'Silver';

SELECT id
INTO bronze_id
FROM medal AS m
WHERE m.medal_name = 'Bronze';

INSERT
	INTO competitor_event (
	event_id,
	competitor_id,
	medal_id)
VALUES (
    p_event_id,
    p_g_id,
    gold_id);

INSERT
	INTO competitor_event (
	event_id,
	competitor_id,
	medal_id)
VALUES (
    p_event_id,
    p_s_id,
    silver_id);

INSERT
	INTO competitor_event (
	event_id,
	competitor_id,
	medal_id)
VALUES (
    p_event_id,
    p_b_id,
    bronze_id);
END

/*9. Crear el rol `organizer` y asignarle permisos de eliminación sobre la tabla `games`
y permiso de actualización sobre la columna `games_name` de la tabla `games` .*/
CREATE ROLE organizer ;

GRANT
    DELETE,
    UPDATE (games_name) 
    ON games 
    TO organizer;

SHOW GRANTS FOR organizer;
