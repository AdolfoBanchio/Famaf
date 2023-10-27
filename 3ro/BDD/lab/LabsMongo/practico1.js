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
db.comments.find({ "name": {$in:["Ale1", "ale2", "Ale3", "Ale4"]} });


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


/*Listar el id del teatro (theaterId), estado (“location.address.state”), 
ciudad (“location.address.city”), y coordenadas (“location.geo.coordinates”) 
de los teatros que se encuentran en algunos de los estados "CA", "NY", "TX" 
y el nombre de la ciudades comienza con una ‘F’. 
Listar ordenados por estado y ciudad.*/
db.theaters.find();
db.theaters.find(
    {
        "location.address.state":{$in:["CA","NY","TX"]},
        "location.address.city":{$regex:'^F'}
    },
    {
        "theaterId":1,
        "location.address.state":1,
        "location.address.city":1,
        "location.address.coordinates":1    
    }
).sort({
    "location.address.state":1,
    "location.address.city":1
});

/*Actualizar los valores de los campos texto (text) y fecha (date) del comentario cuyo 
id es ObjectId("5b72236520a3277c015b3b73") a "mi mejor comentario" 
y fecha actual respectivamente.*/
db.comments.updateMany(
    {
        "_id":ObjectId("5b72236520a3277c015b3b73")   
    },
    {
        $set:{
                "text":"mi mejor comentario",
                "date":ISODate()
             }
    });
db.comments.find({"_id":ObjectId("5b72236520a3277c015b3b73")});
    
/*Actualizar el valor de la contraseña del usuario cuyo email es joel.macdonel@fakegmail.com a 
"some password". La misma consulta debe poder insertar un 
nuevo usuario en caso que el usuario no exista. 
Ejecute la consulta dos veces. ¿Qué operación se realiza en cada caso?  
(Hint: usar upserts). */
db.users.updateOne(
    {
        "email":"joel.macdonel@fakegmail.com",
    },
    {
        $set:{"password":"some password"}
    },
    {
        upsert:true
    });
 
db.users.deleteOne({"email":"joel.macdonel@fakegmail.com"});
    
db.users.find({"email":"joel.macdonel@fakegmail.com"});
/*Remover todos los comentarios realizados por el usuario 
cuyo email es victor_patel@fakegmail.com durante el año 1980.*/
db.comments.deleteMany(
    {
        "email":"victor_patel@fakegmail.com",
        $expr:{$eq:[{$year: "$date"},1980]}
    });
    
db.comments.find({"email":"victor_patel@fakegmail.com",$expr:{$eq:[{$year: "$date"},1980]}});










