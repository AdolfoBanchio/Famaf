/*
Insertar 5 nuevos usuarios en la colección users. 
Para cada nuevo usuario creado, insertar al menos un comentario realizado por el usuario en la colección comments.

*/
names = ["Ale1", "ale2", "Ale3", "Ale4"]
for (i = 0; i < 4; i++) {
    db.users.insertOne({
        "name": names[i],
        "email": names[i] + "@mail.com",
    });
};

names = ["Ale1", "ale2", "Ale3", "Ale4"];
names.forEach((name) => db.comments.insertOne({
    "name": name,
    "email": name + "@mail.com",
    "movie_id": db.movies.findOne({}, ["_id"])._id,
    "text": "This is a comment from " + name[i],
    "date": new Date()
})
)
names = ["Ale1", "ale2", "Ale3", "Ale4"]
db.comments.find({ "name": "Ale1" });


/*
* Listar el título, año, actores (cast), directores y rating 
de las 10 películas con mayor rating (“imdb.rating”) de la década del 90. }
¿Cuál es el valor del rating de la película que tiene mayor rating? 
(Hint: Chequear que el valor de “imdb.rating” sea de tipo “double”).
*/
db.movies.find();
db.movies.find(
    { "year": { $gte: 1990, $lte: 1999 }, "imdb.rating": { $type: "double" } },
    { "title": 1, "year": 1, "cast": 1, "directors": 1, "imdb.rating": 1 })
    .sort(
        { "imdb.rating": -1 }
    ).limit(10);

/*
Listar el nombre, email, texto y fecha de los comentarios que la película con id 
(movie_id) ObjectId("573a1399f29313caabcee886") recibió 
entre los años 2014 y 2016 inclusive. 
Listar ordenados por fecha. 
Escribir una nueva consulta (modificando la anterior) para responder 
¿Cuántos comentarios recibió?
*/
db.comments.find();
db.comments.find(
    {
        "movie_id": { $eq: ObjectId("573a1399f29313caabcee886") },
        "date": { $gte: ISODate("2014-01-01"), $lte: ISODate("2016-12-31") }
    },
    { "name": 1, "email": 1, "text": 1, "date": 1 }
).sort({
    "date": -1
});

/*
* Listar el nombre, id de la película, texto y fecha de los 3 comentarios 
más recientes realizados por el usuario con email patricia_good@fakegmail.com. 
*/
db.comments.find();
db.comments.find(
    {
        "email":"patricia_good@fakegmail.com"
    },
    {"name":1,"movie_id":1,"text":1,"date":1}
).sort(
    {
        "date":-1
    }
).limit(3);












