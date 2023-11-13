//Cantidad de cines (theaters) por estado.
db.theaters.aggregate(
    [
        {
            "$group" : {
                "_id" : "$location.address.state",
                "count" : {"$count" : {}}
            }
        }
    ]
);


//Cantidad de estados con al menos dos cines (theaters) registrados.
db.theaters.aggregate([{
    "$group":{
            "_id":"$location.address.state",
            "cantidad":{"$count":{}}
        }
    },
    {
        "$match":{
                "cantidad":{$gte:2}
            }
    }
])
//Cantidad de películas dirigidas por "Louis Lumière". Se puede responder sin pipeline de agregación, realizar ambas queries.
db.movies.aggregate([
    {
        $match:{
            "directors":{$all:["Louis Lumière"]}
        }
    },
    {
        $count:"Peliculas que dirigio Louis Lumière"
    }
]);

db.getCollection("movies").find(
    {
        "directors": {
            "$elemMatch": {
                "$eq": "Louis Lumière"
            }
        }
    }
)

/*Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959). 
Se puede responder sin pipeline de agregación, realizar ambas queries.*/
db.movies.aggregate([
    {
        $match:{
            "year":{$gte:1950,$lte:1959}
        }
    },
    {
        $count:"Cantidad de peliculas entre 1950 y 59"
    }
])

db.movies.find({
    "year":{$gte:1950,$lte:1959}
}).count();
/*
Listar los 10 géneros con mayor cantidad de películas (tener en cuenta que las películas pueden tener más de un género). 
Devolver el género y la cantidad de películas. Hint: unwind puede ser de utilidad*/
db.movies.aggregate([
    {
        $unwind:{
            path:"$genres"
        }
    },
    {
        $group:{
            "_id":"$genres",
            "cantidad_peliculas":{$count:{}}
        }
    },
    {
        $sort:{"cantidad_peliculas":-1}
    },
    {
        $limit:10
    }
]);

db.movies.find()
/*
Top 10 de usuarios con mayor cantidad de comentarios, mostrando Nombre, Email y Cantidad de Comentarios.
*/
db.comments.aggregate([
    {
        $group:{
            "_id":{email:"$email", nombre:"$name"},
            "cantidad_de_comentarios":{$count:{
            }}
        }     
    },
    {
        $sort:{"cantidad_de_comentarios":-1}
    },
    {
        $limit:10
    }
]);

db.comments.find({});
/*
Ratings de IMDB promedio, mínimo y máximo por año de las películas estrenadas en los años 80 (desde 1980 hasta 1989), 
ordenados de mayor a menor por promedio del año.*/
db.movies.find();

db.movies.aggregate([
    {
        $match:{
            "year":{$gte:1980,$lte:1989},
            "imdb.rating":{$type:"double"}
        }
    },
    {
        $group:{
            "_id":"$year",
            "avg_rating":{$avg:"$imdb.rating"},
            "min_rating":{$min:"$imdb.rating"},
            "max_rating":{$max:"$imdb.rating"},
        }
    },
    {
        $sort:{"avg_rating":-1}
    }
]);

/*
Título, año y cantidad de comentarios de las 10 películas con más comentarios.*/
db.movies.aggregate([
    {
        $lookup:{
            from:"comments",
            localField:"_id",
            foreignField:"movie_id",
            as:"comments"
        }
    },
    {
        $addFields:
        {
            "cantidad_comentarios":{$size:"$comments"}
        }    
    },
    {
        $sort:{"cantidad_comentarios":-1}
    },
    {
        $project:{
            "title":1,
            "year":1,
            "cantidad_comentarios":1
        }
    }
]);

db.comments.aggregate([
{
    $group:{
        _id:"$movie_id",
        "cantidad":{$count:{}}
    }
},
{
    $sort:{"cantidad":-1}
}
]);


/*Crear una vista con los 5 géneros con mayor cantidad de comentarios, junto con la cantidad de comentarios.*/
db.comments.findOne();

db.createView("generos_mas_comm","movies",
[
    {
        $unwind:{
            path:"$genres"
        }
    },
    {
        $lookup:{
            from:"comments",
            localField:"_id",
            foreignField:"movie_id",
            as:"comments"
        }
    },
    {
        $addFields:{
            "comentarios_pelicula":{$size:"$comments"}
        }
    },
    {
        $group:{
            _id:"$genres",
            cantidad_comentarios:{$sum:"$comentarios_pelicula"}
        }
    },
    {
        $sort:{"cantidad_comentarios":-1}
    },
    {
        $limit:5
    }
]);

db.generos_mas_comm.find();
/*
Listar los actores (cast) que trabajaron en 2 o más películas dirigidas por "Jules Bass". Devolver el nombre de estos actores junto con la lista de películas (solo título y año) dirigidas por “Jules Bass” en las que trabajaron. 
Hint1: addToSet
Hint2: {'name.2': {$exists: true}} permite filtrar arrays con al menos 2 elementos, entender por qué.
Hint3: Puede que tu solución no use Hint1 ni Hint2 e igualmente sea correcta
*/



/*Listar los usuarios que realizaron comentarios durante el mismo mes de lanzamiento de la película comentada, 
mostrando Nombre, Email, fecha del comentario, título de la película, fecha de lanzamiento. 
HINT: usar $lookup con multiple condiciones */

