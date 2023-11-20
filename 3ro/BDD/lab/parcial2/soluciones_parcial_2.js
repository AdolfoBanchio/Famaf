db.sales.findOne();
db.storeObjectives.findOne();
/* 
Ejercicio 1
Buscar las ventas realizadas en "London", "Austin" o "San Diego"; 
a un customer con edad mayor-igual a 18 años que tengan productos que hayan salido al menos 1000 
y estén etiquetados (tags) como de tipo "school" o "kids" (pueden tener más etiquetas).
Mostrar el id de la venta con el nombre "sale", la fecha (“saleDate"), el storeLocation, y el "email del cliente. 
No mostrar resultados anidados. 
 */
db.sales.find({
    "storeLocation":{"$in":["London","Austin","San Diego"]},
    "customer.age":{"$gte":18},
    "items":{
        $elemMatch:{
            "price":{$gte:1000.0},
            "tags":{
                $elemMatch:{
                    $eq:"kids",
                    $eq:"school"
                }
            }
        }
    }
},
{
    "_id":1,"saleDate":1,"storeLocation":1,"customer.email":1
}
);

/* 
Ejercicio 2
Buscar las ventas de las tiendas localizadas en Seattle, donde el método de compra sea ‘In store’ o ‘Phone’ 
y se hayan realizado entre 1 de febrero de 2014 y 31 de enero de 2015 (ambas fechas inclusive). 
Listar el email y la satisfacción del cliente, y el monto total facturado, 
donde el monto de cada item se calcula como 'price * quantity'. 
Mostrar el resultado ordenados por satisfacción (descendente), 
frente a empate de satisfacción ordenar por email (alfabético). 
 */
db.sales.find({
    "storeLocation":"Seattle",
    "purchaseMethod" : "In store"
//    "purchaseMethod":'InStore',
//    "saleDate":{$gte: ISODate("2014-02-01")}
});

db.sales.aggregate([
{
    $match:{
        "storeLocation":"Seattle",
        "purchaseMethod" : "In store",
        "saleDate":{$gte:ISODate("2014-02-01"),$lte:ISODate("2015-01-31")},    
    }
},
{
  $unwind:{path:"$items"}  
},
{
    $addFields:{
        "monto":{
            $sum:{
                $multiply:["$items.price","$items.quantity"]
            }
        }
    }
},
{
    $group:{
        "_id":"$_id",
    }
}
]);
 
 
/*
Ejercicio 3
Crear la vista salesInvoiced que calcula el monto mínimo, monto máximo, monto total 
y monto promedio facturado por año y mes. 
Mostrar el resultado en orden cronológico. 
No se debe mostrar campos anidados en el resultado.
*/

/*
Ejercicio 4
Mostrar el storeLocation, la venta promedio de ese local, 
el objetivo a cumplir de ventas (dentro de la colección storeObjectives) 
y la diferencia entre el promedio y el objetivo de todos los locales.
*/
 
 
 

