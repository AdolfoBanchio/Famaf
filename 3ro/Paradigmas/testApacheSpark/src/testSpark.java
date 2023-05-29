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
        List<NamedEntity> combinedNamedEntiys = modifiedArticlesRDD.reduce(testSpark::combineArticles);

        //Print the new list
        for (NamedEntity ne : combinedNamedEntiys) {
            ne.prettyPrint();
        }
        sc.close();
    }
    private static List<NamedEntity> combineArticles(List<NamedEntity> list1, List<NamedEntity> list2) {
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

