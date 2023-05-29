package httpRequest;
import java.net.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;


/* Esta clase se encarga de realizar efectivamente el pedido de feed al servidor de noticias
 * Leer sobre como hacer una http request en java
 * https://www.baeldung.com/java-http-request
 * */

 /**
  * Esta clase se encarga de realizar efectivamente el pedido de feed al servidor de noticias
  */
public class httpRequester {
	
	/**
	 * Realiza un pedido de feed al servidor de noticias y devuelve el feed en formato XML
	 * @param urlFeed url del servidor de noticias
	 * @return feed en formato XML
	 */
	public String getFeedRss(String urlFeed){
		String feedRssXml = null;
		Connection con = new Connection(urlFeed, "GET");
		feedRssXml = con.getRss();
		con.disconnect();
		return feedRssXml;
	}

	/**
	 * Realiza un pedido de feed al servidor de Reddit y devuelve el feed en formato JSON
	 * @param urlFeed url del servidor de Reddit
	 * @return feed en formato JSON
	 */
	public String getFeedReedit(String urlFeed) {
		String feedReeditJson = null;
		return feedReeditJson;
	}

	/* create a main that parses this link https://rss.nytimes.com/services/xml/rss/nyt/Buisiness.xml */
	public static void main(String[] args) {
		System.out.println("httpRequesterClass");
		httpRequester h = new httpRequester();
		String feedRssXml = h.getFeedRss("https://rss.nytimes.com/services/xml/rss/nyt/Business.xml");
		System.out.println(feedRssXml);
	}
}

/**
 * Esta clase se encarga de crear una conexión con un servidor específico y leer 
 * la respuesta del mismo.
 */
class Connection {
	private HttpURLConnection con;

	/**
	 * Genera una conexión con el servidor especificado en urlFeed y con el método
	 * especificado en method. Realiza un pedido utilizando el método indicado.
	 * 
	 * @param urlFeed url del servidor
	 * @param method método de la conexión
	 */
	public Connection(String urlFeed, String method) {
		try {
			URL url = new URL(urlFeed);
			this.con = (HttpURLConnection) url.openConnection();
			this.con.setRequestMethod(method);
		} catch (Exception e) {
			System.out.println("Error al generar la conexión con el servidor");
		}
	}

	/**
	 * Realiza un pedido de feed al servidor de noticias y devuelve el feed en formato XML
	 * @return feed en formato XML procesado como String
	 */
	public String getRss() {
		String rss = null;
		try {
			return readResponse();
		} catch (Exception e) {
			System.out.println("Error al leer la respuesta del servidor");
		}
		return rss;
	}

	/**
	 * Lee la respuesta del servidor
	 * @return respuesta del servidor
	 */
	private String readResponse() {
		String response = null;
		try {
			int status = this.con.getResponseCode();
			response = "Response Code: " + status;
			if (status == HttpURLConnection.HTTP_OK) {
				BufferedReader in = new BufferedReader(new InputStreamReader(this.con.getInputStream()));
				String inputLine;
				StringBuffer content = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					content.append(inputLine);
				}
				in.close();
				response = content.toString();
			}
		} catch (Exception e) {
			System.out.println("Error al leer la respuesta del servidor");
		}

		return response;
	}

	/**
	 * Desconecta la conexión con el servidor
	 */
	public void disconnect() {
		this.con.disconnect();
	}
}