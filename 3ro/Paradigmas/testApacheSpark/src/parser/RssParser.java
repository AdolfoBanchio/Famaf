package parser;
import org.w3c.dom.*;
import org.xml.sax.InputSource;

import feed.Article;

import javax.xml.parsers.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

/* Esta clase implementa el parser de feed de tipo rss (xml)
 * y 
 * https://www.tutorialspoint.com/java_xml/java_dom_parse_document.htm 
 * */

 public class RssParser extends GeneralParser {
    private String siteName;
    private ArrayList<Article> articleList;
    private String xmlString;

    public RssParser(String xmlString) {
        this.xmlString = xmlString;
        this.articleList = new ArrayList<Article>();
        this.parse();
    }

    public ArrayList<Article> getArticleList() {
        return articleList;
    }

    public String getSiteName() {
        return this.siteName;
    } 

    public void parse() {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputSource inputSource = new InputSource(new StringReader(this.xmlString));
            Document doc = builder.parse(inputSource);
            //busquemos el titulo del xml
            NodeList nameList = doc.getElementsByTagName("channel");
            Node nameNode = nameList.item(0);
            Element nameElement = (Element)nameNode;
            this.siteName = nameElement.getElementsByTagName("title").item(0).getTextContent();
            //ya quedo cargado el siteName
            NodeList nList = doc.getElementsByTagName("item");
            for (int temp = 0; temp < nList.getLength(); temp++) {
                
                Node nNode = nList.item(temp);
                //System.out.println("\nCurrent Element :" + nNode.getNodeName());
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element)nNode;
                    String titulo = eElement.getElementsByTagName("title").item(0).getTextContent();
                    String link = eElement.getElementsByTagName("link").item(0).getTextContent();
                    String descripcion = eElement.getElementsByTagName("description").item(0).getTextContent();
                    String StringpubDate = eElement.getElementsByTagName("pubDate").item(0).getTextContent();
                    SimpleDateFormat formatter = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.US);
                    Date pubDate = formatter.parse(StringpubDate);
                    //Date pubDate = new Date();
                    Article article = new Article(titulo, descripcion, pubDate, link); 
                    this.articleList.add(article);
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
