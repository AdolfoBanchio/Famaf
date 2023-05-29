package subscription;

import java.util.ArrayList;
import java.util.List;

import parser.SubscriptionParser;

/*Esta clse abstrae el contenido del archivo  de suscripcion(json)*/
public class Subscription {
	private List<SingleSubscription> suscriptionsList;
	
	
	public Subscription(String subscriptionFilePath) {
		super();
		this.suscriptionsList = new ArrayList<SingleSubscription>();
		SubscriptionParser sp = new SubscriptionParser(subscriptionFilePath, this);
	}

	public List<SingleSubscription> getSubscriptionsList(){
		return this.suscriptionsList;
	}

	public void addSingleSubscription(SingleSubscription s) {
		this.suscriptionsList.add(s);
	}
	
	public SingleSubscription getSingleSubscription(int i){
		return this.suscriptionsList.get(i);
	}

	@Override
	public String toString() {
		String str ="";
		for (SingleSubscription s: getSubscriptionsList()){
			str += s.toString();
		}
		return "[" + str + "]";
	}	
	
	public void prettyPrint(){
		System.out.println(this.toString());
	}
	
	public static void main(String[] args) {
		Subscription a = new Subscription(null);
	
		SingleSubscription s0 = new SingleSubscription("https://www.chicagotribune.com/arcio/rss/category/%s/?query=display_date:[now-2d+TO+now]&sort=display_date:desc", null, "rss");
		s0.setUlrParams("business");		
		
		SingleSubscription s1 = new SingleSubscription("https://rss.nytimes.com/services/xml/rss/nyt/%s.xml", null, "rss");
		s1.setUlrParams("Business");
		s1.setUlrParams("Technology");

		a.addSingleSubscription(s0);		
		a.addSingleSubscription(s1);
		a.prettyPrint();
	}
	
	
	
	
}
