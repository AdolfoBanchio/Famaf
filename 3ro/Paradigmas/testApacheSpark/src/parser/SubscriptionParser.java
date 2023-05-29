package parser;

import subscription.*;

import java.io.FileReader;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.*;
/*
 * Esta clase implementa el parser del  archivo de suscripcion (json)
 * Leer https://www.w3docs.com/snippets/java/how-to-parse-json-in-java.html
 * */

public class SubscriptionParser extends GeneralParser {

    private String path;
    private Subscription subscription;

    public SubscriptionParser(String path, Subscription subscription) {
        this.path = path;
        this.subscription = subscription;
        this.parse();
    }

    public Subscription getSubscription() {
        return subscription;
    }

    public void parse() {
        JSONArray jsonArray = null;
        try {
            FileReader reader = new FileReader(this.path);
            Object obj = new JSONParser().parse(reader);
            jsonArray = (JSONArray) obj;

            for (Object o : jsonArray) {
                JSONObject url = (JSONObject) o;
    
                String urlName = (String) url.get("url");
                JSONArray urlParams = (JSONArray) url.get("urlParams");
                String urlType = (String) url.get("urlType");

                SingleSubscription singleSubscription = new SingleSubscription(urlName, null, urlType);

                for (Object p : urlParams) {
                    singleSubscription.setUlrParams((String) p);
                }
                this.subscription.addSingleSubscription(singleSubscription);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
