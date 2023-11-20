db.sales.findOne();
db.storeObjectives.find();
/* 
Ejercicio 1
Buscar las ventas realizadas en "London", "Austin" o "San Diego"; 
a un customer con edad mayor-igual a 18 años que tengan productos que hayan salido al menos 1000 
y estén etiquetados (tags) como de tipo "school" o "kids" (pueden tener más etiquetas).
Mostrar el id de la venta con el nombre "sale", la fecha (“saleDate"), el storeLocation, y el "email del cliente. 
No mostrar resultados anidados. 
 */
use("supplies");
db.sales.find({
    "storeLocation": { "$in": ["London", "Austin", "San Diego"] },
    "customer.age": { "$gte": 18 },
    "items": {
        $elemMatch: {
            "price": { $gte: 1000.0 },
            "tags": {
                $elemMatch: {
                    $in: ["school", "kids"]
                }
            }
        }
    }
},
    {
        "_id": 1, "saleDate": 1, "storeLocation": 1, "email": "$customer.email"
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
db.sales.aggregate([
    {
        $match: {
            "storeLocation": "Seattle",
            "purchaseMethod": {
                $in: ['In store', 'Phone']
            },
            "saleDate": { $gte: ISODate("2014-02-01"), $lte: ISODate("2015-01-31") },
        }
    },
    {
        $unwind: { path: "$items" }
    },
    {
        $addFields: {
            "sum": {
                $multiply: ["$items.price", "$items.quantity"]
            }
        }
    },
    {
        $group: {
            "_id": "$_id",
            "email": { $first: "$customer.email" },
            "satisfaction": { $first: "$customer.satisfaction" },
            "total_sale": { $sum: "$sum" }
        }
    },
    {
        $sort: {
            "satisfaccion": -1,
            "email": 1
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

db.createView("salesInvoiced", "sales",
    [
        {
            $unwind: { path: "$items" }
        },// separo por items
        {
            $addFields: {
                "total_item": {
                    $multiply: ["$items.price", "$items.quantity"]
                }
            }
        },// a cada item le calculo el monto
        {
            $group: {
                _id: { _id: "$_id", year: { $year: "$saleDate" }, month: { $month: "$saleDate" }, },
                "total_sale": { $sum: "$total_item" }
            }
        },// calulo el montototal de cada venta
        {
            $group: {
                _id: { year: "$_id.year", month: "$_id.month" },
                "min_sale": { $min: "$total_sale" },
                "max_sale": { $max: "$total_sale" },
                "sum_sales": { $sum: "$total_sale" },
                "avg_sale": { $avg: "$total_sale" }
            }
        },// agrupo por año y mes 
        {
            $project: {
                "_id": 0,
                "year": "$_id.year",
                "month": "$_id.month",
                "min_sale": 1,
                "max_sale": 1,
                "sum_sales": 1,
                "avg_sale": 1
            }
        },
        {
            $sort: {
                "year": 1,
                "month": 1
            }
        }
    ]);

db.salesInvoiced.find();

/*
Ejercicio 4
Mostrar el storeLocation, la venta promedio de ese local, 
el objetivo a cumplir de ventas (dentro de la colección storeObjectives) 
y la diferencia entre el promedio y el objetivo de todos los locales.
*/
db.sales.aggregate([
    {
        $lookup: {
            from: "storeObjectives",
            localField: "storeLocation",
            foreignField: "_id",
            as: "Objective"
        }
    },
    {
        $unwind: { path: "$items" }
    },
    {
        $addFields: {
            "sum": {
                $multiply: ["$items.price", "$items.quantity"]
            }
        }
    }, // calculo el total por item
    {
        $group: {
            _id: { "id": "$_id", "storeLocation": "$storeLocation", "Objective": "$Objective" },
            "total_sale": { $sum: "$sum" }
        }
    },// calculo el monto total de cada venta
    {
        $group: {
            "_id": { "storeLocation": "$_id.storeLocation", "Objective": "$_id.Objective" },
            "avg_sale": { $avg: "$total_sale" },
        }
    },// calculo el promedio de cada tienda
    {
        $project: {
            "_id": 0,
            "storeLocation": "$_id.storeLocation",
            "Objective": { $first: "$_id.Objective.objective" },
            "avg_sale": 1,
            "difference": { $subtract: [{ $first: "$_id.Objective.objective" }, "$avg_sale"] }
        }
    }
]);


/*
Ejercicio 5
Especificar reglas de validación en la colección sales utilizando JSON Schema. 
Las reglas se deben aplicar sobre los campos: 
saleDate, storeLocation, purchaseMethod, 
y  customer ( y todos sus campos anidados ). 
Inferir los tipos y otras restricciones que considere adecuados para especificar 
las reglas a partir de los documentos de la colección. 
Para testear las reglas de validación crear un caso de falla en la regla de validación 
y un caso de éxito (Indicar si es caso de falla o éxito) 

Para este validador asumo que todas las tiendas que existen por el momento estan 
en el siguiente listado de estados:
'London',
'New York',
'Denver',
'San Diego',
'Austin',
'Seattle'

*/

db.runCommand({
    collMod: "sales",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["saleDate", "storeLocation", "purchaseMethod", "customer"],
            properties: {
                saleDate: {
                    bsonType: 'date'
                },
                storeLocation: {
                    bsonType: 'string',
                    'enum': [
                        'London',
                        'New York',
                        'Denver',
                        'San Diego',
                        'Austin',
                        'Seattle'
                    ]
                },
                purchaseMethod: {
                    bsonType: 'string'
                },
                customer: {
                    bsonType: 'object',
                    required: [
                        'email'
                    ],
                    properties: {
                        email: {
                            bsonType: 'string',
                            pattern: '^(.*)@(.*)\\.(.{2,4})$'
                        },
                        age: {
                            bsonType: 'int'
                        },
                        gender: {
                            bsonType: 'string',
                            'enum': [
                                'M',
                                'F',
                                null
                            ]
                        },
                        satisfaction: {
                            bsonType: 'decimal'
                        }
                    }
                }
            }
        }
    }
});


// Este insert falla
db.sales.insertOne(
    {
        "saleDate": "2020-5-21",
        "items": [
            {
                "name": "printer paper",
                "tags": [
                    "office",
                    "stationary"
                ],
                "price": NumberDecimal("40.01"),
                "quantity": 2.0
            }
        ],
        "storeLocation": "New York",
        "customer": {
            "gender": "M",
            "age": 42.0,
            "email": "cauho@witwuta.sv",
            "satisfaction": 4.0
        },
        "couponUsed": false,
        "purchaseMethod": "Phone"
    }
);

// insert con exito
db.sales.insertOne(
    {
        "saleDate": ISODate("2020-05-21"),
        "items": [
            {
                "name": "printer paper",
                "tags": [
                    "office",
                    "stationary"
                ],
                "price": NumberDecimal("40.01"),
                "quantity": 2.0
            }
        ],
        "storeLocation": "New York",
        "customer": {
            "gender": "M",
            "age": NumberInt(42.0),
            "email": "cauho@witwuta.sv",
            "satisfaction": NumberDecimal(4.0)
        },
        "couponUsed": false,
        "purchaseMethod": "Phone"
    }
);



