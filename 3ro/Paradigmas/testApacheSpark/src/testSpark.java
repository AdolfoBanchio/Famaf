import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import namedEntity.NamedEntity;
import namedEntity.heuristic.QuickHeuristic;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import com.google.common.collect.ImmutableList;
import feed.Article;

import feed.Feed;
import httpRequest.*;
import org.roaringbitmap.art.Art;
import parser.RssParser;

public class testSpark {
    public static List<Article> reducedArticles = new ArrayList<>();
    public static void main(String[] args) {
        // configure spark
        SparkConf sparkConf = new SparkConf().setAppName("Print Elements of RDD")
                .setMaster("local[2]").set("spark.executor.memory","1g");
        // start a spark context
        JavaSparkContext sc = new JavaSparkContext(sparkConf);

        Article art1 = new Article("title1", "Biden", new Date(), "link1");
        Article art2 = new Article("title2", "Musk", new Date(), "link2");
        Article art3 = new Article("title3", "Microsoft", new Date(), "link3");
        Article art4 = new Article("title4", "Trump", new Date(), "link4");
        Article art5 = new Article("title5", "China", new Date(), "link5");

        /*create a list of articles, and with the use of foreach, print each article with article.prettyPrint()
        * Make the list serializable for apache spark
        */
        List<Article> articles = new ArrayList<Article>();
        articles.add(art1);
        articles.add(art2);
        articles.add(art3);
        articles.add(art4);
        articles.add(art5);

        httpRequester req = new httpRequester();
        String xmlResponse = req.getFeedRss("https://rss.nytimes.com/services/xml/rss/nyt/Business.xml");
        // Llamamos al parser para extraer los datos necesarios por la aplicación

        RssParser parser = new RssParser(xmlResponse);

        JavaRDD<Article> articlesRDD = sc.parallelize(parser.getArticleList(),parser.getArticleList().size());
        QuickHeuristic qh = new QuickHeuristic();

        JavaRDD<List <NamedEntity>> modifiedArticlesRDD = articlesRDD.map(article -> {
            article.computeNamedEntitys(qh);
            return article.getNamedEntityList();
        });

        //Use .reduce() to create a new article list with the modified articles
        List<NamedEntity> combinedNamedEntiys = modifiedArticlesRDD.reduce(testSpark::combineNes);

        //Print the new list
        for (NamedEntity ne : combinedNamedEntiys) {
            ne.prettyPrint();
        }
        sc.close();
    }
    private static List<NamedEntity> combineNes(List<NamedEntity> list1, List<NamedEntity> list2) {
        List<NamedEntity> combinedList = new ArrayList<>(list1);
        //this function recives two namedEntity list, it must return a combined list where if a namedEntity is repeated it increments its frequency and do not adds it twice
        //to know if a named entity is repeated its necessary to compare the name of the named entity
        for (NamedEntity ne : list2) {
            boolean found = false;
            for (NamedEntity ne2 : combinedList) {
                if (ne.getName().equals(ne2.getName())) {
                    ne2.setFrequency(ne2.getFrequency() + ne.getFrequency());
                    found = true;
                    break;
                }
            }
            if (!found) {
                combinedList.add(ne);
            }
        }
        return combinedList;
    }

}

/*
* Como hacer para computar todas las named entity de los articulos en paralelo, sin tener que chequear si estan o no.
*
* En un Feed voy a tener un article list, hago feed.articlelist.paralelice() y me devuelve un JavaRDD<Article>
* Para el JavaRDD hago map con el computedNameEntity de cada articulo, pero. Al cumpute named entity le paso la lista
* de namedentiy DEL FEED, entonces cada erticulo en paralelo se fijara si el nombre de la entidad nombrada que encontro existe ya en la lista.
*
* De forma que todos iran agregandolo a la lista del FEED, y al final del map, el feed tendra una lista de named entitys completa sin repeticiones.
*
* ¿Que pasa si dos articulos al mismo tiempo encuentran la misma named entity y consultan si existe y en ese momento NO existia?
* se cargara dos veces??
*
* en este caso no use Reduce para juntar las listas. Pero es mas eficiente que
*
* Cada articulo crea su lista independientemente de los otros articulos, y al momento de unir todas las listas de todos los articulos
* uso la funcion combineNes creada aca. 
* */

